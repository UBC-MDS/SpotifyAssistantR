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


#' Creates a playlist of recommended songs.
#'
#' A wrapper function that first retrieves a user's top 3 artists,
#' then uses this information to generate a list of 10 recommended songs.
#' If the user does not have any top artist information, then genre seeds
#' are used instead.
#' A new playlist is created for the user, which contains the
#' recommended songs.
#' Prints a url link to the new playlist on Spotify.
#'
#' @param playlist_name The name of the new playlist, a string. Defaults to
#' "Recommended Songs" with the current date.
#' @param num_songs The number of new songs to generate. Must be an integer
#' between 1 and 100 (inclusive).
#'
#' @return
#' @export
#'
#' @examples
#' get_song_recommendations()
get_song_recommendations <- function(playlist_name = None, num_songs = 10) {

}
