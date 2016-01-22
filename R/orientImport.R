orientImport <-
  function(orientConnect, database, ...) {
    orientConnect <- sub(pattern = "https?://","",orientConnect)
    orient<-paste("http:/", orientConnect, "import", database, sep = "/")
    request <- paste(orient, curlEscape(query), sep = '/')
    response <- getURL(request, .mapUnicode = FALSE)
  }
