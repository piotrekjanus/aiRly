#' @title Print for "airly_location" type objects
#'
#' @param x "airly_location" type list
#'
#' @param ... further arguments passed to or from other methods
#'
#' @export
#'

print.airly_location <- function(x, ...) {
  utils::str(x)
}

#' Creates an object representing Airly location
#'
#' @param item list returned by Airly API
#'
#' @return object representing a airly_location
#'
create_airly_location <- function(item) {
  airly_location <- structure(
    item,
    class = "airly_location"
  )
  validate_airly_location(airly_location)
  airly_location
}

#' Checks whether the given object is of the class
#' airly_location
#'
#' @param x object to test if it is of the class airly_location
#'
#' @return TRUE if the object is of the class airly_location
#'
is_airly_location <- function(x) {
  inherits(x, "airly_location")
}

#' Checks whether the given object is correctly defined
#' airly_location class
#'
#' @param airly_location object of the class airly_location
#'
validate_airly_location <- function(airly_location) {
  assert(exists("id", where = airly_location), "Object's id is required")
  assert(is_airly_location(airly_location), "Object must be of the class airly_location")
}
