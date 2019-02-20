library(tidyverse)
library(plyr)
library(psych)
library(doBy)
library(pastecs)
library(dplyr)


getwd()
setwd("c:/Users/jhold/Desktop/case study 1")
beers <- read_csv("c:/Users/jhold/Desktop/case study 1/Beers.csv")
brewers <- read_csv("c:/Users/jhold/Desktop/case study 1/Breweries.csv")
str(beers)
str(brewers)
head(beers)
BrewersbyState <- brewers$State
CntState <- count(BrewersbyState)
CntState <- CntState[order(-CntState$freq),] 
str(CntState)
TotCNT <- sum(CntState$freq)
Brewtot <- merge(beers, brewers, by.x = "Brewery_id", by.y = "Brew_ID")
cntbeers <- count(Brewtot$State)
cntbeers <- cntbeers[order(-cntbeers$freq),] 
totbeers <- sum(cntbeers$freq)
str(Brewtot)
head(Brewtot)
tail(Brewtot)
MissTot <- sapply(Brewtot, function(x) sum(is.na(x)))
describeBy(Brewtot$ABV,Brewtot$State)
MedA <- aggregate (Brewtot$ABV, list(Brewtot$State), median, na.rm=TRUE)
str(MedA)
ggplot(data=MedA, aes(x=reorder(Group.1, x), y=x, fill=Group.1)) +geom_bar(stat="identity") +coord_flip() +ylab("Median ABV") + xlab("State Name") +ggtitle("Median ABV by State")+ theme(plot.title = element_text(hjust = 0.5)) + theme(legend.position="none")
MedI <- aggregate (Brewtot$IBU, list(Brewtot$State), median, na.rm=TRUE)
MedI <- MedI[-c(42),]
ggplot(data=MedI, aes(x=reorder(Group.1, x), y=x, fill=Group.1)) +geom_bar(stat="identity") +coord_flip() +ylab("Median IBU") + xlab("State Name") +ggtitle("Median IBU by State")+ theme(plot.title = element_text(hjust = 0.5)) + theme(legend.position="none")
hist(Brewtot$ABV, main="Distribution of ABV", xlab="Alcohol by Volume", border="black", col="blue", xlim=c(0,.13))
hist(Brewtot$IBU, main="Distribution of IBU", xlab="International Bitterness Units", border="black", col="red", xlim=c(0,100))
describe(Brewtot$ABV, na.rm = TRUE,quant=c(.05,.10,.25,.75,.90,.95))
describe(Brewtot$IBU, na.rm = TRUE,quant=c(.05,.10,.25,.75,.90,.95))
summary(Brewtot$ABV)
Brewtot <- Brewtot[order(-Brewtot$ABV),] 
Brewtot <- Brewtot[order(-Brewtot$IBU),] 
head(Brewtot)
MedA <- MedA[order(-MedA$x),] 
options(scipen=100)
stat.desc(Brewtot$ABV)
stat.desc(Brewtot$IBU)
MedI <- MedI[order(-MedI$x),] 
ggplot(data=Brewtot, aes(x=ABV, y=IBU)) +geom_point(shape = 16, size = 5) +ylab("IBU") + xlab("ABV") +ggtitle("Craft Beer IBU by ABV")+ theme(plot.title = element_text(hjust = 0.5))
ggplot(data=Brewtot, aes(x=IBU, y=ABV)) +geom_point(shape = 16, size = 2, color="blue") + stat_smooth(method = 'lm', color='red') + labs(title = 'Craft Beer IBU by ABV') + theme(plot.title = element_text(hjust = 0.5))
cor.test( ~ ABV + IBU,data=Brewtot,method = "pearson")
model = lm(IBU ~ ABV, data = Brewtot)
summary(model)


