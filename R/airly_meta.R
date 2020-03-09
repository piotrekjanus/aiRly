#' @title Print for "airly_meta" type objects
#'
#' @param x "airly_meta" type list
#'
#' @param ... further arguments passed to or from other methods
#'
#' @export
#'

print.airly_meta <- function(x, ...) {
  utils::str(x)
}

#' Creates an object representing Airly meta
#' @param item list returned by Airly API
#' @return object representing an airly_meta
#'
create_airly_meta <- function(item) {
  if (exists("name", where = item) & exists("levels", where = item)) {
    for( i in 1:length(item$name)) {
      item$levels[[i]]$name <- item$name[i]
    }
    item <- do.call(rbind, item$levels)
    item <- item[, -which(names(item) %in% c("values", "level"))]
    airly_meta <- structure(
      item,
      class =  "airly_meta"
    )
    validate_airly_meta(airly_meta)
    airly_meta
  } else {
    NULL
  }
}

#' Checks whether the given object is of the class
#' airly_meta
#'
#' @param x object to test if it is of the class airly_meta
#'
#' @return TRUE if the object is of the class airly_meta
#'
is_airly_meta <- function(x) {
  inherits(x, "airly_meta")
}

#' Checks whether the given object is correctly defined
#' airly_meta class
#'
#' @param airly_meta object of the class airly_meta
validate_airly_meta <- function(airly_meta) {
  assert(all(c("name", "minValue","maxValue" %in% names(airly_meta))), "Object must be of the class airly_meta")
  assert(is_airly_meta(airly_meta), "Object must be of the class airly_meta")
}
