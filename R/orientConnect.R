orientConnect <-
  function(host = "localhost", username = "admin", password = "admin", port = "2480") {
    up <- paste(username, password, sep = ":")
    sp <- paste(host, port, sep = ":")
    orient<-paste(up, sp, sep = "@")
    sub(pattern = "https?://","",orient)
  }
