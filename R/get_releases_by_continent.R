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
  

#' Get all releases by continent
#'
#' @param continent continent name as a String
#' @param limit number of releases to extract
#' @return a list containing all info of selected new releases
#' @importFrom spotifyr get_my_playlists
get_releases <- function(continent, limit){
  
  cc_map <- get_map()
  
  if(limit <= 0){
    stop("Limit parameter invalid")
  }
  
  if(!continent %in% names(cc_map)){
    stop("Continent parameter invalid. Check for typos")
  }
  
  cat("-- Loading new releases in ", continent, ", this may take a while...", "\n")
  
  all_releases <- list()
  
  for(country_code in cc_map[[continent]]){
    if(is_valid_code(country_code)) {
      new_releases <- spotifyr::get_new_releases(country_code)
      all_releases[[country_code]] <- new_releases
    }
    
  }
  
  return(all_releases)
}






