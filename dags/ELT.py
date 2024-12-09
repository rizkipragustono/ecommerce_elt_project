from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator
from airflow.providers.snowflake.hooks.snowflake import SnowflakeHook
from datetime import datetime, timedelta
import os

default_args = {
    'owner': 'Rizki',
    'retries': 0
    # 'retries': 1,
    # 'retry_delay': timedelta(minutes=3)
}

def truncate_table(*table_name):
    hook = SnowflakeHook(snowflake_conn_id='snowflake')
    conn = hook.get_conn()
    cursor = conn.cursor()

    cursor.execute("USE DATABASE ECOMMERCE_DB")
    cursor.execute("USE SCHEMA ECOMMERCE_SCHEMA")

    for table in table_name:
        cursor.execute(f"TRUNCATE TABLE IF EXISTS {table}")

    cursor.close()
    conn.close()

def load_multiple_tables_to_snowflake(**kwargs):
    """Upload multiple CSVs and load into Snowflake tables."""
    # Define base directory for datasets
    dataset_dir = "/opt/airflow/datasets"
    
    # Define table mappings
    table_mapping = {
        "olist_customers_dataset.csv": "olist_customers_dataset",
        "olist_geolocation_dataset.csv": "olist_geolocation_dataset",
        "olist_order_items_dataset.csv": "olist_order_items_dataset",
        "olist_order_payments_dataset.csv": "olist_order_payments_dataset",
        "olist_order_reviews_dataset.csv": "olist_order_reviews_dataset",
        "olist_orders_dataset.csv": "olist_orders_dataset",
        "olist_products_dataset.csv": "olist_products_dataset",
        "olist_sellers_dataset.csv": "olist_sellers_dataset",
        "product_category_name_translation.csv": "product_category_name_translation",
    }
    
    # Initialize Snowflake connection
    hook = SnowflakeHook(snowflake_conn_id='snowflake')
    conn = hook.get_conn()
    cursor = conn.cursor()

    # Loop through files and load them into corresponding tables
    for file_name, table_name in table_mapping.items():
        file_path = os.path.join(dataset_dir, file_name)

        # Upload file to Snowflake stage
        put_query = f"PUT file://{file_path} @ecommerce_stage AUTO_COMPRESS=TRUE;"
        cursor.execute(put_query)

        # Load data into the table
        copy_query = f"""
        COPY INTO ECOMMERCE_DB.ECOMMERCE_SCHEMA.{table_name}
        FROM @ecommerce_stage/{file_name.split('/')[-1]}
        FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);
        """
        cursor.execute(copy_query)

    cursor.close()
    conn.close()

with DAG(
    dag_id='ELT_Ecommerce',
    default_args=default_args,
    description='End to end e-commerce data pipeline using Apache Airflow, dbt, Snowflake, Python, and Docker',
    schedule=None,
    start_date=datetime(2014,1,1),
    catchup=False
)as dag:
    
    download = BashOperator(
        task_id="download_data",
        bash_command="scripts/download_data.sh"
    )

    truncate = PythonOperator(
        task_id='truncate_table',
        python_callable=truncate_table,
        op_args=['olist_customers_dataset', 'olist_geolocation_dataset', 
                 'olist_order_items_dataset', 'olist_order_payments_dataset',
                 'olist_order_reviews_dataset', 'olist_orders_dataset',
                 'olist_products_dataset', 'olist_sellers_dataset',
                 'product_category_name_translation']
    )

    load = PythonOperator(
        task_id='load_to_snowflake',
        python_callable=load_multiple_tables_to_snowflake
    )

    dbt_run= BashOperator(
        task_id='dbt_run',
        bash_command='scripts/dbt_run.sh'
    )

    delete = BashOperator(
        task_id='delete_old_file',
        bash_command="scripts/delete_old_data.sh"
    )

    download >> truncate >> load >> dbt_run >> delete