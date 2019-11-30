library(tidyverse)
library(ggplot2)


client_info <- read.csv("../data/final_project.csv",sep = ",")

library(plyr)
# Plot the client's age for different genders 
mu <- ddply(client_info, "Client.Gender", summarise, grp.mean=mean(Client.Age.at.Entry))

# used to identify the number of females, males, and trans female
#Gender=client_info$Client.Gender
#as.data.frame(table(Gender))

ggplot(client_info, aes(x=Client.Age.at.Entry, color=Client.Gender)) + 
  geom_histogram(fill="white", position="dodge", na.rm = TRUE) +
  geom_vline(data=mu, aes(xintercept=grp.mean, color=Client.Gender), linetype="dashed") + 
  labs(title="Histogram of Health Client Age", x="Client Age", y="Count",color='Gender') +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_color_manual(labels=c("Female (606)", "Male (1583)", "Trans Female (8)"), 
                     values=c("red", "blue","black"))
ggsave("../results/histogram_age.png", width = 6, height = 4)

#frequency table by year  
year=client_info$year
as.data.frame(table(year))


#Summary statistics on clients veteran status, race, and health 
<<<<<<< HEAD
#install.packages("qwraps2")
#install.packages("magrittr")
=======
>>>>>>> 8a1876ddec63a1f766cccdf44f424930c5caef38
library(magrittr)
#library(qwraps2)

vet=client_info$Client.Veteran.Status
table(vet)
race= client_info$Client.Primary.Race
as.data.frame(table(race))
health=client_info$Health.Insurance.Type..Entry.
covered=client_info$Covered..Entry.
ftable(covered ~ health, data = client_info)

#boxplot on visits  
ggplot(client_info, aes(x="", y=client_info$Number.of.Visits)) +
  geom_boxplot() + 
  labs(title="Boxplot of Number of Visits", x="Client", y="Number of Visits") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5)) 

ggsave("../results/boxplot_visits.png", width = 6, height = 4)

#boxplot on race vs. visits
ggplot(client_info, aes(x=client_info$Client.Primary.Race, y=client_info$Number.of.Visits, color=Client.Primary.Race)) +
  geom_boxplot()  + 
  scale_x_discrete(labels=c("American Indian or Alaska Native (HUD)" = "AI/AN", 
                            "Asian (HUD)" = "Asian",
                            "Black or African American (HUD)" = "AA",
                            "Client doesn't know (HUD)" = "DK",
                            "Client refused (HUD)" = "R",
                            "Data not collected (HUD)" = "N",
                            "Native Hawaiian or Other Pacific Islander (HUD)" = "NH/OPI",
                            "White (HUD)" = "C")) +
  scale_color_manual(labels=c("AI/AN = American Indian or Alaska Native", 
                              "Asian = Asian", 
                              "AA = African America",
                              "DK = Client Doesn't Know",
                              "R = Client Refused", 
                              "N = Data Not Collected", 
                              "NH/OPI = Native Hawaiian or Other Pacific Islander", 
                              "C = Caucasian"
  ), 
  values=c("#b2182b", "#d6604d","#f4a582", "#fddbc7", 
           "#d1e5f0", "#92c5de", "#4393c3", "#2166ac")) + 
  labs(title="Boxplot of Race vs. Number of Visits", x="Client Race", 
       y="Number of Visits") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5))

ggsave(filename = "../results/boxplot_race_visits.png", width = 6, height = 4)

#boxplots on veteran vs. visits
ggplot(client_info, aes(x=client_info$Client.Veteran.Status, y=client_info$Number.of.Visits, color=Client.Veteran.Status)) +
  geom_boxplot() +
  scale_x_discrete(labels=c("Data not collected (HUD)" = "Data Not Collected",
                            "No (HUD)" = "No",
                            "Yes (HUD)" = "Yes")) +
  scale_color_manual(labels=c("Data Not Collected", 
                              "No",
                              "Yes"), 
                     values=c("#66c2a5", "#fc8d62","#8da0cb")) + 
  labs(title="Boxplot of Veteran Status vs. Number of Visits", x="Veteran Status", 
       y="Number of Visits") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5))

ggsave(filename = "../results/boxplot_veteran_visits.png", width = 6, height = 4)

