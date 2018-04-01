#load library
library(readr)
library(dplyr)
#install package
install.packages("dplyr")
install.packages("tidyverse")

#load data, assign to appropriate variable
combined_data <- read_csv('combined.csv')
plots_data <- read_csv('plots.csv')
species_data <- read_csv('species.csv')
surveys_data <- read_csv('surveys.csv')


#FIRST PLOT
#isolate in surveys data sex, species_id, hindfootlength
all3 <- surveys_data[,6:8]
#species_col_only <- surveys_data[,6:6]

#isolate all DM species data
DM_data <- filter(all3, species_id == 'DM')

#split up male vs. female 
DM_data_male <- filter(DM_data, sex == 'M')
DM_data_female <- filter(DM_data, sex == 'F')

#general summary
summary(DM_data_female)
summary(DM_data_male)

#get just average hindfoot length for males and females
mean_female <- mean(DM_data_female$hindfoot_length, na.rm = TRUE)
mean_male <- mean(DM_data_male$hindfoot_length, na.rm = TRUE)

#gg plot information
install.packages("ggplot2")
#library(ggplot2) #use this sometimes
p <- ggplot(data=subset(all3, !is.na(sex)), aes(x = sex, y = hindfoot_length)) + geom_boxplot()
p + labs(x = "Sex")
p + labs(y = "Hindfoot Lengths")
p + labs(title = "Species 'DM' Male vs. Female Hindfoot Lengths")

#SECOND PLOT










