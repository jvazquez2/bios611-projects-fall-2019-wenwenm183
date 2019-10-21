library(ggplot2)
library(tidyverse)
library(psych)
require(data.table)

#filter the datset 
data<-as.data.frame(fread("./data/UMD_Services_Provided_20190719.tsv")) %>%
  subset(select=c(1, 2, 4,6, 7, 8, 9, 10, 11))
data$Date <- as.Date(data$Date, "%m/%d/%Y") 

data1 <- data %>% 
  separate(Date, sep="-", into = c("Year", "Month", "Day")) %>%
  filter(1999<= Year & Year <= 2018)

data_Bus <- data1 %>%
  drop_na('Bus Tickets (Number of)') %>%
  filter('Bus Tickets (Number of)' > 0) %>%
  group_by(Year, Month) %>%
  summarise(count = n(),
            count= sum(`Bus Tickets (Number of)`))

data_Food <- data1 %>%
  drop_na('Food Provided for') %>%
  filter('Food Provided for' > 0) %>%
  group_by(Year, Month) %>%
  summarise(count = n(),
            count= sum(`Food Provided for`))

data_Cloth <- data1 %>%
  drop_na('Clothing Items') %>%
  filter('Clothing Items' > 0) %>%
  group_by(Year, Month) %>%
  summarise(count = n(),
            count= sum(`Clothing Items`))

data_School <-data1 %>%
  drop_na('School Kits') %>%
  filter('School Kits' > 0) %>%
  group_by(Year, Month) %>%
  summarise(count = n(),
            count= sum(`School Kits`))

data_Hygiene <- data1 %>%
  drop_na('Hygiene Kits') %>%
  filter('Hygiene Kits' > 0) %>%
  group_by(Year, Month) %>%
  summarise(count = n(),
            count= sum(`Hygiene Kits`))



# plot
plot <- function(a) {
  c = get(paste("data",a,sep = "_"))
  ggplot(c,aes(Month, Year, fill=count)) + geom_tile()+ theme_classic() +
    labs(title=paste('Number of Clients Claimed',a, 'Products From UMD'))
}


