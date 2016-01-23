#' @rdname orientSql
#' @importFrom RCurl getURL curlEscape
#' @importFrom jsonlite fromJSON
#' @importFrom lubridate parse_date_time
#' @importFrom tidyr %>% extract complete unnest_
#' @export
#'
#' @title
#' Execute a SQL query against the OrientDB database
#'
#' @description
#' \code{orientSql} Execute a SQL query against the OrientDB database.
#'
#' @author
#' Mahmood S. Zargar \email{mahmood@gmail.com}
#' Mohamed Karim Bouaziz \email{mohamed.karim.bouaziz@gmail.com}
#'
#' @seealso \code{\link{orientConnect}}, \code{\link{orientDataBases}}, \code{\link{orientDataBaseDetail}}
#'
#' @param orient An element created with \code{orientConnect}.
#'
#' @param database The database to be user in SQL Query.
#'
#' @param batch The number of record in return data (in SELECT Query), default is \code{-1} it means unlimited records.
#'
#' @param conv.dates
#'
#' @param auto.na
#' @param date.fmt
#' @param rm.meta
#' @param auto.na
#' @param conv.rid
#' @param unwind
#' @param formats
#'
#' @examples \dontrun{
#' ## See examples for \code{orientConnect} to know how \code{orient} element was created.
#' ## See examples for \code{orientDataBases} to know how \code{database} element was created.
#' query<-"select * from OUser"
#' database<-"Employer"
#' orientSql(orient,database, query)
#'
orientSql <-
  function(orient,database, query, batch = -1, conv.dates = TRUE, date.fmt = "ymd", auto.na = TRUE, rm.meta = TRUE, conv.rid = FALSE, unwind = FALSE, formats =
             c(),verbos=FALSE, ...) {
    orient<-paste("http:/", orient, "query", database, "sql", sep = "/")
    request <- paste(orient, curlEscape(query), batch, sep = '/')
    response <- getURL(request, .mapUnicode = FALSE)

    if(!int0(grep(pattern="^select",query,ignore.case = T))){
    results <- fromJSON(response, ...)[["result"]]
    fts <-
      if (!is.null(results[["@fieldTypes"]]))
        ft.list(results[["@fieldTypes"]]) else c()

    if (rm.meta) results <- auto.clean(results)

    # Supress all the name in the vector with more than one value
    fts <- fts[sapply(names(fts), function(x) length(fts[names(fts)==x])==1)]

    if (!conv.dates)
      fts <- fts[fts != "t"]
    if (!conv.rid)
      fts <- fts[fts != "x"]
    if (!unwind)
      fts <- fts[!fts %in% c("g", "z")]

    # Add the manually mentioned formats, overriding the eventual automatic conversions on the same fields
    fts <- c(fts[!names(fts) %in% names(formats)], formats)

    for (col in names(fts)) {
      if (any(fts[[col]] %in% c("list", "vector", "g", "z"))) {
        results <- unwind(results, cols=col)
      }

      if (any(fts[[col]] %in% c("x", "rid"))) {
        results <- conv.rid(results, cols=col)
      } else if (any(fts[[col]] %in% c("t", "time", "date", "datetime"))) {
        results <- conv.date(results, cols=col, fmt=date.fmt)
      } else if (any(fts[[col]] %in% c("factor"))) {
        results <- conv.factor(results, cols=col)
      }
    }

    if (auto.na)
      conv.null(results)
    else
      results
    } else if(!int0(grep(pattern="^insert",query,ignore.case = T))){

      #       if(verbos){
      #       tableQueried<-sub("^insert into ","",query,ignore.case = T)
      #       tableQueried<-sub("\\s+.+$","",tableQueried,ignore.case = T)
      #       message(paste0("Record inserted into ",tableQueried," table!"))}

    } else if(!int0(grep(pattern="^update",query,ignore.case = T))){

      #       if(verbos){
      #       tableQueried<-sub("^update ","",query,ignore.case = T)
      #       tableQueried<-sub("\\s+.+$","",tableQueried,ignore.case = T)
      #       message(paste0("Record updated into ",tableQueried," table!"))}

    } else if(!int0(grep(pattern="^delete",query,ignore.case = T))){

      #       if(verbos){
      #       tableQueried<-sub("^delete ","",query,ignore.case = T)
      #       tableQueried<-sub("\\s+.+$","",tableQueried,ignore.case = T)
      #       message(paste0("Record deleted from ",tableQueried," table!"))}

    }else {
      warning("Bad Query !!")

    }



  }
