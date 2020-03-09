#' Asserts a given expression and throws an error
#' if it returns FALSE
#'
#' @param expression R expression to be evaluated
#'
#' @param error message to be displayed when the
#' expression is not fulfilled
#'
assert <- function(expression, error) {
  if (!expression) {
    stop(error, call. = FALSE)
  }
}


#' Checks whether ids are correctly defined. If not throws an error
#'
#' @param ids maximum number of ids to retrieve
#
assert_ids <- function(ids) {
  assert(all(is.numeric(ids)), "every id must be a numeric type")
  assert(all(ids > 0),
         "every id must be greater than 0")
}

#' Checks whether apikey is correctly set
#'
#' @param key airly apikey
#
assert_apikey <- function(key) {
  assert(!is.null(key), "You have to set apikey first! See set_apikey function.")
  assert(is.character(key), "apikey must be a string")
}

