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
orient <- orientConnect(database = "OpenBeer", host = "localhost", username = "admin", password = "admin", port = "2480")
```

### Run a query (only Select)
```{r}
query <- "SELECT FROM Beer"
resultSet <- orientSql(orient, query, batch = 100)
```


## <a name="#issues"></a> Known Issues

* Only Query function has been implemented in this preliminary version (see [OrientDB's REST API manual for a list of possible extensions](http://orientdb.com/docs/1.7.8/orientdb.wiki/OrientDB-REST.html)).

