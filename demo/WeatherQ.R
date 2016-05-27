library(RQUIS)
library(ggplot2)
library(scales)
library(plyr)

engine <- quis.getEngine()

file <- system.file("extdata", "ex1.xqt", package="RQUIS")
ld <- quis.loadProcess(engine, file)

rn <- quis.runProcess(engine)
err <- quis.getRunReport(engine)

data <- quis.getVariable(engine, "meanDailyTemp")
schema <- quis.getVariableSchema(engine, "meanDailyTemp")

ggplot(data, aes(dayindex, meantemp)) + geom_line() +
 xlab("") + ylab("Mean Temperature C°") +
  ggtitle("2014 Average Daily Temperature at SFO")
