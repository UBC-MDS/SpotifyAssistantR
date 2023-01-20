library(spotifyr)

#' Get new releases by continent
#'
#' This is a helper function that allows users to get new releases
#' by continent. It goes through all the countries in the region
#' and summaries the info of all releases. If we specify a n_limit
#' smaller than the total number of all releases available, it returns
#' the first n_limit releases by default
#'
#' @param country_cde A two digit string that
#' @param n_limit Number of new releases to return
#' @export
#' @examples
#' get_new_releases_by_continent('Asia', 10)
#' get_new_releases_by_continent('Europe', 15)
get_new_releases_by_continent <- function(country_code, n_limit) {

}
