.onLoad <- function (libname, pkgname) {
  options(java.parameters = "-Xmx8000m") # set the max Java heap size in MB
  if (Sys.getenv("JAVA_HOME")!="") # Unsetting JAV_HOME for current R session, as requested by rJava package
    Sys.setenv(JAVA_HOME="")
  .jpackage(pkgname, jars = '*', lib.loc = libname)
  # Do any other initialization here
}
