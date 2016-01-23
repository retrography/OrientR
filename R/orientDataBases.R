orientDataBases<-function(orient){
  request<-paste("http:/", orient,"listDatabases",sep="/")
  response <- getURL(request, .mapUnicode = FALSE)
  results <- fromJSON(response, ...)[["databases"]]
  results
}
