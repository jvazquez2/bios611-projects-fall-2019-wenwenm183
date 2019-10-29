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
names(data1) <- c("Year", "Month", "Day", "Client", "Bus", "Food","Food_Pound",
                  "Cloth", "Diapers", "School_kits", "Hygiene_kits" )


Client <- data1 %>%     
  group_by(Year)%>% 
  summarise(Total=n(), 'One-time'=n_distinct(Client), Frequent=Total-`One-time`) %>%
  gather(key="client", value="count", Total:Frequent) 




#Plot 1: Line plot, used to observe growth in different categories
p1 <- function(a) {
  b <- as.data.frame(Client %>% 
    filter(client == a))
  
  ggplot(b,aes(x=Year, y=count)) +
    geom_line(group=1)+
    geom_point(size = 2, alpha = 0.6, color='blue') +  
    labs(x='Year',
         y='Number of Clients',
         title=paste('Number of',a,   'Clients From 1999-2018')
         )
}

# plot2: HeatMap
plot <- function(a) {
  b <- data1 %>% 
    drop_na(a) %>%
    filter(a > 0) %>%
    group_by(Year, Month) %>%
    summarise(count = n(),
              count= sum(get(a)))
  
  ggplot(b,aes(Month, Year, fill=count)) + geom_tile()+ theme_classic() +
    labs(title=paste('Number of Clients Claimed',a, 'Products From UMD'))
}

# plot3:Scatter plot (note jitter is used to show multiple observations at one point)
plot1 <- function(a1){
  b <- data1 %>% 
    drop_na(a1) %>%
    filter(a1 > 0)
  ggplot(b, aes(x=Year, y=get(a1))) +
    geom_jitter() + 
    labs(x='Year',
         y='Number of Clients',
         title=paste('Number of Clients Received',a1,'Service From 1999-2018')
    )
  
}


