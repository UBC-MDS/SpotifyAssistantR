load('artist_information.RData')

test_that("Get Top Genres function works as expected", {
  genres <- get_top_genres(artist_information)
  expect_equal(length(genres), 5)
})

test_that("Return an empty list when no artist information is passed", {
  genres <- get_top_genres(list())
  expect_equal(typeof(genres), "NULL")
  expect_equal(length(genres), 0)
})

test_that("Error message is returned for incorrect datatype of the input", {
  expect_error(get_top_genres(artist_information[[1]]))
})
