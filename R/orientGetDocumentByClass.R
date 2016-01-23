orientGetDocumentByClass<-
  function(orient, database,className,recordPosition, ...) {
    request<-paste("http:/", orient, "documentbyclass", database,className,recordPosition, sep = "/")
    response <- getURL(request, .mapUnicode = FALSE)
    if(!int0(grep(pattern = "was not found",response))) { NA
    } else {
    results <- fromJSON(response, ...)
    results<-as.data.frame(results)
    names(results)<-sub("^X\\.","",names(results))
    results
    }
  }

