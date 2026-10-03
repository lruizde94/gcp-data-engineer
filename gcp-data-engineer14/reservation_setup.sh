bq mk --reservation --project_id=gcp-data-engineer-curso-13 --slots=100 --location=US myreservation

bq mk --reservation --project_id=gcp-data-engineer-curso-13 --location=US --slots=200 myflexreservation

bq mk --reservation_assignment --reservation_id=gcp-data-engineer-curso-13:US.myreservation --assignee_type=PROJECT --assignee_id=gcp-data-engineer-curso-13 --job_type=QUERY