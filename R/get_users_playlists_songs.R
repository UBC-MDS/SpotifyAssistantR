#' Get all the names and ids of a user's playlists
#'
#' @param authorization an authorization token for the Spotify API
#' @return dataframe containing the names and IDs of playlists

get_all_playlists <- function(authorization) {

  # get playlists
  unadded_playlists <- spotifyr::get_my_playlists(authorization = authorization)
  if (length(unadded_playlists) == 0) {
    stop('No playlists were found.')
  }

  # make overall playlist df
  all_playlists <- data.frame(
    matrix(nrow = 0, ncol = 2)
  )
  names(all_playlists) <- c('name', 'id')
  n_playlists <- 0

  # keep adding playlists
  while (!is.null(nrow(unadded_playlists))) {
    all_playlists <- rbind(all_playlists, unadded_playlists[c('name', 'id')])
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
#' @export

filter_playlists <- function(all_playlists, playlist_names = NULL) {
  # if null return all
  if (is.null(playlist_names)) {
    return(all_playlists)
  } else {
    # if not null then filter the names
    filtered_playlists <- filter(all_playlists, name %in% playlist_names)
  }
  return(filtered_playlists)
}

#' Get all the songs from a user's playlists
#'
#' A wrapper function that gets the names of all songs contained in one or more
#' of a user's owned and saved playlists. By default, all songs from all playlists
#' are returned, but playlists can also be specified by name.
#'
#' @param credentials a list containing the client ID and secret
#' @param playlist_names a character vector containing the playlist names, defaults to all
#' @return list containing a vector of song names from the playlists
#' @export
#'
#' @examples
#' get_playlists_songs()
#' get_playlists_songs('night drives')
#' get_playlists_songs(c('night drives', 'boss rush'))
get_playlists_songs <- function(credentials, playlist_names = NULL) {

  # get authorization code
  authorization <- spotifyr::get_spotify_authorization_code(
    client_id = credentials$id,
    client_secret = credentials$secret
  )

  # get user's playlists
  all_playlists <- get_all_playlists(authorization)

  # filter playlists (rows)
  filtered_playlists <- filter_playlists(all_playlists, playlist_names = NULL)

  # for each playlist, get songs
  playlist_songs <- list()
  return(filtered_playlists)
}




