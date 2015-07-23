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

null.conv <- function(df) {
  cols <- colnames(df)
  for (col in cols) {
    df[sapply(df[[col]], length) == 0, col] <- NA
  }
  df
}

unrid <- function(df, cols) {
  for (col in cols) {
    null.conv(df[col])
    df[[col]] <- sapply(df[[col]], function(x)
      strsplit(x, ":")[[1]][2]) %>%
      as.numeric()
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

    results <- if (rm.meta) auto.clean(results)

    else
      results
    if (!conv.dates)
      fts <- fts[fts != "t"]
    if (!conv.rid)
      fts <- fts[fts != "x"]
    if (!unwind)
      fts <- fts[fts != "g"]
    fts <- c(fts[!names(fts) %in% names(formats)], formats)
    for (col in names(fts)) {
      if (any(fts[[col]] %in% c("list", "vector", "g", "z"))) {
        results[col] <- null.conv(results[col])
        results <- unnest_(results, col)
      }

      if (any(fts[[col]] %in% c("x", "rid"))) {
        results[col] <- null.conv(results[col])
        results[[col]] <-
          sapply(results[[col]], function(x)
            strsplit(x, ":")[[1]][2])
      } else if (any(fts[[col]] %in% c("t", "time", "date", "datetime"))) {
        results[col] <- null.conv(results[col])
        results[[col]] <-
          parse_date_time(results[[col]], date.fmt)
      }
    }

    if (auto.na)
      null.conv(results)
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
