-- Databricks notebook source
CREATE VOLUME dev.bronze.landing;

-- COMMAND ----------

-- MAGIC %py
-- MAGIC dbutils.fs.mkdirs("/Volumes/dev/bronze/landing/input/")

-- COMMAND ----------

-- MAGIC %py
-- MAGIC dbutils.fs.cp("/databricks-datasets/definitive-guide/data/retail-data/by-day/2010-12-01.csv","/Volumes/dev/bronze/landing/input/")

-- COMMAND ----------

-- MAGIC %py
-- MAGIC dbutils.fs.cp("/databricks-datasets/definitive-guide/data/retail-data/by-day/2010-12-02.csv","/Volumes/dev/bronze/landing/input/")

-- COMMAND ----------

CREATE TABLE DEV.BRONZE.INVOICE_CP;

-- COMMAND ----------

-- COPY INTO COMMAND
COPY INTO  DEV.BRONZE.INVOICE_CP 
FROM  "/Volumes/dev/bronze/landing/input"
FILEFORMAT = CSV
PATTERN ='*.csv'             -- TO LOAD ONLY CSV
FORMAT_OPTIONS(              --- src OPTIONS
'mergeSchema' = 'true',      -- to merge schema 
'header' ='true'
)
COPY_OPTIONS( -- target options
'mergeSchema' = 'true'
)

-- COMMAND ----------

select * from DEV.BRONZE.INVOICE_CP limit 5;

-- COMMAND ----------

desc extended DEV.BRONZE.INVOICE_CP;

-- COMMAND ----------

-- create new table with only 3 columns invoice_cp_alt and custom columns_insert_date
CREATE TABLE DEV.BRONZE.invoice_cp_alt(
    InvoiceNo string,
    StockCode string,
    Quantity double,
    _insert_date timestamp
);

-- COMMAND ----------



-- COMMAND ----------

-- load data using copy into in the new table invoice_cp_alt

-- COPY INTO COMMAND
COPY INTO  DEV.BRONZE.invoice_cp_alt 
FROM  (
    select InvoiceNo,StockCode, cast(Quantity as double) as Quantity, current_timestamp() as _insert_date
    from
    "/Volumes/dev/bronze/landing/input"
    )

FILEFORMAT = CSV
PATTERN ='*.csv'             -- TO LOAD ONLY CSV
FORMAT_OPTIONS(              --- src OPTIONS
'mergeSchema' = 'true',      -- to merge schema 
'header' ='true'
)

-- COMMAND ----------

select * from DEV.BRONZE.invoice_cp_alt  limit 5;

-- COMMAND ----------

-- MAGIC %py
-- MAGIC dbutils.fs.cp("/databricks-datasets/definitive-guide/data/retail-data/by-day/2010-12-03.csv","/Volumes/dev/bronze/landing/input/")

-- COMMAND ----------

--to load increamentally

-- COPY INTO COMMAND
COPY INTO  DEV.BRONZE.invoice_cp_alt 
FROM  (
    select InvoiceNo,StockCode, cast(Quantity as double) as Quantity, current_timestamp() as _insert_date
    from
    "/Volumes/dev/bronze/landing/input"
    )

FILEFORMAT = CSV
PATTERN ='*.csv'             -- TO LOAD ONLY CSV
FORMAT_OPTIONS(              --- src OPTIONS
'mergeSchema' = 'true',      -- to merge schema 
'header' ='true'
)


-- COMMAND ----------

select count(1) from DEV.BRONZE.invoice_cp_alt  limit 5;

-- COMMAND ----------


