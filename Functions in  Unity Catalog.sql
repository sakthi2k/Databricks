-- Databricks notebook source
--- CREATE SCALAR FUNCTION TO CALCUALTE TAX SQL

CREATE OR REPLACE FUNCTION DEV.BRONZE.TAX_SQL(SAL DOUBLE)
RETURNS DOUBLE
LANGUAGE SQL   --- IT'S OPTIONAL
RETURN SAL *0.3

-- COMMAND ----------

-- VALIDATE FUNCTION
select dev.bronze.tax_sql(10000);

-- COMMAND ----------

select * from dev.bronze.emp;

-- COMMAND ----------

select*,dev.bronze.tax_sql(phone_no) as tax from dev.bronze.emp;

-- COMMAND ----------

-- MAGIC %py
-- MAGIC #use in pyspark code
-- MAGIC from pyspark.sql.functions import expr
-- MAGIC df = spark.read.table("dev.bronze.emp")
-- MAGIC df.withColumn("tax", expr('dev.bronze.tax_sql(phone_no)')).display()

-- COMMAND ----------

-- SCALAR FUNCTION FOR API
CREATE OR REPLACE FUNCTION DEV.BRONZE.FRUITE_NUTRITION(FRUITE_NAME STRING)
RETURNS STRING
LANGUAGE PYTHON
AS
$$
import requests as r
api_url = f"https://www/fruityvice.com/api/friu/{fruite_name}"
response = r.get(api_url)
data = response.json()
return str(data.get('nutrition', 'NA'))
$$

-- COMMAND ----------

select DEV.BRONZE.FRUITE_NUTRITION("banana")

-- COMMAND ----------

CREATE OR REPLACE FUNCTION dev.bronze.emp_get(dept int)
RETURNS TABLE(emp_id STRING, emp_name string)
LANGUAGE SQL
RETURN(
    SELECT emp_id,emp_name FROM dev.bronze.employee WHERE EMP_ID = dept
)

-- COMMAND ----------

---VALIDATE FUNCTION
select * from dev.bronze.emp_get("105") -- the out is table so we have use select * from 

-- COMMAND ----------

