#Name: Sheila Wachiye
#Date: 12/11/2020

# File data: Student Performance Data

# Read data
setwd("C:/LocalData/swachiye/New2019/plot/pp/IODS-project/data")

# Read "student-mat.csv" data and assess structure and dimensions
Math <- read.table("student-mat.csv",sep=";",header=TRUE)
str(Math)
dim(Math)

# Read "student-por.csv" data and assess structure and dimensions
Por <- read.table("student-por.csv",sep=";",header=TRUE)
str(Por)
dim(Por)

# access the dplyr library
library(dplyr)

# Join two data sets using the variables as (student) identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# Join the two datasets by the selected identifiers
Math_Por <- inner_join(Math, Por, by = join_by, suffix = c(".math", ".por"))

# Assess the new column names
colnames(Math_Por)

# Explore the structure and dimensions of the joined data.
glimpse(Math_Por)
str(Math_Por)
dim(Math_Por)


