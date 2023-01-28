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

--------

  #' Get Top Artists
  #'
  #' Returns the current user's top artists from Spotify.
  #'
  #' @param object
  #'
  #' @return A data frame containing artist information
  #' @export
  #'
  #' @examples
get_top_artists <- function(object){
  user_artists <- get_my_top_artists_or_tracks(limit=3, time_range='short_term')
  user_artists
}


#' Extract Artist ID
#'
#' @param artists A vector containing artist information
#'
#' @return A vector of artist IDs
#' @export
#'
#' @examples
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
#' @param object
#'
#' @return A list of 5 genre seeds
#' @export
#'
#' @examples
get_genre_seeds <- function(object) {
  all_genres <- c('classical', 'acoustic', 'country', 'guitar', 'hip-hop')
  all_genres
}

#' Get New Songs
#'
#' Returns a specified number of recommended songs from Spotify.
#'
#' @param object
#' @param seed_type Either 'artists' or 'genres'. Default is 'artists'.
#' @param seeds A vector of artist or track ID's.
#' @param num_songs The number of recommended songs to return.
#' Must be between 1 and 100 (inclusive).
#'
#' @return A vector of track uri's for identifying specific tracks.
#' @export
#'
#' @examples
get_new_songs <- function(object, seed_type, seeds, num_songs=10){
  stopifnot(num_songs <= 100)
  stopifnot(num_songs > 0)

  if (seed_type == 'artists') {
    rec_songs = get_recommendations(
      seed_artists = seeds,
      limit = num_songs)
    )
  } else {
    rec_songs = get_recommendations(
      seed_genres = seeds,
      limit = num_songs)
  }
  new_songs <- rec_songs$uri
  new_songs
}


#' Create a playlist
#'
#' Creates a new, empty playlist for the user on Spotify.
#'
#' @param object
#' @param playlist_name The name of the new playlist.
#'
#' @return A list containing the url and playlist id for the new playlist.
#' @export
#'
#' @examples
create_playlist <- function(object, playlist_name){
  if (is.null(playlist_name)) {
    current_date <- Sys.Date()
    playlist_name <- paste(current_date, "Recommended Songs")
  }

  new_playlist <- create_playlist(
    user_id = 'user_id',
    name=playlist_name
  )
  playlist_url <- new_playlist$spotify
  playlist_id <- new_playlist$id
  return(list(playlist_url, playlist_id))
}



def __add_songs_to_playlist(self, playlist_id, new_songs):
  """Adds songs to a specified user playlist on Spotify.

        Parameters
        ----------
        playlist_id: str
            The id of the new playlist.

        new_songs: list
            List of track ID's corresponding to songs to add to the playlist.

        """
self.sp.playlist_add_items(playlist_id=playlist_id, items = new_songs)


def get_song_recommendations(self, playlist_name = None, num_songs = 10):
  """Creates a playlist containing recommended songs based on the user's top 3 artists.
        If there are not yet any top artists for the user's account,
        use genres instead.

        Prints a url link to the new playlist on Spotify.

        Parameters
        ----------
        playlist_name : str
            The name of the newly created playlist. Defaults to 'Recommended Songs'
            with the current date (i.e. "2023-01-14 Recommended Songs").

        num_songs : int
            The number of songs to recommend. Must be between 1 and 100 (inclusive).

        Examples
        --------
        >>> credentials = {}
        >>> RandomUser = User(credentials)
        >>> RandomUser.get_song_recommendations("Recommended Songs")
        """

artist_info = self.__get_top_artists()

if len(artist_info) > 0:
  seed_type = 'artists'
seeds = self.extract_artist_id(artist_info)
else:
  seed_type = 'genres'
seeds = self.__get_genre_seeds()

recommended_songs = self.get_recommended_songs(seed_type, seeds, num_songs)

print(f"Generating recommended songs based on {seed_type}...")

playlist_url, playlist_id = self.__create_playlist(playlist_name)

self.__add_songs_to_playlist(playlist_id, recommended_songs)

print(f"Here is a link to the new playlist: {playlist_url}")

