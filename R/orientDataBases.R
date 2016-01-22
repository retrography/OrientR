orientDataBases<-function(orientConnect){
  orientConnect <- sub(pattern = "https?://","",orientConnect)
  orient<-paste("http:/", orientConnect,"server",sep="/")
  request <- paste(orient, curlEscape(query), batch, sep = '/')
  response <- getURL(request, .mapUnicode = FALSE)
  results <- fromJSON(response, ...)[["storages"]]
  results$name
}
