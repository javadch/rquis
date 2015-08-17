# TODO
# 1: Exception Handling
# 2: Plot variables to be shown in R
# For check and compillation purposes: set these options --no-multiarch --no-clean for check and build
# The first CHeck run fails running the examples because the config folder is not present!
# Copy the config folder (after updating the adapters) into the RCheck folder and check agian!


#' RQt.
#'
#' @name RQt
#' @docType package
#' @import rJava
NULL


#' Query engine information.
#'
#' \code{rqt.versionInfo} returns the name of the query engine, its version and the maturity level.
#'
#' @export
rqt.versionInfo <- function(){
  versionInfoReturnValue <- .jcall("xqt/api/AppInfo","S","getFullName")
  return(versionInfoReturnValue)
}

#' Query engine name.
#'
#' \code{rqt.appName} returns the name of the query engine.
#'
#' @export
rqt.appName <- function(){
  appNameReturnValue <- .jcall("xqt/api/AppInfo","S","getName")
  return(appNameReturnValue)
}

#' Get an engine instance.
#'
#' \code{rqt.getEngine} instantiates a new query execution engine, so that a user can submit queries to and ask for execution.
#'
#' The function uses Java Development Kit (JDK) 8 or upper. Having the Java Runtime Engine (JRE) is not enough.
#' Also the package needs an environment variable named JAVA_HOME that points to the root folder of the JDK
#' For more information consult the ReadMe file in the package root folder.
#' @return An instance of the query execution engine is returned so that it is possible for the following functions to interact with
#' the engine. It is possible to have more than one engine instances in a single R script and use them for different processing porpuses.
#' @examples
#' engine <- rqt.getEngine()
#'
#' \dontrun{
#' engine <- rqt.getEngine()
#' }
#'
#' @export
rqt.getEngine <- function(){
  getEngineReturnValue <- .jnew("xqt/api/LanguageServicePoint")
  return(getEngineReturnValue)
}

#' Retrieves the name of the registered adapters.
#'
#' \code{rqt.getAdapterNames} retrieves the name of the registered adapters.
#'
#' Each engine has access to some adapters.
#' Each adapter is resposible to translate and run the queries on a set of target data sources, e.g., CSV for csv, tsv, spreadseets, or relational databases.
#' Adapters can be developed by third parties and introduced to the engine by registration in the adapters.xml file located in the config folder.
#' @param engine the engine instance created by \code{rqt.getEngine}
#' @return the code name of the registered adapters.
#' @examples
#' engine1 <- rqt.getEngine()
#' names <- rqt.getAdapterNames(engine1)
#'
#' \dontrun{
#' engine1 <- rqt.getEngine()
#' names <- rqt.getAdapterNames(engine1)
#' }
#'
#' @export
rqt.getAdapterNames <- function(engine){
  adNames <- .jcall(engine,"Ljava/lang/Object;","getAdapterNames")
  adNameVector = as.vector(.jevalArray(adNames))
  return (adNameVector)
}


#' Adds one or more statements to the current process.
#'
#' \code{rqt.addScript} Adds one or more statements to the current process. Each engine instance works on one process at a time.
#'
#' @param engine the engine instance created by \code{rqt.getEngine}
#' @param statement the statement to be submitted to the engine for later execution. Statements are of one of these types:
#' PERSPECTIVE, CONNECTION, BINDING, SELECT. A minimum process needs at least one connection. one binding, and one select.
#' It is possible to have any number of these statements, but they have to follow the abovementioned order,
#' which means e.g., all perspectives go before all connections and so on.
#' @return the added script is returned. Usually the return value is not needed, but in case of debugging it may be useful.
#' @examples
#' engine1 <- rqt.getEngine()
#' script <- "CONNECTION cnn1 ADAPTER=CSV SOURCE_URI='extdata\\\\'
#' PARAMETERS=delimiter:comma, fileExtension:csv, firstRowIsHeader:true"
#' addedScript <- rqt.addScript(engine1, script)
#'
#' \dontrun{
#' engine1 <- rqt.getEngine()
#' script <- "CONNECTION cnn1 ADAPTER=CSV SOURCE_URI='extdata\\\\'
#' PARAMETERS=delimiter:comma, fileExtension:csv, firstRowIsHeader:true"
#' addedScript <- rqt.addScript(engine1, script)
#' }
#'
#' @export
rqt.addScript <- function(engine, statement){
  addScriptReturnValue <- .jcall(engine,"S","addScript", statement)
  return(addScriptReturnValue)
}

#' Loads a process file into the engine.
#'
#' \code{rqt.loadProcess} Loads a process stored in a file into the engine.
#'
#' @param engine the engine instance created by \code{rqt.getEngine}
#' @param fileName the full path to a file containing the process
#' @return the content of the file loaded
#' @examples
#' engine1 <- rqt.getEngine()
#' addedScript <- rqt.loadProcess(engine1, "Examples\\processes\\ex2.xqt")
#'
#' \dontrun{
#' engine1 <- rqt.getEngine()
#' addedScript <- rqt.loadProcess(engine1, "Examples\\processes\\ex2.xqt")
#' }
#'
#' @export
rqt.loadProcess <- function(engine, fileName){
  loadProcessReturnValue <- .jcall(engine,"S","registerScript", fileName)
  return(loadProcessReturnValue)
}

