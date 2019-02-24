library(ggplot2)
library(dplyr)

# load "Beers.csv" - call it beers
# load "Brewers.csv" - call it brewers
str(beers)
str(brewers)
head(beers)
BrewersbyState <-  brewers %>% group_by(State) %>% summarise(TotalBreweries = length(State))
Brewtot <- merge(beers, brewers, by.x = "Brewery_id", by.y = "Brew_ID")

# rename Name.x, Name.y columns
colnames(Brewtot)[c(2,8)] = c("Beer", "Brewer")
head(Brewtot)
tail(Brewtot)
MissTot <- sapply(Brewtot, function(x) sum(is.na(x)))

alcohol_and_bitterness <- Brewtot %>% group_by(State) %>% 
  summarise(MedianAlcohol = median(ABV, na.rm = T), MedianBitter = median(IBU, na.rm = T))
# SD still has a NA since there's no information on bitterness for any of their breweries
# remove SD
alcohol_and_bitterness <- alcohol_and_bitterness[-42,]

# summarising median bitterness and alcohol content by State, and plotting the results                  
ggplot(alcohol_and_bitterness) + 
  geom_col(aes(x = reorder(State, MedianAlcohol), y = MedianAlcohol), fill = 'steel blue') + coord_flip() + xlab("Median ABV") + ylab("State") + ggtitle("Median Beer Alcohol Content by State") + theme(plot.title = element_text(hjust = 0.5))
ggplot(alcohol_and_bitterness) + 
  geom_col(aes(x = reorder(State, MedianBitter), y = MedianBitter), fill = 'orange') + coord_flip() + xlab("Median IBU") + ylab("State") + ggtitle("Median Beer Bitterness by State") + theme(plot.title = element_text(hjust = 0.5))

# finding the state with the max beer ABV and state with max IBU
max_ABV_state = Brewtot[which(Brewtot$ABV == max(Brewtot$ABV, na.rm = T)), 10]
max_IBU_state = Brewtot[which(Brewtot$IBU == max(Brewtot$IBU, na.rm = T)), 10]
summary(Brewtot$ABV)                 

# looking for a linear correlation between IBU and ABV                  
ggplot(Brewtot) + geom_point(aes(ABV, IBU)) + ggtitle("Craft Beer IBU by ABV")+
  theme(plot.title = element_text(hjust = 0.5))
cor.test(~ ABV + IBU, data = Brewtot, method = "pearson")
