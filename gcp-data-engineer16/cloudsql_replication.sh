gcloud sql instances create main-db --database-version=POSTGRES_14 --region=us-central1 --tier=db-g1-small
gcloud sql instances create replica-db --master-instance-name=main-db  --region=us-east1  --tier=db-g1-small
gcloud sql instances promote-replica replica-db
gcloud sql instances create main-db-regional --database-version=POSTGRES_14 --region=us-central1 --tier=db-g1-small --availability-type=REGIONAL
gcloud sql instances failover main-db-regional
