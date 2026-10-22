-- Databricks notebook source
describe catalog extended dev;

-- COMMAND ----------

create catalog dev_sql
comment 'This catalog is created by using sql';

-- COMMAND ----------

--drop the catalog

drop catalog dev_sql cascade;

-- COMMAND ----------

CREATE EXTERNAL LOCATION `EXT_CATALOG`
URL "https://localhost8080"
WITH (STORAGE CREDENTIAL `SC_CATALOG`)

-- COMMAND ----------

