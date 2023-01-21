
<!-- README.md is generated from README.Rmd. Please edit that file -->

# SpotifyAssistantR

<!-- badges: start -->
<!-- badges: end -->

In this project, we aim to create a package in R that builds on top of
the spotifyr package and offers more useful features to improve the
Spotify user experience.

This is achieved by utilizing REST APIs to implement the functions.
Additionally, our package will combine multiple requests from the
spotifyR package to provide additional insights for Spotify users.

## Authors

- Caroline Tang
- Chester Wang
- Jenit Jain
- Julie Song

This package was originally created as part of the requirements of
DSCI524 (Collaborative Software Development), a course in the Master of
Data Science program at the University of British Columbia. All original
members of this project abided by the [Code of
Conduct](CODE_OF_CONDUCT.md).

## Installation

You can install the development version of SpotifyAssistantR like so:

``` r
devtools::install_github('UBC-MDS/SpotifyAssistantR')
```

## Dependencies

We use spotifyR package to authenticate (getting and refreshing access
tokens), acquire data and get user-specific information. Install
spotifyR with:

``` r
install.packages('spotifyr')
```

## Environment Setup

To use the package we require you to supplement the client id and client
secret in order to acquire token:

``` r
Sys.setenv(SPOTIFY_CLIENT_ID = 'xxxxxxxxxxxxxxxxxxxxx')
Sys.setenv(SPOTIFY_CLIENT_SECRET = 'xxxxxxxxxxxxxxxxxxxxx')

access_token <- get_spotify_access_token()
```

This must be provided after loading the spotifyr library and before
using the package.

## Usage

This is a basic example which shows you how to solve a common problem:

``` r
library(SpotifyAssistantR)
get_new_releases_by_continent(country_code='Asia', n_limit=3)
# [[1]]
# [1] "Renegade"
# 
# [[2]]
# [1] "LANDER"
# 
# [[3]]
# [1] "Dreaming of You"
```
