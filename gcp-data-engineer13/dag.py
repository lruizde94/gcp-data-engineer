from airflow import DAG
from airflow.providers.google.cloud.operators.bigquery import BigQueryInsertJobOperator
from datetime import datetime

default_args = {
    "start_date": datetime(2025, 1, 1),
    "retries": 1
}

with DAG(
    "orders_pipeline",
    default_args=default_args,
    schedule_interval="@daily",
    catchup=False,
) as dag:

    aggregate_orders = BigQueryInsertJobOperator(
        task_id="aggregate_orders",
        configuration={
            "query": {
                "query": """
                    CREATE OR REPLACE TABLE ecommerce_analysis.daily_summary AS
                    SELECT 
                      DATE(order_date) AS order_day,
                      COUNT(*) AS total_orders,
                      SUM(price) AS total_revenue
                    FROM ecommerce_analysis.orders_raw
                    GROUP BY order_day
                """,
                "useLegacySql": False,
            }
        },
    )