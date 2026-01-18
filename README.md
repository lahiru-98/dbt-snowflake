# ❄️ dbt + Snowflake Analytics Engineering Project

## 📌 Overview

This repository contains a **dbt (data build tool) project connected to Snowflake**.  
It is based on the concepts taught in the LinkedIn Learning course:  
[Data Engineering with dbt](https://www.linkedin.com/learning/data-engineering-with-dbt).

This project is primarily for **learning the fundamentals of dbt**, with some personal enhancements:

- The original course uses DuckDB as the data warehouse, but here I have replaced it with **Snowflake** to gain experience with a production-grade cloud warehouse.
- Architectural improvements include maintaining **separate databases for raw, dev, and prod environments** to better simulate real-world workflows.
- The project focuses on transforming raw warehouse data into clean, documented models using modular dbt design (staging → intermediate → marts).
- It also includes implementing data quality tests and enabling scalable analytics workflows.

This repo is intended as a hands-on learning resource and demonstration of dbt best practices adapted for Snowflake.


## 🧠 What This Project Includes

- Source configurations  
- Staging, intermediate and mart models  
- Data quality tests  
- Macros and Jinja templating  
- Auto-generated dbt documentation  
- Lineage graphs  

---


## 📌 Setup Instructions

- You may need to manually load the sample dataset used in this course into Snowflake tables.  
- The SQL scripts for creating databases and granting access permissions are provided in the `snowflake_setup.sql` file.  
- Follow the instructions in the `snowflake_setup.sql` file to set up your Snowflake environment properly before running the dbt models.



### Sample `profiles.yml` configuration

```yaml
my_snowflake_profile:
  outputs:
    dev:
      account: ufb66789
      database: DEV_SLN_DB
      password: '{{ env_var(''SNOWFLAKE_PASSWORD'') }}'
      role: dbt_sf_dev_role
      schema: NYC_PARKING_VIOLATIONS
      threads: 2
      type: snowflake
      user: dbt_user
      warehouse: COMPUTE_WH

    prod:
      account: ufb66789
      database: PROD_SLN_DB
      password: '{{ env_var(''SNOWFLAKE_PASSWORD'') }}'
      role: dbt_sf_prod_role
      schema: NYC_PARKING_VIOLATIONS
      threads: 4
      type: snowflake
      user: dbt_user
      warehouse: TRANSFORMING_WH
  target: dev

```yaml 


## 👤 Author

Lahiru  
https://github.com/lahiru-98

---
