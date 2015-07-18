library(RCurl)
library(jsonlite)

getDB <-
  function(database, host = "localhost", username = "admin", password = "admin", port = "2480") {
    up <- paste(username, password, sep = ":")
    sp <- paste(host, port, sep = ":")
    base <- paste(up, sp, sep = "@")
    paste("http:/", base, "query", database, "sql", sep = "/")
  }

runQuery <-
  function(db, query, batch = -1, convert = TRUE, clean = TRUE) {
    query <- curlEscape(query)
    request <- paste(db, query, batch, sep = '/')
    response <- getURL(request)
    results <- fromJSON(response)
    results <- results$result

    if (convert & !is.null(results[["@fieldTypes"]])) {
      ft <- unique(unlist(strsplit(results[["@fieldTypes"]], ",")))

      for (i in 1:length(ft)) {
        field_type <- ft[[i]]
        field <- strsplit(field_type, "=")[[1]][1]
        type <- strsplit(field_type, "=")[[1]][2]

        if (type == "x") {
          results[grep(field_type, results[["@fieldTypes"]]), field] <-
            unlist(lapply(results[grep(field_type, results[["@fieldTypes"]]), field], function(x)
              strsplit(x, ":")[[1]][2]))
          results[,field] <- as.integer(results[[field]])
        } else if (type == "t") {
          results[,field] <- as.Date(results[[field]])
        }
      }

    }

    if (clean) {
      results["@type"] <-
        results["@version"] <-
        results["@rid"] <-
        results["@fieldTypes"] <-
        results["@class"] <- NULL
    }
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
