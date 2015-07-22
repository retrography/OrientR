\name{runQuery}
\alias{runQuery}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Running a Query
}
\description{
This function runs a query on the specified database and returns the results as a \code{DataFrame}.
}
\usage{
runQuery(db, query, batch = -1, convert = TRUE, clean = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{db}{
The database URL obtained from \code{\link{getDB}}.
}
  \item{query}{
The SQL query you wish to run.
}
  \item{batch}{
Batch size limit (similar to SQL \code{LIMIT} keyword).
}
  \item{convert}{
Specifies whether the complex datatypes have to be converted. This option currently enables \code{RID} and \code{DateTime} conversion. Defaults to TRUE.
}
  \item{clean}{
Specifies whether auto-generated response fields (e.g. \code{@class, @rid, @fieldTypes}) have to be removed from the final results. Defaults to TRUE.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (db, query, batch = -1, convert = TRUE, clean = TRUE)
{
    query <- curlEscape(query)
    request <- paste(db, query, batch, sep = "/")
    response <- getURL(request)
    results <- fromJSON(response)
    results <- results$result
    if (convert & !is.null(results[["@fieldTypes"]])) {
        ft <- unique(unlist(strsplit(results[["@fieldTypes"]],
            ",")))
        for (i in 1:length(ft)) {
            field_type <- ft[[i]]
            field <- strsplit(field_type, "=")[[1]][1]
            type <- strsplit(field_type, "=")[[1]][2]
            if (type == "x") {
                results[grep(field_type, results[["@fieldTypes"]]),
                  field] <- unlist(lapply(results[grep(field_type,
                  results[["@fieldTypes"]]), field], function(x) strsplit(x,
                  ":")[[1]][2]))
                results[, field] <- as.integer(results[[field]])
            }
            else if (type == "t") {
                results[, field] <- as.Date(results[[field]])
            }
        }
    }
    if (clean) {
        results["@type"] <-
        results["@version"] <-
        results["@rid"] <-
        results["@fieldTypes"] <-
        results["@class"] <- NULL
    }
    results
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
