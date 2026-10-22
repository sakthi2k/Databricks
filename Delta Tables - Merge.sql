-- Databricks notebook source
-- Create schema if not exists
CREATE SCHEMA IF NOT EXISTS dev.bronze;

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS dev.bronze.employee (
    emp_id INT,
    emp_name STRING,
    dept_code STRING,
    salary DECIMAL(10,2)
);

-- COMMAND ----------

DELETE FROM  dev.bronze.employee;

-- COMMAND ----------

-- Insert sample records
INSERT INTO dev.bronze.employee VALUES
(101, 'John', 'HR', 55000.00),
(102, 'Alice', 'IT', 72000.00),
(103, 'Michael', 'FIN', 68000.00),
(104, 'Sophia', 'MKT', 61000.00),
(105, 'David', 'OPS', 59000.00);

-- COMMAND ----------

select * from dev.bronze.employee;

-- COMMAND ----------

-- Create emp_update table with same schema
CREATE TABLE IF NOT EXISTS dev.bronze.emp_update (
    emp_id INT,
    emp_name STRING,
    dept_code STRING,
    salary DECIMAL(10,2)
);

-- COMMAND ----------

-- Updated salary for existing employee 101
INSERT INTO dev.bronze.emp_update VALUES
(101, 'John', 'HR', 60000.00);

-- Updated salary for existing employee 103
INSERT INTO dev.bronze.emp_update VALUES
(103, 'Michael', 'FIN', 75000.00);

-- New employee record
INSERT INTO dev.bronze.emp_update VALUES
(106, 'Emma', 'IT', 67000.00);

-- COMMAND ----------

select * from dev.bronze.emp_update;

-- COMMAND ----------

-- merge data to update the existing record and insert new record


MERGE INTO dev.bronze.employee e   --- target table
USING dev.bronze.emp_update u
ON e.emp_id = u.emp_id
WHEN MATCHED THEN
UPDATE SET
e.salary = u.salary
WHEN NOT MATCHED THEN
--INSERT *        ---> IT WILL INSERT ALL RECORDS
-- INSERT(EMP_ID, EMP_NAME,DEPT_CODE,SALARY)
INSERT *;   --- IF WE HAVE SAME SCHEMA FOR BOTH TABLE


-- COMMAND ----------

SELECT * FROM DEV.BRONZE.EMPLOYEE;

-- COMMAND ----------

-- merge data to update the existing record and insert new record


MERGE INTO dev.bronze.employee e   --- target table
USING dev.bronze.emp_update u
ON e.emp_id = u.emp_id
WHEN MATCHED THEN
UPDATE SET
e.salary = u.salary
WHEN NOT MATCHED THEN
INSERT *
WHEN NOT MATCHED BY SOURCE THEN
DELETE;

-- COMMAND ----------

SELECT * FROM DEV.BRONZE.EMPLOYEE;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Soft Delete

-- COMMAND ----------

ALTER TABLE DEV.BRONZE.EMPLOYEE 
ADD COLUMN is_active char(1);

-- COMMAND ----------

DESC TABLE DEV.BRONZE.EMPLOYEE;

-- COMMAND ----------

-- DBTITLE 1,Cell 16
-- merge data to update the existing record and insert new record


MERGE INTO dev.bronze.employee e   --- target table
USING dev.bronze.emp_update u
ON e.emp_id = u.emp_id

WHEN MATCHED THEN
UPDATE SET
e.salary = u.salary,
e.is_active = 'Y'

WHEN NOT MATCHED THEN
INSERT (emp_id,
emp_name,
dept_code,
salary,
is_active
)
VALUES(
  u.emp_id,
u.emp_name,
u.dept_code,
u.salary,
'Y'
)

WHEN NOT MATCHED BY SOURCE THEN
UPDATE  SET e.is_active ='N';

-- COMMAND ----------

select * from dev.bronze.employee

-- COMMAND ----------

