from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

# Define the DAG
dag = DAG(
    'dbt_test',  # DAG name
    description='A simple DAG to run dbt test',
    schedule_interval=None,  # This DAG will not run on a schedule, only on trigger
    start_date=datetime(2024, 11, 12),  # Use the current date or modify it
    catchup=False,  # Do not backfill past DAG runs
)

# Task to test the PostgreSQL connection by running a simple query
dbt_test= BashOperator(
    task_id='dbt_test',
    bash_command='scripts/dbt_test.sh',
    dag=dag,
)

# Set the task sequence (though only one task in this case)
dbt_test