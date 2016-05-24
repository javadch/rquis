library(RQUIS)
library(ggplot2)
library(scales)
library(plyr)

engine <- quis.getEngine()

file <- system.file("extdata", "ex1.xqt", package="RQUIS")
ld <- quis.loadProcess(engine, file)

rn <- quis.runProcess(engine)
err <- quis.getRunReport(engine)

fsoData <- quis.getVariable(engine, "meanDailyTemp")

ggplot(fsoData, aes(dayindex, meantemp)) + geom_line() +
 xlab("") + ylab("Mean Temp deg C") +
  ggtitle("2014 Average Daily Temperature at SFO")
