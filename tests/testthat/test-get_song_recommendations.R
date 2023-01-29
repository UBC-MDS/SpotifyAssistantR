example_df <- read.csv('example_artist_df.csv')

test_that("All of the artist IDs were extracted", {
  example_ids <- extract_artist_id(example_df)
  expect_equal(length(example_ids), 3)
})

test_that("Correct information was extracted", {
  example_ids <- extract_artist_id(example_df)
  expect_equal(example_ids[1], '6CY7WNJfd5uZclcS3WeEjx')
  expect_equal(example_ids[2], '2rRUfv2w535SEUV1YO5SP6')
  expect_equal(example_ids[3], '6uRJnvQ3f8whVnmeoecv5Z')
})

test_that("Return an empty list if there is no id information", {
  example_ids <- extract_artist_id(list())
  expect_equal(class(example_ids), 'list')
  expect_equal(length(example_ids), 0)
})
