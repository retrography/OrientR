orientExeCommand<-function(orientConnect, command, batch = -1, ...) {
  orient<-paste("http:/", orientConnect,"server",sep="/")
  request <- paste(orient, curlEscape(command), batch, sep = '/')
  print(request)
  response <- RCurl::postForm(request, .mapUnicode = FALSE)
  results <- fromJSON(response, ...)
  return (results)

  #library(httr)
  #r <- POST("http://www.datasciencetoolkit.org/text2people",
  #          body = "Tim O'Reilly, Archbishop Huxley")
  #stop_for_status(r)
  #content(r, "parsed", "application/json")
}
