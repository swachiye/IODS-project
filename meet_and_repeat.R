
# Installing
#install.packages("readr")


# Access the packages dplyr and tidyr
library(dplyr)
library(tidyr)
library("readr")

# Read the BPRS and KATS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt",  header = T)


# Save text files to folder 

write.table(BPRS, file = "BPRS.txt", sep = "\t",row.names = TRUE, col.names = NA)
write.table(RATS, file = "RATS.txt", sep = " \t",row.names = TRUE, col.names = NA)



# Assess the column names
names(BPRS)
names(RATS)

# Look at the structureS
str(BPRS)
str(RATS)

# Print out summaries of the variables

summary(BPRS)
head(BPRS)
summary(RATS)

# Convert the categorical variables of both data sets to factors. (1 point)

# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
head(BPRSL)


RATSL <-  RATS %>% gather(key = WD, value = wd, -ID, -Group)
head(RATSL)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# Extract the week number
RATSL <-  RATSL %>% mutate(time = as.integer(substr(WD,3,4)))

# Look at column name
names(BPRSL)
names(RATSL)

# Assess the structure
str(BPRSL)
str(RATSL)

# summaries of the variables
summary(BPRSL)
summary(RATSL)


# Take a glimpse at the BPRSL data
glimpse(BPRSL)
glimpse(RATSL)

getwd()
# Save text files to folder 

# Save text files to folder 
write.table(BPRSL, file = "BPRSL.txt", sep = "\t",row.names = TRUE, col.names = NA)
write.table(RATSL, file = "RATSL.txt", sep = " \t",row.names = TRUE, col.names = NA)


