# Sheila Wachiye
# November 5 2020

# Introduction to Regerssion modelling and model validation

#Read the learning2014 data and assigh it a new name "data"
data <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
colnames(data)
# The dimensions of the data
dim(data)

# The structure of the data
str(data)

# Access the dplyr library
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(data, one_of(deep_questions))
data$Deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(data, one_of(surface_questions))
data$Surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(data, one_of(strategic_questions))
data$Stra <- rowMeans(strategic_columns)

str(data)

# Assess the new column names 
colnames(data)

# select the columns to keep
new_columns <- c("gender","Age","Attitude", "Deep", "Stra", "Surf", "Points")

# select the 'new_columns' to create a new dataset
learning2014 <- select(data, one_of(new_columns))

# Change "gender into "Gender". To have all column names start with a capital
colnames(learning2014)[1] = "Gender"

# see the stucture of the new dataset
str(learning2014)


