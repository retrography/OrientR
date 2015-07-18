\name{getDB}
\alias{getDB}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Generating a Database URL
}
\description{
This function generates a database connection URL based on the entered parameters. The resulting URL has to be passed into other functions (e.g. \code{runQuery}) so that they know what database to connect to.
}
\usage{
getDB(database, host = "localhost", username = "admin", password = "admin", port = "2480")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{database}{
The name of the database you want to open.
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
The HTTP port number, if you have changed the default 2480.
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
function (database, server = "localhost", username = "admin",
    password = "admin", port = "2480")
{
    up <- paste(username, password, sep = ":")
    sp <- paste(server, port, sep = ":")
    base <- paste(up, sp, sep = "@")
    paste("http:/", base, "query", database, "sql", sep = "/")
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
