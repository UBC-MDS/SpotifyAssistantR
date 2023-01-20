library(spotifyr)
library(tidyverse)
library(dplyr)

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

#' Finds the top 5 genres from a user's saved tracks
#'
#' A wrapper function that goes through a user's entire saved library.
#' For each song, it checks all the artist involved and the genre of music
#' they compose. It returns the top 5 most commonly occurring genres.
#'
#' @return Character vector containing the top 5 genres of music in the User's saved library
get_users_top_genres <- function() {

}
