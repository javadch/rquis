.onLoad <- function (libname, pkgname) {
  options(java.parameters = "-Xmx8000m") # set the max Java heap size in MB
  .jpackage(pkgname, jars = '*', lib.loc = libname)
}
