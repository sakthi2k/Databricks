# Databricks notebook source
dbutils.fs.head("/databricks-datasets/retail-org/company_employees/company_employees.csv")

# COMMAND ----------

#create Parameter dept
dbutils.widgets.text("dept","","Department_Name")

# COMMAND ----------

#get the parameter value in a variable _dept
_dept =  dbutils.widgets.get("dept")

# COMMAND ----------

#print the parameter value
print(_dept)

# COMMAND ----------

#read all data  through saprk
df = spark.read.csv("/databricks-datasets/retail-org/company_employees/company_employees.csv", header = True)

# COMMAND ----------

display(df)

# COMMAND ----------

#filter data based in department and active_record
df_filtered = df.where(f"upper(department) = upper('{_dept}') and active_record ='1'")

# COMMAND ----------

display(df_filtered)

# COMMAND ----------

#write data tp delta table with department name
_count = df_filtered.count()
if _count >0:
    df_filtered.write.mode("overwrite").saveAsTable(f"dev.bronze.dept_{_dept}")
    print(f"Data written for {_dept}")
    display(spark.table(f"dev.bronze.dept_{_dept}"))
else:
    print(f"No data for{_dept}")

# COMMAND ----------

#Exit status as - number of records written
dbutils.notebook.exit(_count)

# COMMAND ----------