#' Returns the process.
#'
#' \code{rqt.getProcess} Returns the process that was submitted to an engine
#' using \code{rqt.addScript} or \code{rqt.loadProcess}.
#'
#' @param engine the engine instance created by \code{rqt.getEngine}
#' @return the process submitted to the engine
#' @examples
#' engine1 <- rqt.getEngine()
#' addedScript <- rqt.loadProcess(engine1, "Examples\\processes\\ex2.xqt")
#' process <- rqt.getProcess(engine1)
#'
#' \dontrun{
#' engine1 <- rqt.getEngine()
#' addedScript <- rqt.loadProcess(engine1, "Examples\\processes\\ex2.xqt")
#' process <- rqt.getProcess(engine1)
#' }
#'
#' @export
rqt.getProcess <- function(engine){
  getProcessReturnValue <- .jcall(engine,"S","getScript")
  return(getProcessReturnValue)
}

#' Runs the process.
#'
#' \code{rqt.runProcess} Runs the submitted process and keeps the result sets for later use.
#'
#' @param engine the engine instance created by \code{rqt.getEngine}
#' @return OK if everything went ok! To be sure that no error has happend use \code{rqt.getRunReport}.
#' The result set of submitted queries are not returned automatically. They should be requested for using \code{rqt.getVariabe}
#' @examples
#' engine1 <- rqt.getEngine()
#' addedScript <- rqt.loadProcess(engine1, "Examples\\processes\\ex2.xqt")
#' rqt.runProcess(engine1)
#'
#' \dontrun{
#' engine1 <- rqt.getEngine()
#' addedScript <- rqt.loadProcess(engine1, "Examples\\processes\\ex2.xqt")
#' rqt.runProcess(engine1)
#' }
#'
#' @export
rqt.runProcess <- function(engine){
  runProcessReturnValue <- .jcall(engine,"S","process")
  return(runProcessReturnValue)
}

#' Gets the resultset by variable name.
#'
#' \code{rqt.getVariable} Gets the result set, pointed to by a variable, as a data frame.
#'
#' @param engine the engine instance created by \code{rqt.getEngine}
#' @param variableName the variable name tht is used as the target of a query in the process.
#' @return A data frame equivalent to the result set of the corrsponding query as in the process.
#' @examples
#' engine1 <- rqt.getEngine()
#' addedScript <- rqt.loadProcess(engine1, "Examples\\processes\\ex2.xqt")
#' rqt.runProcess(engine1)
#' dlm <- rqt.getVariable(engine1, "result1")
#' \dontrun{
#' engine1 <- rqt.getEngine()
#' addedScript <- rqt.loadProcess(engine1, "Examples\\processes\\ex2.xqt")
#' rqt.runProcess(engine1)
#' dlm <- rqt.getVariable(engine1, "result1")
#' }
#'
#' @export
rqt.getVariable <- function(engine, variableName){
  data <- .jcall(engine,"Ljava/lang/Object;","getVariable", variableName)
  df=as.data.frame(lapply(.jevalArray(data), .jevalArray))
  schema <- .jcall(engine,"Ljava/lang/Object;","getVariableSchema", variableName)
  names(df) = as.vector(.jevalArray(schema))
  return(df)
}

#' Gets the visual resultset by variable name.
#'
#' \code{rqt.getVariable} Gets the visual result set, pointed to by a variable, as an image.
#'
#' @param engine the engine instance created by \code{rqt.getEngine}
#' @param plotName the plot name as used in the process as the target of a query.
#' @return An image of type JPeg as rendered by the corrsponding query in the submitted process.
#' @examples
#' engine1 <- rqt.getEngine()
#' addedScript <- rqt.loadProcess(engine1, "Examples\\processes\\ex2.xqt")
#' rqt.runProcess(engine1)
#' dlm <- rqt.getPlot(engine1, "p2")
#' \dontrun{
#' engine1 <- rqt.getEngine()
#' addedScript <- rqt.loadProcess(engine1, "Examples\\processes\\ex2.xqt")
#' rqt.runProcess(engine1)
#' dlm <- rqt.getPlot(engine1, "p2")
#' }
#'
#' @export
rqt.getPlot <- function(engine, plotName){
  #data <- .jcall(engine,"Ljava/lang/Object;","getVariable", plotName)
  #df=as.data.frame(lapply(.jevalArray(data), .jevalArray))
  #schema <- .jcall(engine,"Ljava/lang/Object;","getVariableSchema", variableName)
  #names(df) = as.vector(.jevalArray(schema))
  #return(df)
  return (0)
}

#' Reports the execution.
#'
#' \code{rqt.getRunReport} Reports whether execution of the proceess has encountered any error.
#'
#' @param engine the engine instance created by \code{rqt.getEngine}
#' @return A verbose report explaining the execution of each statement including the execution time, result size, and errors.
#' @examples
#' engine1 <- rqt.getEngine()
#' addedScript <- rqt.loadProcess(engine1, "Examples\\processes\\ex2.xqt")
#' rqt.runProcess(engine1)
#' err <- rqt.getRunReport(engine1)
#' \dontrun{
#' engine1 <- rqt.getEngine()
#' addedScript <- rqt.loadProcess(engine1, "Examples\\processes\\ex2.xqt")
#' rqt.runProcess(engine1)
#' err <- rqt.getRunReport(engine1)
#' }
#'
#' @export
rqt.getRunReport <- function(engine){
  getErrorsReturnValue <- .jcall(engine,"S","getErrors")
  return(getErrorsReturnValue)
}

