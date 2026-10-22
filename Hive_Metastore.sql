-- Databricks notebook source
create schema bronze;

-- COMMAND ----------

--Managed Table
CREATE TABLE bronze.emp(
  emp_id int,
  emp_name string,
  dept_code string
);

-- COMMAND ----------

describe extended bronze.emp;

-- COMMAND ----------

insert into bronze.emp(emp_id, emp_name, dept_code) values(1001,"Subhum",'D101');
insert into bronze.emp(emp_id, emp_name, dept_code) values(1002,"Ramesh",'D101');
insert into bronze.emp(emp_id, emp_name, dept_code) values(1003,"Suresh",'D101');

-- COMMAND ----------

-- DBTITLE 1,Query bronze.emp table
SELECT * FROM bronze.emp;

-- COMMAND ----------

--Managed Table
CREATE TABLE bronze.emp_EXT(
  emp_id int,
  emp_name string,
  dept_code string
)
LOCATION 'dbfs:/tmp/emp_ext';

-- COMMAND ----------

drop table bronze.emp;

-- COMMAND ----------

CREATE VIEW bronze.emp_vw
AS
SELECT * FROM BRONZE.EMP WHERE DEPT_CODE='D101';

-- COMMAND ----------

SELECT * FROM bronze.emp_vw;

-- COMMAND ----------

DESC EXTENDED bronze.emp_vw;

-- COMMAND ----------

