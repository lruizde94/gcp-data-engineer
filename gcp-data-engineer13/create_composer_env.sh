gcloud composer environments create my-composer-env --location=us-central1 --image-version=composer-3-airflow-2.10.5

gcloud composer environments storage dags import --environment mi-entorno-composer --location us-central1 --source dag.py