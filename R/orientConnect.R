#' @rdname orientConnect
#' @export
#' @import RCurl jsonlite tidyr lubridate magrittr
#'
#' @title
#' Connect to OrientDB DataBase
#'
#' @description
#' \code{orientConnect} Execute a SQL query against the OrientDB database.
#'
#' @author
#' Mahmood S. Zargar \email{mahmood@gmail.com}
#' Mohamed Karim Bouaziz \email{mohamed.karim.bouaziz@gmail.com}
#'
#' @seealso \code{\link{orientDataBases}}, \code{\link{orientDataBaseDetail}}
#'
#' @param host The host name to the OrientDB DataBase (by default "localhost").
#'
#' @param username The username of the OrientDB DataBase.
#'
#' @param password The password of the OrientDB DataBase.
#'
#' @param port The Port of OrientDB DataBase (by default 2480)
#'
#' @examples \dontrun{
#' orient<-orientConnect(host = "localhost", username = "admin", password = "admin", port = "2480")
#'
orientConnect <-
  function(host = "localhost", username = "admin", password = "admin", port = "2480") {
    up <- paste(username, password, sep = ":")
    sp <- paste(host, port, sep = ":")
    orient<-paste(up, sp, sep = "@")
    sub(pattern = "https?://","",orient)
  }
