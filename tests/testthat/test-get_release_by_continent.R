
library(digest)

cc_map <- get_map()

test_that("Expect to load the correct number of continents", {
  expect_equal(length(cc_map), 5)
})

test_that("Expect to load the correct number of countries", {
  expect_equal(length(cc_map$Asia), 51)
  expect_equal(length(cc_map$Europe), 51)
  expect_equal(length(cc_map$Americas), 57)
  expect_equal(length(cc_map$Africa), 59)
  expect_equal(length(cc_map$Oceania), 29)
})

test_that("Expect to load the correct number of continents", {
  expect_equal(sha1(as.character(cc_map)), "fb2a593b6a7544a91dfc8ad3bc571fdb9d299164")
})