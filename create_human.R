# Description of 'human' dataset variables. 
# Original data can be accessed from: http://hdr.undp.org/en/content/human-development-index-hdi
# Retrieved, modified and analyzed by Sheila Wachiye 26/11/2020
# The 'human' dataset used in this study is from the United Nations Development Programme Human Development Index (HDI)

# Load necessary package
library(stringr)
library(dplyr)

# Load the huma data
human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep  =",", header = T)

# look at the (column) names of human
names(human)

# the structure of data
str(human)

# print out summaries the data
summary(human)

# Mutate data
mutate(human, GNI = GNI)

# look at the structure of the GNI column in 'human'
str(human$GNI)

# remove the commas from GNI and print out a numeric version of it
str_replace(human$GNI, pattern=",", replace ="")%>% as.numeric(human$GNI)

# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" )

# select the 'keep' columns
human <- select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human1 <- filter(human, complete.cases(human))
head(human_)

# remove the Country variable
human1 <- select(human1, -Country)
head(human1)
dim(human1)
