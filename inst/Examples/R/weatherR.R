library(ggplot2)
library(scales)
library(plyr)

w2014 <- read.csv(file=system.file("extdata", "FSO2014_1.csv", package="RQt"),head=TRUE,sep=",") # Hourly temperatures
w2014 <- w2014[w2014$TemperatureC !=-9999, ]

w2014$shortdate <- strftime(w2014$DateUTC, format="%m-%d") # Extracts the date part only

meanTemp <- ddply(w2014, .(shortdate), summarize, mean_T=mean(TemperatureC)) # calculates the mean temperature per day
meanTemp$shortdate <- as.Date(meanTemp$shortdate,format="%m-%d") # set the date column for the meanTemp array

ggplot(meanTemp, aes(shortdate, mean_T)) + geom_line() +
  scale_x_date(labels=date_format("%m/%d")) + xlab("") + ylab("Mean Temp deg C") +
  ggtitle("2014 Average Daily Temperature at SFO")
