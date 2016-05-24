# TODO
# 1: Exception Handling
# 2: Plot variables to be shown in R
# For check and compillation purposes: set these options --no-multiarch --no-clean for check and build
# The first CHeck run fails running the examples because the config folder is not present!
# Copy the config folder (after updating the adapters) into the RCheck folder and check agian!


#' RQUIS.
#'
#' @name RQUIS
#' @docType package
#' @import rJava
NULL


#' Query engine information.
#'
#' \code{quis.versionInfo} returns the name of the query engine, its version and the maturity level.
#'
#' @export
quis.versionInfo <- function(){
  versionInfoReturnValue <- .jcall("xqt/api/AppInfo","S","getFullName")
  return(versionInfoReturnValue)
}

#' Query engine name.
#'
#' \code{quis.appName} returns the name of the query engine.
#'
#' @export
quis.appName <- function(){
  appNameReturnValue <- .jcall("xqt/api/AppInfo","S","getName")
  return(appNameReturnValue)
}

#' Get an engine instance.
#'
#' \code{quis.getEngine} instantiates a new query execution engine, so that a user can submit queries to and ask for execution.
#'
#' The function uses Java Development Kit (JDK) 8 or upper. Having the Java Runtime Engine (JRE) is not enough.
#' Also the package needs an environment variable named JAVA_HOME that points to the root folder of the JDK
#' For more information consult the ReadMe file in the package root folder.
#' @return An instance of the query execution engine is returned so that it is possible for the following functions to interact with
#' the engine. It is possible to have more than one engine instances in a single R script and use them for different processing porpuses.
#' @examples
#' engine <- quis.getEngine()
#'
#' \dontrun{
#' engine <- quis.getEngine()
#' }
#'
#' @export
quis.getEngine <- function(){
  #.jcall("java/lang/System", method = "gc") # ask JVM to collect garbages
  path <- find.package("RQUIS")
  getEngineReturnValue <- .jnew("xqt/api/LanguageServicePoint", path, check=FALSE) #"RQUIS, RQUIS/inst, inst")
  if (!is.null(e<-.jgetEx())){
    #print("There was an error getting a query engine!")
    .jcheck(silent=TRUE)
    exp <- .jcall(e,"S","getMessage")
    stop(exp)
  } else {
    return(getEngineReturnValue)
  }
}

#' Retrieves the name of the registered adapters.
#'
#' \code{quis.getAdapterNames} retrieves the name of the registered adapters.
#'
#' Each engine has access to some adapters.
#' Each adapter is resposible to translate and run the queries on a set of target data sources, e.g., CSV for csv, tsv, spreadseets, or relational databases.
#' Adapters can be developed by third parties and introduced to the engine by registration in the adapters.xml file located in the config folder.
#' @param engine the engine instance created by \code{quis.getEngine}
#' @return the code name of the registered adapters.
#' @examples
#' engine1 <- quis.getEngine()
#' names <- quis.getAdapterNames(engine1)
#'
#' \dontrun{
#' engine1 <- quis.getEngine()
#' names <- quis.getAdapterNames(engine1)
#' }
#'
#' @export
quis.getAdapterNames <- function(engine){
  adNames <- .jcall(engine,"Ljava/lang/Object;","getAdapterNames")
  adNameVector = as.vector(.jevalArray(adNames))
  return (adNameVector)
}


#' Adds one or more statements to the current process.
#'
#' \code{quis.addScript} Adds one or more statements to the current process. Each engine instance works on one process at a time.
#'
#' @param engine the engine instance created by \code{quis.getEngine}
#' @param statement the statement to be submitted to the engine for later execution. Statements are of one of these types:
#' PERSPECTIVE, CONNECTION, BINDING, SELECT. A minimum process needs at least one connection. one binding, and one select.
#' It is possible to have any number of these statements, but they have to follow the abovementioned order,
#' which means e.g., all perspectives go before all connections and so on.
#' @return the added script is returned. Usually the return value is not needed, but in case of debugging it may be useful.
#' @examples
#' engine1 <- quis.getEngine()
#' script <- "CONNECTION cnn1 ADAPTER=CSV SOURCE_URI='extdata/'
#' PARAMETERS=delimiter:comma, fileExtension:csv, firstRowIsHeader:true"
#' addedScript <- quis.addScript(engine1, script)
#'
#' \dontrun{
#' engine1 <- quis.getEngine()
#' script <- "CONNECTION cnn1 ADAPTER=CSV SOURCE_URI='extdata/'
#' PARAMETERS=delimiter:comma, fileExtension:csv, firstRowIsHeader:true"
#' addedScript <- quis.addScript(engine1, script)
#' }
#'
#' @export
quis.addScript <- function(engine, statement){
  addScriptReturnValue <- .jcall(engine,"S","addScript", statement)
  return(addScriptReturnValue)
}

