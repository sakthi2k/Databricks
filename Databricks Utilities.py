# Databricks notebook source
# All available Utilities
dbutils.help()

# COMMAND ----------

#File System Utilities
dbutils.fs.help()

# COMMAND ----------

display(dbutils.fs.ls("/"))

# COMMAND ----------

display(dbutils.fs.ls("/Volumes/workspace/default/sample_csv_data/customers.csv"))

# COMMAND ----------

display(dbutils.fs.head("dbfs:/Volumes/workspace/default/sample_csv_data/customers.csv"))

# COMMAND ----------

dbutils.fs.mkdirs("/Volumes/workspace/default/sample_csv_data/files")

# COMMAND ----------

#copy the file from one path to another path
dbutils.fs.cp("dbfs:/Volumes/workspace/default/sample_csv_data/customers.csv", "/Volumes/workspace/default/sample_csv_data/files/")

# COMMAND ----------

dbutils.fs.ls("/Volumes/workspace/default/sample_csv_data/files")

# COMMAND ----------

#Widgets
dbutils.widgets.help()

# COMMAND ----------

dbutils.widgets.text("input_cust_id","1000", "Customer_id")

# COMMAND ----------

dbutils.widgets.get("input_cust_id")

# COMMAND ----------

# MAGIC %sql
# MAGIC Select ${input_cust_id};

# COMMAND ----------

#Securts
dbutils.secrets.help()

# COMMAND ----------

#notebook Utilities
dbutils.notebook.help()

# COMMAND ----------

