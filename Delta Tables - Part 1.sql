-- Databricks notebook source
--list catalog
show catalogs;

-- COMMAND ----------

--list catalog
show catalogs like 'dev*';

-- COMMAND ----------

create catalog dev_exxt;

-- COMMAND ----------

-- list Schemas & tables
show schemas in workspace like 'in*';

-- COMMAND ----------

show tables in workspace.default;

-- COMMAND ----------

-- MAGIC %py
-- MAGIC spark.catalog.tableExists('workspace.default.emp')

-- COMMAND ----------

 CREATE TABLE IF NOT EXISTS dev.bronze.emp(
  f_name string,
  l_name string,
  phone_no bigint,
  address string
 );

-- COMMAND ----------

insert into dev.bronze.emp(f_name,l_name,phone_no, address)values('Apple','orange',1234,'12 chennai');
insert into dev.bronze.emp(f_name,l_name,phone_no, address)values('pineapple','banana',4569,'13 chennai');
insert into dev.bronze.emp(f_name,l_name,phone_no, address)values('billa','kivi',23789,'14 chennai');
insert into dev.bronze.emp(f_name,l_name,phone_no, address)values('thala','mango',97824,'15 chennai');

-- COMMAND ----------

desc history dev.bronze.emp;

-- COMMAND ----------

create temporary view emp_temp_vww
as
select * from dev.bronze.emp;

-- COMMAND ----------

select * from emp_temp_vww;

-- COMMAND ----------

create  view emp_vw
as
select * from dev.bronze.emp;

-- COMMAND ----------

select * from emp_vw

-- COMMAND ----------

create table if not exists dev.bronze.emp_ctas
as
select * from dev.bronze.emp;


-- COMMAND ----------

desc extended dev.bronze.emp_ctas;

-- COMMAND ----------

--deep clone
create table dev.bronze.emp_deep_clone deep clone dev.bronze.emp;

-- COMMAND ----------

desc extended dev.bronze.emp_deep_clone;

-- COMMAND ----------

select * from dev.bronze.emp_deep_clone

-- COMMAND ----------

insert into dev.bronze.emp(f_name,l_name,phone_no, address)values('car','bike',45367,'16 palani');

-- COMMAND ----------

--shallow clone
create table dev.bronze.emp_shallow_clone shallow clone dev.bronze.emp;

-- COMMAND ----------

select * from dev.bronze.emp_shallow_clone;

-- COMMAND ----------

insert into dev.bronze.emp_deep_clone(f_name,l_name,phone_no, address)values('rolls','royace',12364,'18 palani');

-- COMMAND ----------

select * from dev.bronze.emp_deep_clone;