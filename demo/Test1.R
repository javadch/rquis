library(RQUIS)
t <- quis.versionInfo()
n <- quis.appName()

dir <- file.path(find.package("RQUIS"), "extdata/", "")
cnnString <- "CONNECTION cnn1 ADAPTER=CSV SOURCE_URI='%s'
PARAMETERS=delimiter:comma, fileExtension:csv, firstRowIsHeader:true"

cnnString <- sprintf(cnnString, dir)

bindingString <- "BIND b1 CONNECTION=cnn1 SCOPE=xdata_10, mydata1"
st1String <- "SELECT FROM b1.0 INTO var3"
st2String <- "SELECT USING INLINE avg(temperature) AS meanT, soilni
as soilCategory FROM b1.0 INTO var4 ORDER BY meanT"

engine2 <- quis.getEngine()

quis.addScript(engine2, cnnString)
quis.addScript(engine2, bindingString)
quis.addScript(engine2, st1String)
quis.addScript(engine2, st2String)

process <- quis.getProcess(engine2)
rn2 <- quis.runProcess(engine2)
err2 <- quis.getRunReport(engine2)

#View(err2)
var3 <- quis.getVariable(engine2, "var3")
var4 <- quis.getVariable(engine2, "var4")
