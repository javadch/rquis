library(RQUIS)

engine <- quis.getEngine()

file <- "processes/example1.xqt"
ld <- quis.loadProcess(engine, file)

rn <- quis.runProcess(engine)

data <- quis.getVariable(engine, "airportsData")

schema <- quis.getVariableSchema(engine, "airportsData")