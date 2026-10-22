-- Databricks notebook source
-- MAGIC %py
-- MAGIC display(dbutils.fs.ls("dbfs:/databricks-datasets/online_retail/data-001/"))

-- COMMAND ----------

SELECT * FROM 
read_files(
  'dbfs:/databricks-datasets/online_retail/data-001/data.csv',
  header =>true,
  format=> 'csv'
)

-- COMMAND ----------

CREATE  TABLE DEV.BRONZE.SALES AS
SELECT * FROM 
read_files(
  'dbfs:/databricks-datasets/online_retail/data-001/data.csv',
  header =>true,
  format=> 'csv'
)

-- COMMAND ----------

SELECT * FROM DEV.BRONZE.SALES

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ###Deletion Vector

-- COMMAND ----------

DESC EXTENDED DEV.BRONZE.SALES;

-- COMMAND ----------

ALTER TABLE DEV.BRONZE.SALES
SET TBLPROPERTIES(delta.enableDeletionVectors = false);

-- COMMAND ----------

delete from DEV.BRONZE.SALES
where invoiceNo ='540644';

-- COMMAND ----------

desc history DEV.BRONZE.SALES;

-- COMMAND ----------

ALTER TABLE DEV.BRONZE.SALES
SET TBLPROPERTIES(delta.enableDeletionVectors = true);

-- COMMAND ----------

delete from DEV.BRONZE.SALES
where invoiceNo ='536368';

-- COMMAND ----------

desc history DEV.BRONZE.SALES;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ###Liquid Clustering
-- MAGIC

-- COMMAND ----------

alter table DEV.BRONZE.SALES CLUSTER BY (InvoiceNo);

-- COMMAND ----------

desc history DEV.BRONZE.SALES;

-- COMMAND ----------

-- to remove cluster
alter table DEV.BRONZE.SALES CLUSTER BY None;

-- COMMAND ----------

-- to mention cluster by column while creating the column

CREATE  TABLE DEV.BRONZE.SALES_CT CLUSTER BY(InvoiceNo)
AS
SELECT * FROM 
read_files(
  'dbfs:/databricks-datasets/online_retail/data-001/data.csv',
  header =>true,
  format=> 'csv'
)

-- COMMAND ----------

desc extended DEV.BRONZE.SALES_CT;

-- COMMAND ----------

select * from DEV.BRONZE.SALES_CT where InvoiceNo='536366'

-- COMMAND ----------

