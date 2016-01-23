orientSql <-
  function(orient,database, query, batch = -1, conv.dates = TRUE, date.fmt = "ymd", auto.na = TRUE, rm.meta = TRUE, conv.rid = FALSE, unwind = FALSE, formats =
             c(), ...) {
    orient<-paste("http:/", orient, "query", database, "sql", sep = "/")
    request <- paste(orient, curlEscape(query), batch, sep = '/')
    response <- getURL(request, .mapUnicode = FALSE)

    if(!int0(grep(pattern="select",query,ignore.case = T))){
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
    } else if(!int0(grep(pattern="insert",query,ignore.case = T))){

    } else if(!int0(grep(pattern="update",query,ignore.case = T))){

    } else if(!int0(grep(pattern="delete",query,ignore.case = T))){

    }else {

    }



  }
