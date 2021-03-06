# Title : Data Wrangling
# Author: Sheila Wachiye
# Data :  November 5 2020

# Introduction to Regression analysis and model validation

#Read the learning2014 data and assigh it a new name "DataLrn14"
DataLrn14 <- read.table("https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
colnames(DataLrn14)
# The dimensions of the DataLrn14
dim(DataLrn14)

# The structure of the DataLrn14
str(DataLrn14)

# Access the dplyr library
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(DataLrn14, one_of(deep_questions))
DataLrn14$Deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(DataLrn14, one_of(surface_questions))
DataLrn14$Surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(DataLrn14, one_of(strategic_questions))
DataLrn14$Stra <- rowMeans(strategic_columns)

str(DataLrn14)

# Assess the new column names 
colnames(DataLrn14)

# select the columns to keep
new_columns <- c("gender","Age","Attitude", "Deep", "Stra", "Surf", "Points")

# select the 'new_columns' to create a new dataset
learning2014 <- select(DataLrn14, one_of(new_columns))

# Change "gender into "Gender". To have all column names start with a capital
colnames(learning2014)[1] = "Gender"

# Exclude observations where the exam points variable is zero
learning2014 <- filter(learning2014, Points > 0)

# Look at the stucture of the new dataset
str(learning2014)

#Save the learning2014 dataset as .csv into the ‘data’ folder
write.csv(learning2014, "learning2014.csv") 

# Read the new dataset "learning2014.csv"
NewDataLrn14 <- read.csv("learning2014.csv")

# Assess the top values of the datasets
head(NewDataLrn14)

#Look at the structure
str(NewDataLrn14)




