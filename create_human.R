## Sheila Wachiye
## 'human' dataset originally from the United Nations Development Programme.
## More info visit http://hdr.undp.org/en/content/human-development-index-hdi

## Setting up the scene and loading the packages
rm(list=ls())
library(readxl)
library(base)
library(dplyr)

## Loading data
human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", header=T, sep=",")
str(human)
dim(human)

## mutating GNI
library(stringr)
human$GNI <- as.numeric(str_replace(human$GNI, pattern=",", replace =""))

#Excluding some variables
keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- dplyr::select(human, one_of(keep))

## removing all rows with missing values
human <- human[complete.cases(human), ]

## removing observations related to regions instead of countries
last <- nrow(human) - 7
human <- human[1:last,]

# define row names by county and removing country column
rownames(human) <- human$Country
human <- select(human, -Country)
dim(human)
