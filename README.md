# Analysis of Beer

This is a class project for MSDS 6371 Doing Data Science, the purpose of which is to illustrate data cleaning, data analysis, and project management skills. 

We're tasked with analyzing beer and brewery data to find quantitative and qualitative info.  This includes descriptive statistics on bitterness and alcohol content, as well as info on beer types and manufacturing location.

The purpose is to imagine presenting a business proposal to a beer company.  As market research, this project answers the questions of which US geographical location(s) the company should expand to and the beer offering(s) it should make.

The analysis is done with R using the *dplyr* and *ggplot2* packages.  The raw data can be found in the *Beers.csv* and *Breweries.csv* files
Key variables from Beers.csv
  ABV = alcohol by volume
  IBU = International Bitterness Units
  Brewery_ID = unique brewery identifier
 Key Variables from Brewers.csv
  State = State in which the beer was produced 
  Brew_ID = unique brewery identifier
Files merged based on unique brewery ID

Note: for the purposes of this project additional data was identified from the web to help frame an understanding of beer consumption by state. This data is found at URL=http://scottjanish.com/map-per-capita-gallons-beer-consumed-per-adult-state

The included HTML file includes commentary, graphics, and code
The include powerpoint file is the overall integration of visual and statistical information
Individual graphic files for each table, histogram, and plot can be found in this repository
