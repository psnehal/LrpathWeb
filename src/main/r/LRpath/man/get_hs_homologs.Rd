\name{get_hs_homologs}
\Rdversion{1.1}
\alias{get_hs_homologs}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Convert a list of Entrez Gene IDs to human Entrez IDs.
%%  ~~function to do ... ~~
}
\description{get_hs_homologs accepts as input a vector of Entrez Gene IDs from any species, and returns a vector of human homologs.
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
get_hs_homologs(geneids)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{geneids}{ a numeric or character vector of Entrez Gene IDs from any (1 or more) species known to Homologene. 
%%     ~~Describe \code{geneids} here~~
}
}
\details{ Homologs are identified using the homolog.db package which is based on Homologene.  
%%  ~~ If necessary, more details than the description above ~~
}
\value{ a character vector of human Entrez Gene IDs of same length as input
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{ Maureen Sartor
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
mouse.ids <- c(68421,15077,67204)
get_hs_homologs(mouse.ids)

mouse.ids <- c("68421","15077","67204")
get_hs_homologs(mouse.ids)


}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{sysdata }

