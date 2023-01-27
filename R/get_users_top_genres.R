# Sys.setenv(SPOTIFY_CLIENT_ID = '74652d1e1b664c34bacea50da044afc2')
# Sys.setenv(SPOTIFY_CLIENT_SECRET = 'a76de7b1d254428e8200ea9c74ad3b77')

# get authorization code (saves as object named authorization)
authorization <- spotifyr::get_spotify_authorization_code(
  client_id = Sys.getenv("SPOTIFY_CLIENT_ID"),
  client_secret = Sys.getenv("SPOTIFY_CLIENT_SECRET"),
  scope = "playlist-read-private playlist-read-collaborative playlist-modify-private user-library-read user-top-read playlist-modify-private playlist-modify-public"
)


#' Get the user's saved tracks
#'
#' A function that iteratively calls the Spotify API to get a user's
#' saved tracks and the metadata pertaining to each track.
#'
#' @return A dataframe containing metadata of the user's saved tracks.
get_saved_tracks <- function() {
  saved_tracks <- data.frame()
  offset = 0
  tracks <- spotifyr::get_my_saved_tracks(limit = 50,
                                          offset = offset,
                                          authorization = authorization)

  while (length(tracks) != 0) {
    saved_tracks <- rbind(saved_tracks, tracks)
    offset <- offset + nrow(tracks)
    tracks <- spotifyr::get_my_saved_tracks(limit = 50,
                                            offset = offset,
                                            authorization = authorization)
    break
  }
  saved_tracks
}

#' Get Artist information
#'
#' A function that iteratively calls the Spotify API #' to get
#' information on all the artists present in a list of tracks.
#'
#' @param saved_tracks A dataframe containing metadata of the user's saved tracks.
#' @return A list containing metadata of all the artists.
#' @examples get_all_artists(dataframe_of_tracks)
get_all_artists <- function(saved_tracks){
  artists <- c()
  artist_information <- list()

  track_artists <- saved_tracks['track.artists'][[1]]
  for(track_artist in track_artists){
    artists <- append(artists, track_artist$id)
  }

  ids <- unique(artists)
  print(length(ids))
  for(id in ids){
    artist_information[length(artist_information)+1] <- list(spotifyr::get_artist(id))
  }

  artist_information
}

#' Get the top genres
#'
#' A function that that iterates through a list of genres, counts the number of
#' occurrences of each genres and returns the top 5 occurrences.
#'
#' @param artist_information A list containing metadata of all the artists.
#' @return A vector containing the top 5 occurrences.
#' @examples get_top_genres(artist_information)
get_top_genres <- function(artist_information) {
  genres <- list()
  for(info in artist_information){
    if (!is.null(info$genres)){
      genres <- append(genres, info$genres)
    }
  }
  genres
}

#' Finds the top 5 genres from a user's saved tracks
#'
#' A wrapper function that goes through a user's entire saved library.
#' For each song, it checks all the artist involved and the genre of music
#' they compose. It returns the top 5 most commonly occurring genres.
#'
#' @return Character vector containing the top 5 genres of music in the User's saved library.
get_users_top_genres <- function() {
  saved_tracks <- get_saved_tracks()
  artist_information <- get_all_artists(saved_tracks)
  genres <- get_top_genres(artist_information)
  names(sort(table(unlist(genres)),decreasing=TRUE)[1:5])
}