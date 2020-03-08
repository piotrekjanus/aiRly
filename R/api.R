pkg.env <- new.env()
pkg.env$apikey <- NULL

#' Returns the base url of Airly API
#'
.base_url <- function() {
  'https://airapi.airly.eu/v2'
}


#' Sends a request to the specified url and retrieves it's content.
#'
#' @param request_url url to be used
#'
#' @return parsed content of the response object
#'
.send_request <- function(request_url, apikey) {
  response <- httr::GET(url = request_url,
                        httr::add_headers(Accept = "application/json",
                                          apikey = apikey))
  airly_response <- create_airly_api_response(response)
  validate_airly_api_response(airly_response)

  get_content(airly_response)
}


#' @title Set Airly apikey
#'
#' @description On a free plan, API consumer is required to use our API only in non-commercial projects.
#' More details are available in under \link(https://airly.eu/docs/tos-en.pdf).
#'
#' @param key string. Get your api key \link(https://developer.airly.eu/)
#'
#' @export
#'
#' @examples
#' \donttest{
#' set_apikey("abctest")
#' }
#'
set_apikey <- function(key) {
  assert(is.character(key), "apikey must be a string")
  assign("apikey", key, envir = pkg.env)
}


#' @title Get Airly apikey
#'
#' @description Get apikey that was set by user
#'
#' @return
#'
#' @examples
#' \donttest{
#' }
#'
.get_apikey <- function() {
  tryCatch(
    key <- get("apikey", envir = pkg.env),
    error = function(e) {
      key <- NULL
    }
  )
  key
}


#' @title Get Airly installation by id
#'
#' @description Endpoint returns single installation metadata, given by id
#'
#' @details
#'
#' @param id integer
#'
#' @export
#'
#' @return airly_index item
#'
#' @examples
#' \donttest{
#' get_installation_by_id(8077)
#' }
#'
get_installation_by_id <- function(id) {
  assert_ids(id)
  api_key <- .get_apikey()
  assert_apikey(api_key)

  request_url <- create_request_url(.base_url(), c("installations", id))
  item <- .send_request(request_url, api_key)
  create_airly_index(item)
}
