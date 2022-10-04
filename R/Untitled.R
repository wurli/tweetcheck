library(stringr)

str_segment <- function(x, width = 80, sep = "\\s") {
  
  lapply(str_locate_all(x, sep), function(locs) {
    
    match_starts <- locs[, 1]
    match_ends   <- locs[, 2]
    
    out <- character(length(match_starts))
    
    for (n in match_starts) {
      
      
      
    }
    
  })
  
}


str_segment("This is a test string", 10)