#' Loads a process file into the engine.
#'
#' \code{quis.loadProcess} Loads a process stored in a file into the engine.
#'
#' @param engine the engine instance created by \code{quis.getEngine}
#' @param fileName the full path to a file containing the process
#' @return the content of the file loaded
#' @examples
#' engine1 <- quis.getEngine()
#' addedScript <- quis.loadProcess(engine1, system.file("extdata", "ex2.xqt", package="RQUIS"))
#'
#' \dontrun{
#' engine1 <- quis.getEngine()
#' addedScript <- quis.loadProcess(engine1, system.file("extdata", "ex2.xqt", package="RQUIS"))
#' }
#'
#' @export
quis.loadProcess <- function(engine, fileName){
  loadProcessReturnValue <- .jcall(engine,"S","registerScript", fileName)
  return(loadProcessReturnValue)
}

#' Returns the process.
#'
#' \code{quis.getProcess} Returns the process that was submitted to an engine
#' using \code{quis.addScript} or \code{quis.loadProcess}.
#'
#' @param engine the engine instance created by \code{quis.getEngine}
#' @return the process submitted to the engine
#' @examples
#' engine1 <- quis.getEngine()
#' addedScript <- quis.loadProcess(engine1, system.file("extdata", "ex2.xqt", package="RQUIS"))
#' process <- quis.getProcess(engine1)
#'
#' \dontrun{
#' engine1 <- quis.getEngine()
#' addedScript <- quis.loadProcess(engine1, system.file("extdata", "ex2.xqt", package="RQUIS"))
#' process <- quis.getProcess(engine1)
#' }
#'
#' @export
quis.getProcess <- function(engine){
  getProcessReturnValue <- .jcall(engine,"S","getScript")
  return(getProcessReturnValue)
}

#' Runs the process.
#'
#' \code{quis.runProcess} Runs the submitted process and keeps the result sets for later use.
#'
#' @param engine the engine instance created by \code{quis.getEngine}
#' @return OK if everything went ok! To be sure that no error has happend use \code{quis.getRunReport}.
#' The result set of submitted queries are not returned automatically. They should be requested for using \code{quis.getVariabe}
#' @examples
#' engine1 <- quis.getEngine()
#' addedScript <- quis.loadProcess(engine1, system.file("extdata", "ex2.xqt", package="RQUIS"))
#' quis.runProcess(engine1)
#'
#' \dontrun{
#' engine1 <- quis.getEngine()
#' addedScript <- quis.loadProcess(engine1, system.file("extdata", "ex2.xqt", package="RQUIS"))
#' quis.runProcess(engine1)
#' }
#'
#' @export
quis.runProcess <- function(engine){
  runProcessReturnValue <- .jcall(engine,"S","process")
  return(runProcessReturnValue)
}

#' Lists the name of the variables that contain tabular data.
#'
#' \code{quis.listVariables} retrieves the name of the variables that contain tabular data.
#'
#' @param engine the engine instance created by \code{quis.getEngine}
#' @examples
#' engine1 <- quis.getEngine()
#' quis.loadProcess(engine1, system.file("extdata", "ex2.xqt", package="RQUIS"))
#' quis.runProcess(engine1)
#' varNames <- quis.listVariables(engine1)
#'
#' \dontrun{
#' engine1 <- quis.getEngine()
#' quis.loadProcess(engine1, system.file("extdata", "ex2.xqt", package="RQUIS"))
#' quis.runProcess(engine1)
#' varNames <- quis.listVariables(engine1)
#' }
#'
#' @export
quis.listVariables <- function(engine){
  varNames <- .jcall(engine,"Ljava/lang/Object;","getVariablesInfo")
  if(is.null(varNames))
    return (NULL)
  varNameVector = as.vector(.jevalArray(varNames))
  return (varNameVector)
}

