gcloud dataflow jobs run resilient-job \
  --gcs-location gs://dataflow-templates/latest/Word_Count \
  --parameters inputFile=gs://bucket-resiliente/input.txt,output=gs://bucket-resiliente/output
