# OrientR

OrientR is a REST API wrapper for OrientDB. It allows you to run queries on OrientDB over its REST interface.

## Contents

* [Install](#install)
* [Use](#use)
* [Known Issues](#issues)

## <a name="#install"></a> Install

```{r}
install.packages("devtools")
devtools::install_github("retrography/OrientR")
```


## <a name="#use"></a> Use

### Load library
```{r}
library(OrientR)
```

### Generate database URL
```{r}
db <- getDB(database = "OpenBeer", host = "localhost", username = "admin", password = "admin", port = "2480")
```

### Run a query
```{r}
query <- "SELECT FROM Beer"
resultSet <- runQuery(db, query, batch = 100)
```


## <a name="#issues"></a> Known Issues

* Many functions have not been implemented yet (see [OrientDB's REST API manual for a list of possible extensions](http://orientdb.com/docs/1.7.8/orientdb.wiki/OrientDB-REST.html)).
* Some text fields including invalid characters may break the JSON conversion engine (```jsonlite```).


