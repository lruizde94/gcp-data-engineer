python3 wordcount.py --runner DataflowRunner --project gcp-data-engineer-curso-05 --region us-central1 --staging_location gs://gcs-bucket-curso-05/staging/ --temp_location gs://gcs-bucket-curso-05/temp/ --template_location gs://gcs-bucket-curso-05/templates/wordcount_template

pip install apache-beam==2.47.0
pip install protobuf==4.24.3

