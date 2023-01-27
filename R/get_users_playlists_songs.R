#' Get all the songs from a user's playlists
#'
#' A wrapper function that gets the names of all songs contained in one or more
#' of a user's owned and saved playlists. By default, all songs from all playlists
#' are returned, but playlists can also be specified by name.
#'
#' @param credentials a list containing the client ID and secret
#' @param playlists a character vector containing the playlist names, defaults to all
#' @return list containing a vector of song names from the playlists
#' @export get_playlists_songs
#'
#' @examples
#' get_playlists_songs()
#' get_playlists_songs('night drives')
#' get_playlists_songs(c('night drives', 'boss rush'))
#'
get_all_playlists <- function(authorization) {

  # get playlists
  unadded_playlists <- spotifyr::get_my_playlists(authorization = authorization)
  if (length(unadded_playlists) == 0) {
    stop('No playlists were found.')
  }

  # make overall playlist df
  all_playlists <- data.frame(
    matrix(nrow = 0, ncol = length(names(unadded_playlists)))
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

get_playlists_songs <- function(credentials, playlists = NULL) {

  # get authorization code
  authorization <- spotifyr::get_spotify_authorization_code(
    client_id = client_credentials$id,
    client_secret = client_credentials$secret
  )

  # get user's playlists
  all_playlists <- get_all_playlists(authorization)

  # filter playlists (rows + columns)



  # for each playlist, get songs

}




