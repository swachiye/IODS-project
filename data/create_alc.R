#Name: Sheila Wachiye
#Date: 12/11/2020

# File data: Student Performance Data


# Load  library
library(dplyr)
library(ggplot2)

# Read data

setwd("C:/LocalData/swachiye/New2019/plot/pp/IODS-project/data")

# Read "student-mat.csv" data and assess structure and dimensions
Math <- read.table("student-mat.csv",sep=";",header=TRUE)
names(Math)
str(Math)
dim(Math)

# Read "student-por.csv" data and assess structure and dimensions
Por <- read.table("student-por.csv",sep=";",header=TRUE)
names(Por)
str(Por)
dim(Por)



# Join two data sets using common variables as (student) identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# Join the two datasets by the selected common identifiers
Math_Por <- inner_join(Math, Por, by = join_by, suffix = c(".math", ".por"))

# Assess the new column names
colnames(Math_Por)

# Explore the structure and dimensions of the joined data.
glimpse(Math_Por)
str(Math_Por)
dim(Math_Por)

# Create a new data frame with only the joined columns
alc <- select(Math_Por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(Math)[!colnames(Math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'Math_Por' with the same original name
  two_columns <- select(Math_Por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}


# Define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# glimpse at the new combined data
glimpse(alc)

write.csv(alc, "alc.csv") 





















