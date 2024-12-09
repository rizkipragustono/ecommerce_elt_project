# Use the official Apache Airflow Docker image as the base image
FROM apache/airflow:2.7.1

# Install necessary utilities
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install additional Python packages (e.g., kaggle CLI, dbt-core, dbt-snowflake)
USER airflow
RUN pip install --no-cache-dir \
    kaggle \
    dbt-core \
    dbt-snowflake \
    psycopg2-binary