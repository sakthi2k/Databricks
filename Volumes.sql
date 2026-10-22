-- Databricks notebook source
CREATE VOLUME IF NOT EXISTS dev.bronze.managed_vol
COMMENT 'This is a managed volume';

-- COMMAND ----------

DESC VOLUME  dev.bronze.managed_vol;

-- COMMAND ----------

-- MAGIC %sh
-- MAGIC ls -lrt

-- COMMAND ----------

-- MAGIC %sh
-- MAGIC wget https://media.githubusercontent.com/media/subhamkharwal/pyspark-zero-to-hero/refs/heads/master/datasets/emp.csv

-- COMMAND ----------

-- MAGIC %sh
-- MAGIC pwd

-- COMMAND ----------

-- MAGIC %python
-- MAGIC dbutils.fs.mkdirs("/Volumes/dev/bronze/managed_vol/files")

-- COMMAND ----------

-- MAGIC %py
-- MAGIC #first path is src one and second one is target where we have copy the file
-- MAGIC dbutils.fs.cp("/Workspace/Users/sakthisaravanancse@gmail.com/Databricks_Ease_With_Data/emp.csv",
-- MAGIC         "/Volumes/dev/bronze/managed_vol/files")

-- COMMAND ----------

select * from csv.`/Volumes/dev/bronze/managed_vol/files/emp.csv`;

-- COMMAND ----------

DROP VOLUME dev.bronze.managed_vol;

-- COMMAND ----------

