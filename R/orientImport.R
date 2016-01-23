orientImport <-
  function(orient, database, ...) {
    request<-paste("http:/", orient, "import", database, sep = "/")
    response <- getURL(request, .mapUnicode = FALSE)
  }
