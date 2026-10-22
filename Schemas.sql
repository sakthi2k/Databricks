-- Databricks notebook source
--create schema without  external  location in dev catalog
create schema dev.bronze
comment' this schema in dev catalog without external location';

-- COMMAND ----------

--create schema without  external  location in dev_ext catalog
create schema dev.bronze
comment' this schema in dev_ext catalog without external location';

-- COMMAND ----------

--create external location for schema
CREATE EXTERNAL LOCATION `EXT_SCHEMA`
URL 'url path'
WITH(STORAGE CREDENTIAL `sc_catalog_storange`)
;

-- COMMAND ----------

-- create schema with external location in dev_ext catalog
create schema dev_ext.bronze_ext
MANAGED LOCATION 'LOCATION PATH'
COMMENT ' tHIS SCHEMA IN DEV EXT CATALOG WITHEXTRENAL LOCATION';

-- COMMAND ----------

-- three level name space

CREATE TABLE DEV.BRONZE.RAW_SALE(
  invoice_id string,
  cust_id string,
   QTY Double,
  price double
);

/*
DEV --> is catalog name
BRONZE --> is a schema name
RAW_SALE--> is a table name
*/

-- COMMAND ----------

CREATE TABLE DEV_EXT.BRONZE_ext.RAW_SALE(
  invoice_id string,
  cust_id string
  , QTY Double,
  price double
);

/*
DEV --> is catalog name
BRONZE --> is a schema name
RAW_SALE--> is a table name
*/