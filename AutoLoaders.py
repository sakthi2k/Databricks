# Databricks notebook source
dbutils.fs.help()

# COMMAND ----------


dbutils.fs.mkdirs("/Volumes/dev/bronze/landing/autoloader_input/2010/12/01")
dbutils.fs.mkdirs("/Volumes/dev/bronze/landing/autoloader_input/2010/12/02")
dbutils.fs.mkdirs("/Volumes/dev/bronze/landing/autoloader_input/2010/12/03")
dbutils.fs.mkdirs("/Volumes/dev/bronze/landing/autoloader_input/2010/12/04")
dbutils.fs.mkdirs("/Volumes/dev/bronze/landing/autoloader_input/2010/12/05")
dbutils.fs.mkdirs("/Volumes/dev/bronze/landing/autoloader_input/2010/12/06")
dbutils.fs.mkdirs("/Volumes/dev/bronze/landing/autoloader_input/2010/12/07")

# COMMAND ----------

# MAGIC %sql
# MAGIC SHOW GRANTS ON VOLUME dev.bronze.landing;

# COMMAND ----------

display(dbutils.fs.ls("/Volumes/dev/bronze/landing/autoloader_input/2010/12"))

# COMMAND ----------

dbutils.fs.mkdirs("/Volumes/dev/bronze/landing/checkpoint/autoloader")

# COMMAND ----------

dbutils.fs.cp("/databricks-datasets/definitive-guide/data/retail-data/by-day/2010-12-01.csv","/Volumes/dev/bronze/landing/autoloader_input/2010/12/01")
dbutils.fs.cp("/databricks-datasets/definitive-guide/data/retail-data/by-day/2010-12-02.csv","/Volumes/dev/bronze/landing/autoloader_input/2010/12/02")
dbutils.fs.cp("/databricks-datasets/definitive-guide/data/retail-data/by-day/2010-12-03.csv","/Volumes/dev/bronze/landing/autoloader_input/2010/12/03")

# COMMAND ----------

df = (
    spark
    .readStream
    .format("cloudFiles")
    .option("cloudFiles.format", "csv")
    .option("pathGlobFilter", "*.csv")
    .option("header", "true")
    #.option("cloudFiles.useNotifications", True)
    .option("cloudFiles.schemaHints", "Quantity int , UnitPrice double")
    .option("cloudFiles.schemaLocation","/Volumes/dev/bronze/landing/checkpoint/autoloader/1")
    .option("cloudFiles.schemaEvolutionMode", "rescue") # "none"
   # .option("cloudFiles.schemaEvolutionMode", "none") # "none"
    .load("/Volumes/dev/bronze/landing/autoloader_input/*/")
)

# COMMAND ----------

from pyspark.sql.functions import col
(
    df
    .withColumn("__file", col( "_metadata.file_name"))
    .writeStream
    .option("checkpointLocation","/Volumes/dev/bronze/landing/checkpoint/autoloader/1" )
    .outputMode("append")
    .trigger(availableNow = True)
    .toTable("dev.bronze.invoice_al_1")
)

# COMMAND ----------

# MAGIC %sql
# MAGIC select __file from dev.bronze.invoice_al_1 
# MAGIC qualify rank()over(partition by __file order by __file) =1
# MAGIC limit 5;

# COMMAND ----------

# MAGIC %sql
# MAGIC select __file,count(*) from dev.bronze.invoice_al_1
# MAGIC group by 1;

# COMMAND ----------

dbutils.fs.cp("/databricks-datasets/definitive-guide/data/retail-data/by-day/2010-12-05.csv","/Volumes/dev/bronze/landing/autoloader_input/2010/12/05")

# COMMAND ----------

