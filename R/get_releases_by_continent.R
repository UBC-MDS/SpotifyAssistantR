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


#' Check if the country code is valid
#'
#' @param code country code to look up
#' @return If spotify is available in the country or not
region_not_available <- function(code) {
  americas_na = c("AI", "AW", "BM", "BQ", "BV", "KY", "CU", "FK", "GF", "GL", "GP", "MQ", "MS", "PR", "BL", "MF", "PM", "SX", "GS", "TC", "VG", "VI")
  asia_na = c("AF", "CN", "IR", "KP", "MM", "SY", "TM", "YE")
  oceania_na = c("AX", "FO", "GI", "GG", "VA", "IM", "JE", "RU", "SJ")
  europe_na = c("AS", "CX", "CC", "CK", "PF", "GU", "HM", "NC", "NU", "NF", "MP", "PN", "TK", "UM", "WF")
  africa_na = c("IO", "CF", "ER", "TF", "YT", "RE", "SH", "SO", "SS", "SD", "EH")
  return(code %in% americas_na | code %in% asia_na | code %in% oceania_na | code %in% europe_na | code %in% africa_na)
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
    # if(!region_not_available(country_code)) {
    #   new_releases <- spotifyr::get_new_releases(country_code)
    #   all_releases[[country_code]] <- new_releases
    # }
    if(region_not_available(country_code)) { next }
    tryCatch({
      new_releases <- get_new_releases(country_code)
      all_releases[[country_code]] <- new_releases
    }, error=function(e){
      print(country_code)
    })
    
  }
  
  return(all_releases)
}






