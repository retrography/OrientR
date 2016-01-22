orientExport <-
  function(orientConnect, database, ...) {
    orientConnect <- sub(pattern = "https?://","",orientConnect)
    orient<-paste("http:/", orientConnect, "export", database, sep = "/")
    request <- paste(orient, curlEscape(query), sep = '/')
    response <- getURL(request, .mapUnicode = FALSE)
    results <- fromJSON(response, ...)[["classes"]]
    results[,c("name","superClass","clusters","records")]
  }
