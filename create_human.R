## Setting up the scene and loading the packages
rm(list=ls())
library(readxl)
library(base)
library(plyr)
library(dplyr)

## Loading Human development data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", 
               stringsAsFactors = F)
# Exploring  the data structure and dimension
str(hd)
dim(hd)
summary(hd)


## Loading the Gender inequality data
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", 
                stringsAsFactors = F, na.strings = "..")
# Exploring the gender data structure and dimension
str(gii)
dim(gii)
head(gii)
summary(gii)


## Simplifying the column names
colnames(hd) <- c("Rank", "Country", "HDI", "LEAB", "EYE", "MYE", "GNI", "GNI-HDI") 
colnames(gii) <- c("Rank", "Country", "GII", "MMR", "ABR", "PRP", "edu2F", "edu2M", "labF", "labM") 


## Mutate the Gender inequality data to create two new variables. 
# Ratio of Female and Male populations with secondary education in each country
gii <- mutate(gii, edu_ration=  edu2F / edu2M)
# Ratio of labour force participation of females and males in each country
gii <- mutate(gii, lab_ration=  labF / labM)


## Join together the two datasets using the variable Country 
human <- inner_join(gii, hd, by="Country")

## Confirming that the dimension of human dataframe is 195 rows and 19 variables
dim(human)