#boxplots on health insurance and visits
ggplot(client_info, aes(x=client_info$Health.Insurance.Type..Entry., y=client_info$Number.of.Visits, color=Health.Insurance.Type..Entry.)) +
  geom_boxplot() +
  scale_x_discrete(labels=c("Employer - Provided Health Insurance" = "Employer",
                            "Health Insurance obtained through COBRA" = "COBRA",
                            "Indian Health Services Program" = "IHSP",
                            "MEDICAID" = "Medicaid",
                            "MEDICARE" = "Medicare",
                            "Private Pay Health Insurance" = "Private",
                            "State Health Insurance for Adults" = "State",
                            "Veteran's Administration (VA) Medical Services" = "VA")) +
  scale_color_manual(labels=c("Employer Provided Health Insurance", 
                              "Health Insurance obtained through COBRA",
                              "Indian Health Services Program",
                              "Medicaid",
                              "Medicare", 
                              "Private Pay Health Insurance ",
                              "State Health Insurance for Adults ",
                              "Veteran's Administration (VA) Medical Services "), 
                     values=c("#b2182b", "#d6604d","#f4a582", "#fddbc7", 
                              "#d1e5f0", "#92c5de", "#4393c3", "#2166ac")) + 
  labs(title="Boxplot of Health Insurance vs. Number of Visits", x="Health Insurance", 
       y="Number of Visits") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5))

ggsave(filename = "../results/boxplot_health_visits.png", width = 8, height = 4)

#boxplots on gender and visits
ggplot(client_info, aes(x=client_info$Client.Gender, y=client_info$Number.of.Visits, color=Client.Gender)) +
  geom_boxplot()+
  scale_x_discrete(labels=c("Female" = "Female",
                            "Male" = "Male",
                            "Trans Female (MTF or Male to Female)" = "Trans Female")) +
  scale_color_manual(labels=c("Female", 
                              "Male",
                              "Trans Female"), 
                     values=c("#66c2a5", "#fc8d62","#8da0cb")) + 
  labs(title="Boxplot of Gender vs. Number of Visits", x="Veteran Status", 
       y="Number of Visits") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5))
ggsave(filename = "../results/boxplot_gender_visits.png", width = 6, height = 4)

# boxplots on year and visits
client_info[,12] <- sapply(client_info[, 12], as.character)
ggplot(client_info, aes(x=client_info$year, y=client_info$Number.of.Visits)) +
  geom_boxplot()  + 
  labs(title="Boxplot of Year of Entry vs. Number of Visits", x="Year", 
       y="Number of Visits") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5))

ggsave(filename = "../results/boxplot_year_visits.png", width = 6, height = 4)

#scatterplots on year vs. visits
client_info1 <- read.csv("../data/final_project1.csv",sep = ",")

ggplot(client_info1, aes(x=year, y=client_info1$Number.of.Visits)) + geom_point()+ geom_jitter() + geom_smooth(method=lm, se=TRUE, fullrange=FALSE, level=0.95) + 
  labs(title="Scatterplot of Year of Entry vs. Number of Visits", x="Year", 
       y="Number of Visits") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5))


ggsave(filename = "../results/scatter_year_visits.png", width = 6, height = 4)


#density on year and visits
<<<<<<< HEAD
install.packages("e1071", repos="http://cran.us.r-project.org")
=======

>>>>>>> 8a1876ddec63a1f766cccdf44f424930c5caef38
library(e1071)
par(mfrow=c(1, 2)) 
plot(density(client_info1$Number.of.Visits), main="Density Plot: Visits", ylab="Frequency", sub=paste("Skewness:", round(e1071::skewness(client_info1$Number.of.Visits, 2))))
polygon(density(client_info1$Number.of.Visits), col="red")

plot(density(client_info1$year), main="Density Plot: Year", ylab="Frequency", sub=paste("Skewness:", round(e1071::skewness(client_info1$year), 2)))  # density plot for 'dist'
polygon(density(client_info1$year), col="red")

ggsave(filename = "../results/density.png", width = 6, height = 4)

#fit a model and find the p-value

summary(lm(Number.of.Visits ~ year+factor(Health.Insurance.Type..Entry.),data=client_info1))

# Generate HTML 
<<<<<<< HEAD
rmarkdown::render("./Project3_wenwenm183.Rmd", "html_document")
=======
rmarkdown::render("proj3_report.Rmd", "html_document")
>>>>>>> 8a1876ddec63a1f766cccdf44f424930c5caef38












