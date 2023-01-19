
<!-- README.md is generated from README.Rmd. Please edit that file -->

# SpotifyAssistantR

<!-- badges: start -->
<!-- badges: end -->

A R package that is built on top of spotifyr package with more practical functionalities to enhances spotify users' experience. Implemented via REST APIs

In specific, our aim is to create functions that combine multiple requests from the existing spotifyR package and provide supplementary insights for Spotify users. 

## Installation

You can install the development version of SpotifyAssistantR like so:

``` r
devtools::install_github('UBC-MDS/SpotifyAssistantR')
```

## Dependencies

We use spotifyR package to authenticate (getting and refreshing access tokens), acquire data and get user-specific information.
Install spotifyR with:

```r
install.packages('spotifyr')
```

## Environment Setup

To use the package we require you to supplement the client id and client secret in order to acquire token:

```r
Sys.setenv(SPOTIFY_CLIENT_ID = 'xxxxxxxxxxxxxxxxxxxxx')
Sys.setenv(SPOTIFY_CLIENT_SECRET = 'xxxxxxxxxxxxxxxxxxxxx')

access_token <- get_spotify_access_token()
```
This must be provided after loading the spotifyr library and before using the package. 

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

More usage examples goes here
