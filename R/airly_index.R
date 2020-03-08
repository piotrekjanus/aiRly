#' @title Print for "airly_index" type objects
#'
#' @param x "airly_index" type list
#'
#' @param ... further arguments passed to or from other methods
#'
#' @export
#'

print.airly_index <- function(x, ...) {
  utils::str(x)
}

#' Creates an object representing Airly index
#'
#' @param item list returned by Airly API
#'
#' @return object representing a airly_index
#'
create_airly_index <- function(item) {
  airly_index <- structure(
    item,
    class = "airly_index"
  )
  validate_airly_index(airly_index)
  airly_index
}

#' Checks whether the given object is of the class
#' airly_index
#'
#' @param x object to test if it is of the class airly_index
#'
#' @return TRUE if the object is of the class airly_index
#'
is_airly_index <- function(x) {
  inherits(x, "airly_index")
}

#' Checks whether the given object is correctly defined
#' airly_index class
#'
#' @param airly_index object of the class airly_index
#'
validate_airly_index <- function(airly_index) {
  assert(exists("id", where = airly_index), "Object's id is required")
  assert(is_airly_index(airly_index), "Object must be of the class airly_index")
}
