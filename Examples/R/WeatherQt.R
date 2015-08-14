library(RQt)
library(ggplot2)
library(scales)
library(plyr)

engine <- rqt.getEngine()

ld <- rqt.loadProcess(engine, "Examples\\processes\\ex2.xqt")

rn <- rqt.runProcess(engine)
err <- rqt.getRunReport(engine)


fsoData <- rqt.getVariable(engine, "result1")

ggplot(fsoData, aes(dayindex, meantemp)) + geom_line() +
 xlab("") + ylab("Mean Temp deg C") +
  ggtitle("2014 Average Daily Temperature at SFO")