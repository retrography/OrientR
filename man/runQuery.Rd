\name{runQuery}
\alias{runQuery}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Running a Query Against a Database
}
\description{
This function runs a query on the specified database and returns the results as a \code{Data Frame}.
}
\usage{
runQuery(db, query, batch = -1, conv.dates = TRUE, date.fmt = "ymd", auto.na = TRUE,
        rm.meta = TRUE, conv.rid = FALSE, unwind = FALSE, formats = c(), ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{db}{
The connection string obtained from \code{getDB}.
}
  \item{query}{
The SQL query you would like to run.
}
  \item{batch}{
Batch size limit (similar to SQL \code{LIMIT} keyword).
}
  \item{conv.dates}{
Specifies whether fields marked as date-time have to be automatically casted into \code{POSIXlt} and \code{POSIXct} objects according to the format specified in \code{date.fmt}. Defaults to TRUE.
}
  \item{date.fmt}{
Specifies the format of the datetime strings. This is a simplified format string as defined in \code{lubridate} package and defaults to "ymd".
}
  \item{auto.na}{
Specifies whether NULLs and empty strings in the resultset have to be converted into NA. Defaults to TRUE.
}
  \item{rm.meta}{
Specifies whether auto-generated metadata fields (e.g. \code{@class, @rid, @fieldTypes}) have to be removed from the resultset. Defaults to TRUE.
}
  \item{conv.rid}{
When set to TRUE automatically strips the cluster number from the fields marked as \code{RID} and casts the remaining ID section into an integer. Defaults to FALSE.
}
  \item{unwind}{
When set to TRUE automatically unwinds the fields marked as containing lists or collections within the resultset metadata. Defaults to FALSE.
}
  \item{formats}{
Takes a named vector or a list as parameter. The list must specify the formats of the fields that have to be convreted or casted. The conversion will happen according to the order specified in the list. Each field name can have a vector of formats assigned to it if more than one conversion in desired. Mentioning a field name here will disable the default conversions based on resultset metadata. The accepted values are "rid", "vector", "list", "time", "date", "datetime" and "factor". Numbers and strings are currently imported as Numeric and Character.
}
  \item{...}{
Additional named parameters will be handed down to \code{jsonlite::fromJSON}.
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
runQuery(db, "select from concerts", batch = 100)


runQuery(db,
        "select @rid as rid, name, model, year from cars",
        batch = 100,
        conv.rid = TRUE,
        date.fmt = "y")

# Converts the "rid" field from "#\{cluster\}:\{ID\}" format to a simple integer ID.
# Casts the "year" field into a POSIX date-time object while considering the field
# content to only include a year (either in "YY" or "YYYY" format).
# Sample results:
#   4533, "Toyota", "Yaris", 2001


query = "select @rid as id, name, model, year, in('manufactures') as manufacturer, in('sells') as vendor from cars"
runQuery(db,
        query,
        batch = 100,
        date.fmt = "y",
        formats = list(id="rid", year="datetime", manfacturer="rid",vendor=c("list","rid"))
        )

# Explicitly specifies the fields that have to be casted or converted.
# The resultset will be unwinded based on "vendor" field and then the unlisted
# vendor RIDs will be converted into integer IDs.
# Sample results:
#   4533, "Toyota", "Yaris", 2001, 32, 2
#   4533, "Toyota", "Yaris", 2001, 32, 12
#   4533, "Toyota", "Yaris", 2001, 32, 7


runQuery(db,
        "select title, dependencies from packages",
        flatten = TRUE,
        formats = c(dependencies.runtime="list", dependencies.devel="list")
        )

# Will pass the value of flatten parameter down to the JSON conversion engine.
# For instance if "dependencies" field contains a collection such as
# {runtime:["xpack", "ypack"], devel:["zpack"]} the resultset will contain the
# following fields: title, dependencies.runtime, dependencies.devel
# Sample results:
#   "thispack", "xpack", "zpack"
#   "thispack", "ypack", "zpack"
# Note that both "dependencies" fields are being unwinded using the "formats" parameter.
}

\keyword{ query }
\keyword{ database }% __ONLY ONE__ keyword per line
