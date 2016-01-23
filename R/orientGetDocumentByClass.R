#' @rdname getUsers
#' @export
#'
#' @title
#' Extract information about one or more Facebook users
#'
#' @description
#' \code{getUsers} retrieves public information about one or more Facebook users.
#'
#' After version 2.0 of the Facebook API, only id, name, and picture are available
#' through the API. All the remaining fields will be missing.
#'
#' @author
#' Mahmood S. Zargar \email{mahmood@gmail.com}
#' Mohamed Karim Bouaziz \email{mohamed.karim.bouaziz@gmail.com}
#'
#' @seealso \code{\link{orientConnect}}, \code{\link{orientDataBases}}, \code{\link{orientDataBaseDetail}}
#'
#' @param users A vector of user IDs.
#'
#' @param token Either a temporary access token created at
#' \url{https://developers.facebook.com/tools/explorer} or the OAuth token
#' created with \code{fbOAuth}.
#'
#' @param private_info If \code{FALSE}, will return only information that is
#' publicly available for all users (name, gender, locale, profile picture).
#' If \code{TRUE}, will return additional information for users who are friends
#' with the authenticated user: birthday, location, hometown, and relationship
#' status. Note that these fields will ONLY be returned for friends and when
#' the version of the token that is used to query the API is 1.0. For other
#' users, they will be \code{NA}, even if they are visible on Facebook via web.
#'
#' @examples \dontrun{
#' ## See examples for fbOAuth to know how token was created.
#' ## Getting information about the authenticated user
#'  load("fb_oauth")
#'	fb <- getUsers("me", token=fb_oauth)
#'	fb$username
#' }
#'
orientGetDocumentByClass<-
  function(orient, database,className,recordPosition, ...) {
    request<-paste("http:/", orient, "documentbyclass", database,className,recordPosition, sep = "/")
    response <- getURL(request, .mapUnicode = FALSE)
    if(!int0(grep(pattern = "was not found",response))) { NA
    } else {
    results <- fromJSON(response, ...)
    results<-as.data.frame(results)
    names(results)<-sub("^X\\.","",names(results))
    results
    }
  }

