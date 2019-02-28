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

### Load the library
```{r}
library(OrientR)
```

### Generate connection string
```{r}
db <- getDB(database = "OpenBeer", host = "localhost", username = "root", password = "orientdb", port = "2480")
```

### Run a query
```{r}
query <- "SELECT FROM Beer"
resultSet <- runQuery(db, 'SELECT @rid AS id, name AS beer, out_HasBrewery.in.name AS brewery FROM Beer UNWIND brewery', batch = 100)
```
Note: It has come to my attention that OrientR fails to parse the data types for queries using the * selector (or equivalent). This is a known error now, but unfortunately I don't have the time to debug it. Feel free to make a pull request.

## <a name="#issues"></a> Known Issues

* Only Query function has been implemented in this preliminary version (see [OrientDB's REST API manual for a list of possible extensions](http://orientdb.com/docs/1.7.8/orientdb.wiki/OrientDB-REST.html)).

