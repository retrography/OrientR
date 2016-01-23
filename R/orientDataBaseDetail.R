#' @rdname orientDataBaseDetail
#' @export
#'
#' @title
#' get details of an OrientDB DataBase
#'
#' @description
#' \code{orientDataBaseDetail} Execute a SQL query against the OrientDB database.
#'
#' @author
#' Mahmood S. Zargar \email{mahmood@gmail.com}
#' Mohamed Karim Bouaziz \email{mohamed.karim.bouaziz@gmail.com}
#'
#' @seealso \code{\link{orientDataBases}}, \code{\link{orientConnect}}
#'
#' @param orient An element created with \code{orientConnect}.
#' @examples \dontrun{
#' ## See examples for \code{orientConnect} to know how \code{orient} element was created.
#' orientDataBaseDetail(orient)
#'
orientDataBaseDetail <-
  function(orient, database, ...) {
    request<-paste("http:/", orient, "database", database, sep = "/")
    response <- getURL(request, .mapUnicode = FALSE)
    results <- fromJSON(response, ...)[["classes"]]
    results[,c("name","superClass","abstract","clusters","defaultCluster","records")]
  }
