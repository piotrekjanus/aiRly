#' @title Print for "airly_limit" type objects
#'
#' @param x "airly_limit" type list
#'
#' @param ... further arguments passed to or from other methods
#'
#' @export
#'

print.airly_limit <- function(x, ...) {
  # limit <- get("limit", envir = pkg.env, inherits = FALSE)
  # remaining <- get("remaining", envir = pkg.env, inherits = FALSE)
  # status <- floor(remaining/limit*10)
  # progress_bar <- paste(c("|",rep("#",status),rep(" ", 10-status),"|"), sep = "", collapse = "")
  # frac <- paste(remaining, limit, sep="/")
  # noquote(paste(frac, progress_bar, sep="    "))
  utils::str(x)
}

#' Creates an object representing Airly limit
#'
#' @return object representing an airly_limit
#'
create_airly_limit <- function() {
  airly_limit <- structure(
    list(
      limit = get("limit", envir = pkg.env),
      remaining = get("remaining", envir = pkg.env)
    )
  )
  class(airly_limit) <- "airly_limit"
  validate_airly_limit(airly_limit)
  airly_limit
}

#' Checks whether the given object is of the class
#' airly_limit
#'
#' @param x object to test if it is of the class airly_limit
#'
#' @return TRUE if the object is of the class airly_limit
#'
is_airly_limit <- function(x) {
  inherits(x, "airly_limit")
}

#' Checks whether the given object is correctly defined
#' airly_limit class
#'
#' @param airly_limit object of the class airly_limit

validate_airly_limit <- function(airly_limit) {
  assert(!is.null(airly_limit$limit), "You have to make at least one call, before getting this information")
  assert(!is.null(airly_limit$limit), "You have to make at least one call, before getting this information")
  assert(is_airly_limit(airly_limit), "Object must be of the class airly_limit")
}
