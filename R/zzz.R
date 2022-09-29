.ct <- NULL

.onLoad <- function(libname, pkgname) {
  
  .ct <<- V8::v8()
  
  dep <- system.file("extdata/twitter-text.min.js", package = "twitter-text-demo")
  .ct$source(dep)
  
}