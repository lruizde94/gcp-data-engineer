# create_zones.py
# Script para crear un Data Lake en Dataplex y sus zonas de dominio con buckets en GCS
# usando las librerías oficiales de Google Cloud.
#
# Uso:
# python create_zones.py --project_id my-project --region us-central1 --lake retail-lake --domains ventas marketing logistica

import argparse
from google.cloud import storage
from google.cloud import dataplex_v1
import time


def create_bucket(project_id: str, region: str, bucket_name: str):
    """Crea un bucket en Cloud Storage."""
    storage_client = storage.Client(project=project_id)
    bucket = storage_client.bucket(bucket_name)
    if not bucket.exists():
        bucket = storage_client.create_bucket(bucket, location=region)
        print(f"✅ Bucket creado: {bucket.name}")
    else:
        print(f"ℹ️ Bucket {bucket_name} ya existe")
    return bucket.name


def create_lake(project_id: str, region: str, lake_name: str):
    """Crea un Data Lake en Dataplex."""
    client = dataplex_v1.DataplexServiceClient()
    parent = f"projects/{project_id}/locations/{region}"
    lake_id = lake_name

    lake = dataplex_v1.Lake()
    lake.display_name = "Data Mesh Lake"
    lake.description = "Data Lake para arquitectura Data Mesh"

    operation = client.create_lake(
        parent=parent,
        lake_id=lake_id,
        lake=lake,
    )

    response = operation.result(timeout=600)
    print(f"✅ Data Lake creado: {response.name}")
    return response.name


def create_zone(project_id: str, region: str, lake_name: str, domain: str, bucket_name: str):
    """Crea una zona de datos en Dataplex y la asocia a un bucket de GCS."""
    client = dataplex_v1.DataplexServiceClient()
    parent = f"projects/{project_id}/locations/{region}/lakes/{lake_name}"
    zone_id = f"{domain}-zone"

    # Definición de la zona con resource_spec
    zone = dataplex_v1.Zone(
        display_name=f"{domain.capitalize()} Zone",
        description=f"Zona de dominio {domain}",
        type_=dataplex_v1.Zone.Type.RAW,  # RAW o CURATED
        resource_spec=dataplex_v1.Zone.ResourceSpec(
            location_type=dataplex_v1.Zone.ResourceSpec.LocationType.SINGLE_REGION
        ),
        discovery_spec=dataplex_v1.Zone.DiscoverySpec(
            enabled=True
        ),
    )

    # Crear zona
    operation = client.create_zone(
        parent=parent,
        zone_id=zone_id,
        zone=zone,
    )
    response = operation.result(timeout=300)
    print(f"✅ Zona creada: {response.name}")

    # Asociar bucket como asset
    asset_id = f"{domain}-asset"
    asset = dataplex_v1.Asset(
        display_name=f"{domain.capitalize()} Asset",
        description=f"Asset para datos de {domain}",
        resource_spec=dataplex_v1.Asset.ResourceSpec(
            type_=dataplex_v1.Asset.ResourceSpec.Type.STORAGE_BUCKET,
            name=f"projects/{project_id}/buckets/{bucket_name}"
        ),
    )

    operation_asset = client.create_asset(
        parent=f"{parent}/zones/{zone_id}",
        asset_id=asset_id,
        asset=asset,
    )
    asset_response = operation_asset.result(timeout=300)
    print(f"✅ Asset creado y vinculado al bucket: {asset_response.name}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Crear lago y zonas en Dataplex (Data Mesh)")
    parser.add_argument("--project_id", required=True, help="ID del proyecto GCP")
    parser.add_argument("--region", required=True, help="Región (ej: us-central1)")
    parser.add_argument("--lake", required=True, help="Nombre del Data Lake")
    parser.add_argument("--domains", nargs="+", required=True, help="Lista de dominios (ej: ventas marketing logistica)")

    args = parser.parse_args()

    print(f"📦 Creando Data Lake [{args.lake}] en proyecto [{args.project_id}], región [{args.region}]...")
    #create_lake(args.project_id, args.region, args.lake)

    for domain in args.domains:
        bucket_name = f"{args.project_id}-{domain}-zone"
        print(f"🌐 Creando zona y bucket para dominio: {domain}")
        create_bucket(args.project_id, args.region, bucket_name)
        time.sleep(30)  # Esperar un poco para asegurar que el bucket esté listo
        create_zone(args.project_id, args.region, args.lake, domain, bucket_name)
        time.sleep(30)  # Esperar un poco para asegurar que la zona esté lista

    print("🎉 ¡Data Mesh creado con éxito en GCP!")
