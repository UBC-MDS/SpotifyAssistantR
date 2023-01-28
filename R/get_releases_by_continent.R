#' Get the country list by continent
#'
#' @return A list containing all countries, by continent name

get_map <- function() {
  
  df <- read.csv("https://raw.githubusercontent.com/lukes/ISO-3166-Countries-with-Regional-Codes/master/all/all.csv")
  cc_map <- list()
  rownames(df) <- NULL
  
  for (i in 1:nrow(df)) {
    if(is.na(df[i,'alpha.2']) | df[i,'alpha.2'] == 'AQ'){
      next
    }
    cc_map[[df[i,'region']]] <- c(cc_map[[df[i,'region']]], df[i,'alpha.2'])
  }
  
  return(cc_map)
  
}
  



