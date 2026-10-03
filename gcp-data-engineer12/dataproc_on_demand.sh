gcloud projects add-iam-policy-binding gcp-data-engineer-curso-12 --member="user:eduardomartinezagrelo@gmail.com" --role="roles/dataproc.editor"

gcloud dataproc batches submit spark --region=us-central1 --class org.apache.spark.examples.SparkPi --jars file:///usr/lib/spark/examples/jars/spark-examples.jar -- 1000