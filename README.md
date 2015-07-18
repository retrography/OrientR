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
db = getDB(database = "OpenBeer", host = "localhost", username = "admin", password = "admin", port = "2480")
```

### Run a query
```{r}
query = "SELECT FROM Beer"
runQuery(db, query, batch = 100)
```


## <a name="#issues"></a> Known Issues

* ```exeCommand``` and ```launchBatch``` functions have not been implemented yet.
* Some text fields including invalid characters may break the JSON conversion engine (```jsonlite```).


