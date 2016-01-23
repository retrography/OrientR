#' @rdname orientDataBases
#' @export
#'
#' @title
#' Extract names of all OrientDB DataBases.
#'
#' @description
#' \code{orientDataBases} Extract names of all OrientDB DataBases.
#'
#' @author
#' Mahmood S. Zargar \email{mahmood@gmail.com}
#' Mohamed Karim Bouaziz \email{mohamed.karim.bouaziz@gmail.com}
#'
#' @seealso \code{\link{orientConnect}}, \code{\link{orientDataBaseDetail}}
#' @param orient An element created with \code{orientConnect}.
#' @examples \dontrun{
#' ## See examples for \code{orientConnect} to know how \code{orient} element was created.
#' orientDataBases(orient)
#'
orientDataBases<-function(orient){
  request<-paste("http:/", orient,"listDatabases",sep="/")
  response <- getURL(request, .mapUnicode = FALSE)
  results <- fromJSON(response)[["databases"]]
  results
}
