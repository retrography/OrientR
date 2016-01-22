orientConnect <-
  function(database, host = "localhost", username = "admin", password = "admin", port = "2480") {
    up <- paste(username, password, sep = ":")
    sp <- paste(host, port, sep = ":")
    paste(up, sp, sep = "@")
  }
