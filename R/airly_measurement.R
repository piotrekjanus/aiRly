#' @title Print for "airly_measurement" type objects
#'
#' @param x "airly_measurement" type list
#'
#' @param ... further arguments passed to or from other methods
#'
#' @export
#'

print.airly_measurement <- function(x, ...) {
  utils::str(x)
}

#' Creates an object representing Airly measurement
#'
#' @param item list returned by Airly API
#'
#' @return object representing a airly_measurement
#'
create_airly_measurement <- function(item) {
  browser()
  airly_measurement <- structure(
    list(
      current = build_current_df(item),
      history = build_history_df(item),
      forecast = build_forecast_df(item),
      raw_data = item
    ),
    class = "airly_measurement"
  )
  validate_airly_measurement(airly_measurement)
  airly_measurement
}

#' Creates an object representing Airly measurement
#'
#' @param item list returned by Airly API
#'
#' @return object representing a airly_measurement
#'
build_history_df <- function(item) {
  if (exists("history", where = item)) {
    history <- item$history
    values_df <- do.call(rbind, lapply(history$values, function(x) as.data.frame(t(x[2]))))
    row.names(values_df) <- 1:nrow(values_df)
    names(values_df) <- history$values[[1]]$name

    time_df <- data.frame(from = history$fromDateTime,
                          to = history$tillDateTime)

    indexes_df <- do.call(rbind, lapply(history$indexes, function(x) as.data.frame(x)))
    indexes_df <- reshape2::acast(indexes_df, value~name)
    row.names(indexes_df) <- 1:nrow(indexes_df)

    airly_history <- cbind(time_df, values_df, indexes_df)
    airly_history

  } else {
    warning("History is not available for this point")
    NULL
  }

}

#' Creates an object representing Airly measurement
#'
#' @param item list returned by Airly API
#'
#' @return object representing a airly_measurement
#'
build_forecast_df <- function(item) {
  if (exists("forecast", where = item)) {
    forecast <- item$forecast
    values_df <- do.call(rbind, lapply(forecast$values, function(x) as.data.frame(t(x[2]))))
    row.names(values_df) <- 1:nrow(values_df)
    names(values_df) <- forecast$values[[1]]$name

    time_df <- data.frame(from = forecast$fromDateTime,
                          to = forecast$tillDateTime)

    indexes_df <- do.call(rbind, lapply(forecast$indexes, function(x) as.data.frame(x)))
    indexes_df <- reshape2::acast(indexes_df, value~name)
    row.names(indexes_df) <- 1:nrow(indexes_df)

    airly_forecast <- cbind(time_df, values_df, indexes_df)
    airly_forecast

  } else {
    warning("Forecast is not available for this point")
    NULL
  }

}

#' Creates an object representing Airly measurement
#'
#' @param item list returned by Airly API
#'
#' @return object representing a airly_measurement
#'
build_current_df <- function(item) {
  if (exists("current", where = item)) {
    current <- item$current
    values_df <- as.data.frame(t(current$values[[2]]))
    row.names(values_df) <- 1:nrow(values_df)
    names(values_df) <- current$values$name

    time_df <- data.frame(from = current$fromDateTime,
                          to = current$tillDateTime)

    indexes_df <-  as.data.frame(current$indexes)
    indexes_df <- reshape2::acast(indexes_df, value~name)
    row.names(indexes_df) <- 1:nrow(indexes_df)

    airly_current <- cbind(time_df, values_df, indexes_df)
    airly_current

  } else {
    warning("Current data is not available for this point")
    NULL
  }

}

#' Checks whether the given object is of the class
#' airly_measurement
#'
#' @param x object to test if it is of the class airly_measurement
#'
#' @return TRUE if the object is of the class airly_measurement
#'
is_airly_measurement <- function(x) {
  inherits(x, "airly_measurement")
}

#' Checks whether the given object is correctly defined
#' airly_measurement class
#'
#' @param airly_measurement object of the class airly_measurement
#'
validate_airly_measurement <- function(airly_measurement) {
  # assert(exists("id", where = airly_measurement), "Object's id is required")
  assert(is_airly_measurement(airly_measurement), "Object must be of the class airly_measurement")
}

