library(lingtypology)
context("Tests for abvd.feature function")

test_that("abvd.feature", {
  expect_error(abvd.feature(c("aa", "bb")), "You need to provide a numeric vector with language id from ABVD.")
})
