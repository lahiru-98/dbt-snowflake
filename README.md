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


