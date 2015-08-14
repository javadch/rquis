library(RQt)
library(ggplot2)
library(scales)
library(plyr)

engine <- rqt.getEngine()

ad <- rqt.getAdapterNames(engine)

ld <- rqt.loadProcess(engine, "Examples\\processes\\ex1.xqt")

rn <- rqt.runProcess(engine)
err <- rqt.getRunReport(engine)


var2 <- rqt.getVariable(engine, "var2")


ggplot(var2, aes(elevation, temperature)) + geom_line() +
  xlab("") + ylab("Mean Temp deg C") +
  ggtitle("Elevation vs. Temperature")

