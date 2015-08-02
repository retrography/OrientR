\name{getDB}
\alias{getDB}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Generating a Database Connection String
}
\description{
This function generates a database connection string based on the parameters. The resulting URL has to be passed into the other functions (e.g. \code{runQuery}) in order to indicate the database  to be queried.
}
\usage{
getDB(database, host = "localhost", username = "admin", password = "admin", port = "2480")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{database}{
The name of the database you would like to open.
}
  \item{host}{
The host name or the IP address of the host.
}
  \item{username}{
The username you would like to use for databased access.
}
  \item{password}{
The corresponding poassword.
}
  \item{port}{
The HTTP port number, in case you are not using the default 2480.
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
getDB("GreatfulDeadConcerts",
      host = "dbserver.local",
      username = "root",
      password = "toor",
      port = "1234")

# [1] "http://root:toor@dbserver.local:1234/query/GreatfulDeadConcerts/sql"


getDB("Beers")

# [1] "http://admin:admin@localhost:2480/query/Beers/sql"
}
\keyword{ connection string }
\keyword{ database }
\keyword{ URL }
