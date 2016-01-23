orientDataBaseDetail <-
  function(orient, database, ...) {
    request<-paste("http:/", orient, "database", database, sep = "/")
    response <- getURL(request, .mapUnicode = FALSE)
    results <- fromJSON(response, ...)[["classes"]]
    results[,c("name","superClass","abstract","clusters","defaultCluster","records")]
  }
