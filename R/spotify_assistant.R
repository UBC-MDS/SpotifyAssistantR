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
#' @return List of new track releases in the given continent
#' @examples
#' get_new_releases_by_continent('Asia', 10)
#' get_new_releases_by_continent('Europe', 15)
get_new_releases_by_continent <- function(country_code, n_limit) {

}

#' Get all the songs from a user's playlists
#'
#' A wrapper function that gets the names of all songs contained in one or more
#' of a user's owned and saved playlists. By default, all songs from all playlists
#' are returned, but playlists can also be specified by name.
#'
#' @param playlists a character vector containing the playlist names, defaults to all
#' @return list containing a vector of song names from the playlists
#' @export
#'
#' @examples
#' get_playlists_songs()
#' get_playlists_songs('night drives')
#' get_playlists_songs(c('night drives', 'boss rush'))
get_playlists_songs <- function(playlists = NULL) {
}







