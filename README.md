# E-Commerce ELT Data Pipeline
## Overview
This project demonstrates a complete **ELT pipeline** for an **e-commerce dataset** sourced from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce?select=olist_products_dataset.csv). The pipeline showcases **data engineering capabilities**, including raw data extraction, transformation into a **star schema** data warehouse model, and loading for analytical purposes. It uses modern data engineering tools and practices to deliver a robust, scalable, and maintainable solution.
## Key Features
- **Data Warehouse Design**: Implements a **star schema** for optimized querying and analytics, featuring a **fact table** and multiple **dimension tables**.
- **Modular ELT Workflow**:
  - **Extract**: Data ingestion from the e-commerce dataset.
  - **Load**: Data stored in **Snowflake**, a modern cloud-based data warehouse.
  - **Transform**: Data transformation using **dbt** to clean, model, and create a star schema.
- Orchestration with **Apache Airflow**: Automates the pipeline execution in a **Dockerized environment**.
- **Dockerized Setup**: Ensures portability and reproducibility across systems.
## Tools and Technologies
- **Python**: Core programming language for the project.
- **Apache Airflow**: Orchestrates the ELT pipeline.
- **dbt (Data Build Tool)**: Handles SQL-based transformations.
- **Snowflake**: Cloud-based data warehouse for data storage and analytics.
- **Docker**: Containerizes the environment for consistent development and deployment
## Star Schema Design
The **star schema** organizes the data warehouse for efficient analytical querying.
### Fact Table
- `fact_sales`: Contains transactional data, including order details, payments, and shipping information.
### Dimension Tables
1. `dim_customers`: Customer-related attributes such as location and demographics.
2. `dim_sellers`: Seller-related information, including locations.
3. `dim_products`: Product details, including categories and dimensions.
4. `dim_geolocation`: Geographical information for customers and sellers.
5. `dim_time`: Temporal data for time-series analysis.
6. `dim_reviews`: Customer reviews and ratings.
## Learning Outcomes
This project highlights:
- Expertise in modern **ELT workflows**.
- Design and implementation of a **star schema** for data warehouses.
- Integration of **dbt**, **Airflow**, and **Snowflake** in a cohesive pipeline.
- Dockerized development for portability.
