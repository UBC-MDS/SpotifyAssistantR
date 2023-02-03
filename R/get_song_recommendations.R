#' Get Top Artists
#'
#' Returns the current user's top artists from Spotify.
#'
#' @param authorization The authorization token or code for the user's account.
#'
#' @return A data frame containing artist information.
#' @importFrom spotifyr get_my_top_artists_or_tracks
#' @export

get_top_artists <- function(authorization = get_spotify_authorization_code()){
  user_artists <- spotifyr::get_my_top_artists_or_tracks(limit=3,
                                                         time_range='short_term',
                                                         authorization = authorization)
  user_artists
}

#' Extract Artist ID
#'
#' @param artists A vector containing artist information.
#'
#' @return A vector of artist IDs.
#' @export
extract_artist_id <- function(artists){
  if (is.null(artists$id)) {
    return(list())
  } else {
    top_artists <- artists$id
    return(top_artists)
  }
}

#' Get Genre Seeds
#'
#' @return A list of 5 genre seeds
#' @export
get_genre_seeds <- function() {
  all_genres <- get_all_genres()
  genre_seeds <- sample(all_genres, 5, replace = FALSE)
  genre_seeds
}

#' Get New Songs
#'
#' Returns a specified number of recommended songs from Spotify.
#'
#' @param authorization The authorization token or code for the user's account.
#' @param seed_type Either 'artists' or 'genres'. Default is 'artists'.
#' @param seeds A vector of artist or track ID's.
#' @param num_songs The number of recommended songs to return.
#' Must be between 1 and 100 (inclusive).
#'
#' @return A vector of track uri's for identifying specific tracks.
#' @importFrom spotifyr get_recommendations
#' @export
get_new_songs <- function(seed_type, seeds, num_songs=10, authorization=get_spotify_access_token()){
  stopifnot(num_songs <= 100)
  stopifnot(num_songs > 0)

  if (seed_type == 'artists') {
    rec_songs = spotifyr::get_recommendations(
      seed_artists = seeds,
      limit = num_songs,
      authorization=authorization)
  } else {
    rec_songs = spotifyr::get_recommendations(
      seed_genres = seeds,
      limit = num_songs,
      authorization=authorization)
  }
  new_songs <- rec_songs$id
  new_songs
}

#' Create a playlist
#'
#' Creates a new, empty playlist for the user on Spotify.
#'
#' @param authorization The authorization token or code for the user's account.
#' @param playlist_name The name of the new playlist.
#'
#' @return A list containing the url and playlist id for the new playlist.
#' @importFrom spotifyr get_my_profile
#' @importFrom spotifyr create_playlist
#' @export
create_playlist <- function(playlist_name, authorization=get_spotify_authorization_code()){
  if (is.null(playlist_name)) {
    current_date <- Sys.Date()
    playlist_name <- paste(current_date, "Recommended Songs")
  }

  user_id <- spotifyr::get_my_profile(authorization)$id

  new_playlist <- spotifyr::create_playlist(
    user_id = user_id,
    name=playlist_name,
    authorization = authorization
  )
  playlist_url <- new_playlist$external_urls$spotify
  playlist_id <- new_playlist$id
  return(list(playlist_url, playlist_id))
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
#' @importFrom spotifyr add_tracks_to_playlist
#' @export
#'
#' @examples
#' get_song_recommendations()
get_song_recommendations <- function(playlist_name = NULL, num_songs = 10) {
  # Get the user's top artist information
  artists_info = get_top_artists()

  # Check if the user does have top artist information, otherwise use genres instead
  if (length(artists_info) > 0) {
    seed_type <- 'artists'
    seeds <- extract_artist_id(artists_info)
  } else {
    seed_type <- 'genres'
    seeds <- get_genre_seeds()
  }

  # Get a list of recommended songs
  recommended_songs <- get_new_songs(seed_type, seeds)

  print(paste("Generating recommended songs based on", seed_type, "..."))

  # Create the new playlist on Spotify
  new_playlist <- create_playlist(playlist_name)
  playlist_url <- new_playlist[[1]]
  playlist_id <- new_playlist[[2]]

  # Add the recommended songs to the new playlist
  spotifyr::add_tracks_to_playlist(playlist_id, recommended_songs)

  # Paste the link to the new playlist
  print(paste("Here is a link to the new playlist:", playlist_url))

}
