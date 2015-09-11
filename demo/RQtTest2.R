library(RQt)
t <- rqt.versionInfo()
n <- rqt.appName()

dir <- file.path(find.package("RQt"), "extdata/", "")
cnnString <- "CONNECTION cnn1 ADAPTER=CSV SOURCE_URI='%s'
PARAMETERS=delimiter:comma, fileExtension:csv, firstRowIsHeader:true"

cnnString <- sprintf(cnnString, dir)

bindingString <- "BIND b1 CONNECTION=cnn1 SCOPE=xdata_10, mydata1"
st1String <- "SELECT FROM b1.0 INTO var3"
st2String <- "SELECT USING INLINE avg(temperature) AS meanT, soilni
as soilCategory FROM b1.0 INTO var4 ORDER BY meanT"

engine2 <- rqt.getEngine()

rqt.addScript(engine2, cnnString)
rqt.addScript(engine2, bindingString)
rqt.addScript(engine2, st1String)
rqt.addScript(engine2, st2String)

process <- rqt.getProcess(engine2)
rn2 <- rqt.runProcess(engine2)
err2 <- rqt.getRunReport(engine2)

#View(err2)
var3 <- rqt.getVariable(engine2, "var3")
var4 <- rqt.getVariable(engine2, "var4")
