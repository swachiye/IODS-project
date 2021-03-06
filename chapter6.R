
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
#write.csv(BPRS,  "BPRS.csv")
#write.table(BPRS, file = "BPRS.txt", sep = "\t",row.names = TRUE, col.names = NA)
#write.table(RATS, file = "RATS.txt", sep = " \t",row.names = TRUE, col.names = NA)



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


RATSL <-  RATS %>% gather(key = WD, value = weight, -ID, -Group)
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


# Take a glimpse at the data
glimpse(BPRSL)
glimpse(RATSL)
names(RATSL)
colnames(RATSL) <- c("ID",  "Group" , "WD"  ,   "weight" ,"time"  )

## Analysis of RATSL data
library(ggplot2)
p1 <- ggplot(RATSL, aes(x=time, y=weight, group=ID)) + geom_line() + facet_grid(.~Group, labeller = label_both)
p1

##Fig 8.2 equivalent
# Standardize the scores
RATSL <- RATSL %>%
  group_by(time) %>%
  mutate(stdwd = (wd-mean(weight))/sd(weight))%>%
  ungroup()
glimpse(RATSL)
p2 <- ggplot(RATSL, aes(x=time, y=stdwd, linetype=ID)) + geom_line() + facet_grid(.~Group, labeller = label_both)
p2

#Fig 8.3 Equivalent
n <- RATSL$time %>% unique() %>% length()
RATSS <- RATSL %>%
  group_by(weight, time) %>%
  summarise(mean=mean(wd), se=sd(wd)/sqrt(n)) %>%
  ungroup()

#Fig 8.4 Equivalent
p1 <- ggplot(RATSL, aes(x = factor(time), y = weight, fill = Group)) + geom_boxplot(position = position_dodge(width = 0.9))
p1

# Fig 8.5
RATSL8S <- RATSL %>%
  filter(time > 0) %>%
  group_by(Group, ID) %>%
  summarise( mean=mean(weight) ) %>%
  ungroup()
p1 <- ggplot(RATSL8S, aes(x = Group, y = mean)) + geom_boxplot()
p1

#Table 8.3
fit <- lm(mean ~ Group, data = RATSL8S)
summary(fit)
anova(fit)

## Analysis of BPRSL Data
glimpse(BPRSL)
##Fig 9.1
p1 <- ggplot(RATSL, aes(x = week, y = bprs, group = ID)) 
p1
  
  #Table 9.2
  BPRS_reg <- lm(bprs ~ week + treatment, data = BPRSL)
summary(BPRS_reg)

#Fig 9.2 
p1 <- ggplot(BPRSL, aes(x = week, y = bprs, group = treatment)) + geom_line(aes(linetype = treatment))
p1

BPRSS <- BPRSL %>%
  group_by(treatment, week) %>%
  summarise( mean=mean(bprs), se=sd(bprs)/sqrt(n) ) %>%
  ungroup()

p1 <- ggplot(BPRSS, aes(x = week, y = mean, linetype = treatment, shape = treatment))+geom_line() + geom_point(size=3) +
  geom_errorbar(aes(ymin=mean-se, ymax=mean+se, linetype="1"), width=0.3)

p1
