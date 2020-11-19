library(readxl)
library(base)
library(plyr)
# Load Data

# Human development
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", 
               stringsAsFactors = F)
# Assess the data structure and dimnesion
str(hd)
dim(hd)
summary(hd)


#Gender inequality
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", 
                stringsAsFactors = F, na.strings = "..")
# Assess the data
str(gii)
dim(gii)
head(gii)
summary(gii)


### change the column names
colnames(hd) <- c("Rank", "Country", "HDI", "LEAB", "EYE", "MYE", "GNI", "GNI-HDI") 
colnames(gii) <- c("Rank", "Country", "GII", "MMR", "ABR", "PRP", "edu2F", "edu2M", "labF", "labM") 



# Mutate the “Gender inequality” data and create two new variables. 
#The first one should be the ratio of Female and Male populations with secondary education in each country
gii <- mutate(gii, edu_ration=  edu2F / edu2M)

# the ratio of labour force participation of females and males in each country
gii <- mutate(gii, lab_ration=  labF / labM)



#Join together the two datasets using the variable Country as the identifier. Keep only the countries in both data sets (Hint: inner join). 
#The joined data should have 195 observations and 19 variables. Call the new joined data "human" and save it in your data folder. (1 point)

# Join two data sets using common variables as (student) identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

