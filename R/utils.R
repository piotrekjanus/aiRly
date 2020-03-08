#' Parses a json response
#'
#' @param response response object to parse
#'
#' @return parsed content of the given response
#'
parse_json <- function(response) {
  assert(httr::http_type(response) == "application/json",
         "The given response is not of type json")

  content <- httr::content(response, "text")
  jsonlite::fromJSON(content)
}
