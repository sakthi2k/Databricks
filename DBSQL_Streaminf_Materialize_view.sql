-- Databricks notebook source
---Streaming table
CREATE OR REFRESH STREAMING TABLE DEV.BRONZE.ORDERS_ST
AS
SELECT * FROM 
STREAM read_files(
    "/Volumes/dev/bronze/landing/input",
    format=>'csv',
    includeExistingFiles => false
)

-- COMMAND ----------

desc extended  DEV.BRONZE.ORDERS_ST;

-- COMMAND ----------

REFRESH STREAMING TABLE  DEV.BRONZE.ORDERS_ST;

-- COMMAND ----------

select * from  DEV.BRONZE.ORDERS_ST;

-- COMMAND ----------

---MATERIZED VIEW
CREATE OR REPLACE MATERIALIZED VIEW DEV.BRONZE.ORDERS_MV
AS
SELECT UnitPrice

, SUM(Quantity)
FROM DEV.BRONZE.ORDERS_ST
GROUP BY 1;

-- COMMAND ----------

SELECT datediff(current_date(), '2026-06-10');

-- COMMAND ----------

select * from dev.bronze.orders_raw_metric_view