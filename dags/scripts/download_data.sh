#!/bin/bash
# Ensure the dataset directory exists
mkdir -p /opt/airflow/datasets

# Navigate to the dataset directory
cd /opt/airflow/datasets

# Download dataset using Kaggle CLI
kaggle datasets download olistbr/brazilian-ecommerce -p . --force

# Extract the downloaded zip file
unzip -o brazilian-ecommerce.zip