#' Gets the resultset by variable name.
#'
#' \code{quis.getVariable} Gets the result set, pointed to by a variable, as a data frame.
#'
#' @param engine the engine instance created by \code{quis.getEngine}
#' @param variableName the variable name that is used as the target of a query in the process.
#' @return A data frame equivalent to the result set of the corrsponding query as in the process.
#' @examples
#' engine1 <- quis.getEngine()
#' quis.loadProcess(engine1, system.file("extdata", "ex2.xqt", package="RQUIS"))
#' quis.runProcess(engine1)
#' dlm <- quis.getVariable(engine1, "meanDailyTemp")
#'
#' \dontrun{
#' engine1 <- quis.getEngine()
#' quis.loadProcess(engine1, system.file("extdata", "ex2.xqt", package="RQUIS"))
#' quis.runProcess(engine1)
#' dlm <- quis.getVariable(engine1, "meanDailyTemp")
#' }
#'
#' @export
quis.getVariable <- function(engine, variableName){
  # check weather the variable exist
  # check weather the variable conatins data
  # try to get the data nad schema...
  #exTime <- system.time({
  data <- .jcall(engine,"Ljava/lang/Object;","getVariable", variableName)
  if(is.null(data))
    return (NULL)
  schema <- .jcall(engine,"Ljava/lang/Object;","getVariableSchema", variableName)
  #})
  #dfTime <- system.time({
    df=as.data.frame(lapply(.jevalArray(data), .jevalArray))
    names(df) = as.vector(.jevalArray(schema))
  #})
  return(df)
}

#' Gets the schema of a variable.
#'
#' \code{quis.getVariableSchema} Gets the schema of a variable, as a data frame.
#'
#' @param engine the engine instance created by \code{quis.getEngine}
#' @param variableName the variable name.
#' @param extended determine whether simple or semantically enhanced schema should be returned.
#' @return A data frame that contains name, type, constaints, and semantic annotation of the attributes of the target variable's schema.
#' @examples
#' engine1 <- quis.getEngine()
#' quis.loadProcess(engine1, system.file("extdata", "ex2.xqt", package="RQUIS"))
#' quis.runProcess(engine1)
#' scm <- quis.getVariableSchema(engine1, "meanDailyTemp")
#'
#' \dontrun{
#' engine1 <- quis.getEngine()
#' quis.loadProcess(engine1, system.file("extdata", "ex2.xqt", package="RQUIS"))
#' quis.runProcess(engine1)
#' scm <- quis.getVariableSchema(engine1, "meanDailyTemp")
#' }
#'
#' @export
quis.getVariableSchema <- function(engine, variableName, extended = FALSE){
  data <- .jcall(engine,"Ljava/lang/Object;","getPerspectiveFor", variableName)
  df=as.data.frame(lapply(.jevalArray(data), .jevalArray))
  #df <-  data.frame(x = 1:3, y = 5:7, z = 10:12, p = 20:22)
  schema <- c("name", "type", "constraints", "annotation")
  names(df) = as.vector(schema)
  return(df)
}

#' Reports the result of the execution.
#'
#' \code{quis.getRunReport} Reports whether execution of the proceess has encountered any error.
#'
#' @param engine the engine instance created by \code{quis.getEngine}
#' @return A verbose report explaining the execution of each statement including the overall execution time, result size, and errors.
#' @examples
#' engine1 <- quis.getEngine()
#' addedScript <- quis.loadProcess(engine1, system.file("extdata", "ex2.xqt", package="RQUIS"))
#' quis.runProcess(engine1)
#' err <- quis.getRunReport(engine1)
#' \dontrun{
#' engine1 <- quis.getEngine()
#' addedScript <- quis.loadProcess(engine1, system.file("extdata", "ex2.xqt", package="RQUIS"))
#' quis.runProcess(engine1)
#' err <- quis.getRunReport(engine1)
#' }
#'
#' @export
quis.getRunReport <- function(engine){
  getErrorsReturnValue <- .jcall(engine,"S","getErrors")
  return(getErrorsReturnValue)
}