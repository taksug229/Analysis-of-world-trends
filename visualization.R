
?read.csv()

#Method 1: Select The File Manually
#stats <- read.csv(file.choose())
#stats

#Method 2: Set WD and Read Data
getwd()
#Windows
setwd("C:\\Users\\Takeshi Sugiyama\\Desktop\\Data Science\\Udemy\\R Programing A-Z\\20191005 Data Frames")
#Mac
setwd("/Users/Takeshi Sugiyama/Desktop/Data Science/Udemy/R Programing A-Z/20191005 Data Frames")
getwd()
rm(stats)
stats <- read.csv("P2-Demographic-Data.csv")
stats

#-------------------------------------Exploring Data
stats
nrow(stats)
ncol(stats)
head(stats, n=10)
tail(stats, n=8)
str(stats)      #str() runif() rnorm()
summary(stats)

#------------------------------------- Using the $ sign
stats
head(stats)
stats[3,3]
stats[3,"Birth.rate"]
stats$Internet.users
stats$Internet.users[2]
stats[,"Internet.users"]
levels(stats$Income.Group)

#------------------------------------- Basic Operations with a DF
stats[1:10,] #subsetting
stats[3:9,]
stats[c(4,100),]
#Remember how the[] work:
is.data.frame(stats[1,]) #no need for drop=F
is.data.frame(stats[,1])
is.data.frame(stats[,1,drop=F])
#multiply comuns
head(stats)
stats$Birth.rate * stats$Internet.users
stats$Birth.rate + stats$Internet.users
#add column
head(stats)
stats$MyCalc <- stats$Birth.rate * stats$Internet.users
#test of knowledge
stats$xyz <- 1:5
head(stats, n=12)
#remove a column
head(stats)
stats$MyCalc <- NULL
stats$xyz <- NULL
stats$Country.Name

#------------------------------------- Filtering Data Frames
head(stats)
filter <- stats$Internet.users < 2
stats[filter,]

stats[stats$Birth.rate > 40,]
stats[stats$Birth.rate > 40 & stats$Internet.users < 2,]
stats[stats$Income.Group == "High income",]
levels(stats$Income.Group)

stats[stats$Country.Name == "Malta",]

#------------------------------------- Introduction to qplot()
#install.packages("ggplot2")
library(ggplot2)
?qplot
qplot(data=stats, x=Internet.users)
qplot(data=stats, x=Income.Group, y=Birth.rate)
qplot(data=stats, x=Income.Group, y=Birth.rate, size=I(3), color=I("blue"))
qplot(data=stats, x=Income.Group, y=Birth.rate, geom="boxplot")


#------------------------------------- Visualizing what we need

qplot(data=stats, x=Internet.users, y=Birth.rate)
qplot(data=stats, x=Internet.users, y=Birth.rate,
      color=I("red"),size=I(4))
qplot(data=stats, x=Internet.users, y=Birth.rate,
      color=Income.Group,size=I(5))

#------------------------------------- Creating Data Frames
mydf <- data.frame(Countries_2012_Dataset, Codes_2012_Dataset, Regions_2012_Dataset)

head(mydf)
#colnames(mydf) <- c("Country", "Code", "Region")
#head(mydf)

rm(mydf)
mydf <- data.frame(Country=Countries_2012_Dataset, Code=Codes_2012_Dataset, 
                   Region=Regions_2012_Dataset)
head(mydf)
tail(mydf)
summary(mydf)

#------------------------------------- Merging Data Frames
head(stats)
head(mydf)

merged <- merge(stats, mydf, by.x = "Country.Code", by.y = "Code")
head(merged)

merged$Country <- NULL
str(merged)
tail(merged)

#------------------------------------- Visualizing With new Split

qplot(data=merged, x=Internet.users, y=Birth.rate,
      color=Region,size=I(5))
#1. Shapes
qplot(data=merged, x=Internet.users, y=Birth.rate,
      color=Region,size=I(5), shape=I(23))

#2. Transparency
qplot(data=merged, x=Internet.users, y=Birth.rate,
      color=Region,size=I(5), shape=I(19),
      alpha=I(0.6))

#3. Title
qplot(data=merged, x=Internet.users, y=Birth.rate,
      color=Region,size=I(5), shape=I(19),
      alpha=I(0.6),
      main="Birth Rate vs Internet Users")

#------------------------------------- Homework Assignment 
#Split Data

setwd("C:\\Users\\Takeshi Sugiyama\\Desktop\\Data Science\\Udemy\\R Programing A-Z\\20191005 Data Frames")
getwd()

hwstats <- read.csv("P2-Section5-Homework-Data.csv")
tail(hwstats)
hwstats$Year


filter1960 <- hwstats[hwstats$Year==1960,]
filter2013 <- hwstats[hwstats$Year==2013,]

nrow(filter1960) #187 rows
nrow(filter2013) #187 rows. Equal split.

#Merging Life Expectancy Data
mydf1960 <- data.frame(Code=Country_Code,
                       LifeExpectancy=Life_Expectancy_At_Birth_1960)
mydf2013 <- data.frame(Code=Country_Code,
                       LifeExpectancy=Life_Expectancy_At_Birth_2013)
#Check summaries
summary(mydf1960)
summary(mydf2013)


#Merging 1960 & 2013 Life Expectancy Data
merged1960 <- merge(filter1960, mydf1960, by.x = "Country.Code", by.y = "Code")
merged2013 <- merge(filter2013, mydf2013, by.x = "Country.Code", by.y = "Code")

#Check the new structures
str(merged1960)
str(merged2013)

#Delete Columns
merged1960$Year <- NULL
merged2013$Year <- NULL

merged1960

#Visualizing the Data
qplot(data=merged1960, x=Fertility.Rate, y=LifeExpectancy,
      color=Region,size=I(5),alpha=I(0.6),
      main="Life Expectancy vs Fertility (1960)")

qplot(data=merged2013, x=Fertility.Rate, y=LifeExpectancy,
      color=Region,size=I(5),alpha=I(0.6),
      main="Life Expectancy vs Fertility (2013)")

