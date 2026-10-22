# Databricks notebook source
 count = dbutils.notebook.run(
    "Write_Emp_Data",
    600,  # is a sconds
    {"dept" : "office"}  # Dictionary type
)

# COMMAND ----------

print(f"Child notebook count:{count}")

# COMMAND ----------

