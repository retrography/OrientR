require(RCurl)
require(jsonlite)
require(tidyr)
require(dplyr)
require(lubridate)

getDB <-
  function(database, host = "localhost", username = "admin", password = "admin", port = "2480") {
    up <- paste(username, password, sep = ":")
    sp <- paste(host, port, sep = ":")
    base <- paste(up, sp, sep = "@")
    paste("http:/", base, "query", database, "sql", sep = "/")
  }

conv.null <- function(df, cols=colnames(df)) {
  for (col in cols) {
    df[sapply(df[[col]], length) == 0, col] <- NA
  }
  df
}

conv.rid <- function(df, cols) {
  for (col in cols) {
    df <- conv.null(df, col)
    df[[col]] <- sapply(df[[col]], function(x)
      strsplit(x, ":")[[1]][2]) %>%
      as.numeric()
  }
  df
}

unwind <- function(df, cols) {
  for (col in cols) {
    df <- conv.null(df, col)
    df <- unnest_(df, col)
  }
  df
}

conv.date <- function(df, cols, fmt = "ymd") {
  for (col in cols) {
    df <- conv.null(df, col)
    df[[col]] <- parse_date_time(df[[col]], fmt)
  }
  df
}

auto.clean <- function(df) {
  df["@type"] <-
    df["@version"] <-
    df["@rid"] <-
    df["@fieldTypes"] <-
    df["@class"] <- NULL
  df
}

ft.list <- function(ft) {
  uft <- strsplit(ft[!is.na(ft)], ",") %>%
    unlist %>%
    unique %>%
    sapply(.,function(x)
      strsplit(x, "=")[[1]][2])
  names(uft) <-
    sapply(names(uft), function(x)
      strsplit(x, "=")[[1]][1])
  uft
}


runQuery <-
  function(db, query, batch = -1, conv.dates = TRUE, date.fmt = "ymd", auto.na = TRUE, rm.meta = TRUE, conv.rid = FALSE, unwind = FALSE, formats =
             c(), ...) {
    query <- curlEscape(query)
    request <- paste(db, query, batch, sep = '/')
    response <- getURL(request)
    # The following line is a work around for a possible bug in "orientdb" that ends up returning invalid json
    response <- gsub("\n", "\\\\n", response) %>%
      gsub("\r", "\\\\r", .) %>%
      gsub("\r", "\\\\r", .)
    results <- fromJSON(response, ...)
    results <- results$result
    fts <-
      if (!is.null(results[["@fieldTypes"]]))
        ft.list(results[["@fieldTypes"]])
    else
      c()

    results <- if (rm.meta)
      auto.clean(results)

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
        results <- unwind(results, col)
      }

      if (any(fts[[col]] %in% c("x", "rid"))) {
        results <- conv.rid(results, col)
      } else if (any(fts[[col]] %in% c("t", "time", "date", "datetime"))) {
        results <- conv.date(results, col, date.fmt)
      }
    }

    if (auto.na)
      conv.null(results)
    else
      results
  }

exeCommand <-
  function(db, command) {
    # To be implemented
    print("Function not implemented yet.")
  }

launchBatch <-
  function(db, batch) {
    # To be implemented
    print("Function not implemented yet.")
  }
