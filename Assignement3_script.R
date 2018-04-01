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

#variable <- DBI::dbConnect(RSQLite::SQLite(), "data/portal_mammals.sqlite")
#src_dbi(variable)



#FIRST PLOT
#isolate in surveys data sex, species_id, hindfootlength
Three_variables <- surveys_data[,6:8] %>% filter(!is.na(hindfoot_length)) %>% filter(!is.na(sex)) 



#isolate all DM species data
DM_data <- filter(Three_variables, species_id == 'DM')


#general summary
summary(DM_data)

#gg plot information
install.packages("ggplot2")
library(ggplot2) #use this sometimes

p <- ggplot(data = DM_data, aes(x = sex, y = hindfoot_length)) + geom_boxplot()
q <- p + ggtitle("Species 'DM' Male vs. Female Hindfoot Lengths") +
  xlab("Sex") + ylab("Hindfoot Lengths")
r <- q + stat_summary(fun.y=mean, geom="point", shape=20, color="blue", size=4) + 
  geom_jitter(shape=16, position=position_jitter(0.2), alpha = .010) +
  scale_shape_manual("", values=c("mean"="x"))

#black line shows median, red dot is mean

#SECOND PLOT
#PE-rodent weights female and male
PE_weight_data <- filter(subset(surveys_data[,6:9], select = c(1,2,4)), species_id == "PE") %>%
  na.omit()

#Separate male and female
PE_weight_male <- filter(PE_weight_data, sex == "M")
PE_weight_female <- filter(PE_weight_data, sex == "F")

#plot
second_plot <- ggplot()
