#' Get all the names and ids of a user's playlists
#'
#' @param authorization an authorization token for the Spotify API
#' @return dataframe containing the names and IDs of playlists
#' @import spotifyr get_my_playlists

get_all_playlists <- function(authorization) {

  # get playlists
  unadded_playlists <- spotifyr::get_my_playlists(authorization = authorization)
  if (length(unadded_playlists) == 0) {
    stop('No playlists were found.')
  }

  # make overall playlist df
  all_playlists <- data.frame(
    matrix(nrow = 0, ncol = ncol(unadded_playlists))
  )
  names(all_playlists) <- names(unadded_playlists)
  n_playlists <- 0

  # keep adding playlists
  while (!is.null(nrow(unadded_playlists))) {
    all_playlists <- rbind(all_playlists, unadded_playlists)
    n_playlists <- n_playlists + nrow(unadded_playlists)
    unadded_playlists <- spotifyr::get_my_playlists(
      authorization = authorization,
      offset = n_playlists
    )
  }

  return(all_playlists)
}

#' Filters a dataframe of playlists
#'
#' @param all_playlists a dataframe containing names and IDs of playlists
#' @param playlist_names a character vector containing the playlist names, defaults to all
#' @return dataframe containing the names and IDs of playlists
#' @import dplyr filter
#' @export

filter_playlists <- function(all_playlists, playlist_names = NULL) {
  # check that playlist_names are a character vector
  if (!is.null(playlist_names) & !is.character(playlist_names)) {
    stop('playlist_names must be a character vector')
  } else if (is.null(playlist_names)) {
    filtered_playlists <- all_playlists |>
      dplyr::filter(public == TRUE | collaborative == TRUE) |>
      select(name, id)
  } else {
    # if not null then filter the names
    filtered_playlists <- all_playlists |>
      dplyr::filter(public == TRUE | collaborative == TRUE) |>
      dplyr::filter(name %in% playlist_names) |>
      select(name, id)
  }
  return(filtered_playlists)
}

#' Get all the songs from a playlist
#'
#' @param playlist_id a character string containing the ID for a Spotify playlist
#' @return character vector containing song names
#' @import spotifyr get_playlist_tracks

get_one_playlist_songs <- function(playlist_id) {
  all_songs <- c()
  n_songs <- 0
  # get first batch of songs
  unadded_songs <- spotifyr::get_playlist_tracks(playlist_id = playlist_id)

  # if no songs are found just return an empty vector
  if (length(unadded_songs) == 0) {
    return(all_songs)
  }

  #keep getting songs
  while (!is.null(nrow(unadded_songs))) {
    all_songs <- append(all_songs, unadded_songs$`track.name`)
    n_songs <- n_songs + nrow(unadded_songs)
    unadded_songs <- spotifyr::get_playlist_tracks(
      playlist_id = playlist_id,
      authorization = spotifyr::get_spotify_access_token(),
      offset = n_songs
    )
  }

  return(all_songs)

}


#' Get all the songs from a user's playlists
#'
#' A wrapper function that gets the names of all songs contained in one or more
#' of a user's owned and saved playlists. By default, all songs from all playlists
#' are returned, but playlists can also be specified by name.
#'
#' @param playlist_names a character vector containing the playlist names, defaults to all
#' @return list containing a vector of song names from the playlists
#' @import spotifyr get_spotify_authorization_code
#' @import purrr map
#' @export
#'
#' @examples
#' get_playlists_songs()
#' get_playlists_songs('night drives')
#' get_playlists_songs(c('night drives', 'boss rush'))
get_playlists_songs <- function(playlist_names = NULL) {

  # get authorization code
  authorization <- spotifyr::get_spotify_authorization_code()

  # get user's playlists
  all_playlists <- get_all_playlists(authorization)

  # filter playlists (rows)
  filtered_playlists <- filter_playlists(all_playlists, playlist_names = NULL)

  # for each playlist, get songs
  playlists_songs <- list()

  for (i in 1:nrow(filtered_playlists)) {
    print(paste('getting songs for', filtered_playlists$name[i]))
    playlists_songs[[filtered_playlists$name[i]]] <- get_one_playlist_songs(
      playlist_id = filtered_playlists$id[i]
    )
  }

  return(playlists_songs)
}




