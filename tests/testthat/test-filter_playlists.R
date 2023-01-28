load('playlists.RData')

test_that("Error message is returned for invalid playlist names", {
  expect_error(filter_playlists(playlists, playlist_names = 2))
})

test_that("Filters properly with null playlist_names", {
  expect_equal(nrow(filter_playlists(playlists)), 11)
  expect_equal(ncol(filter_playlists(playlists)), 2)
})

test_that("Filters properly with playlist_names", {
  expect_equal(nrow(filter_playlists(playlists, playlist_names = 'boss rush')), 1)
  expect_equal(ncol(filter_playlists(playlists)), 2)
})
