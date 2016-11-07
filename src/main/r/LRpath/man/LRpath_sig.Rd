\name{LRpath_sig}
\Rdversion{1.1}
\alias{LRpath_sig}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Output the top significant results from LRpath
%%  ~~function to do ... ~~
}
\description{ LRpath_sig takes as input an LRpath output object, and displays results for the top significant concepts.
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
LRpath_sig(LRresults, n = 10)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{LRresults}{ an object from LRpath output, or an object formatted accordingly
%%     ~~Describe \code{LRresults} here~~
}
  \item{n}{ the number of top ranked concepts and their results to display
%%     ~~Describe \code{n} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{ A data frame with components identical that of the LRpath output.
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

\seealso{ \code{\link{LRpath}}, and \code{\link{get_hs_homologs}} for obtaining human Entrez ID homologs
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
require(CLL)
require(limma)
require(hgu95av2.db)

data(sCLLex)  # CLL Affymetrix data as example
expns<-exprs(sCLLex)
design<-model.matrix(~1 + factor(pData(sCLLex)[,2]))
fit<-lmFit(expns,design)
fit<-eBayes(fit)
pvalues<-fit$p.value[,2]  # Extract p-values for testing between stable and progressive disease

x<-hgu95av2ENTREZID  # Get Entrez IDs from annotation data
mapped_probes<-mappedkeys(x)
entrezids<-unlist(as.list(x[mapped_probes]))
geneids<-entrezids[match(names(pvalues),names(entrezids))] 
KEGG.results <- LRpath(pvalues,geneids,species="hsa",database="KEGG")  # Test against KEGG Pathways
LRpath_sig(KEGG.results)  # Display top 10 significant pathways (note some are enriched, some depleted in this example)


## The function is currently defined as
function (LRresults, n = 10) 
{
    LRsiggenes = LRresults[order(LRresults[, "p.value"])[1:n],] 
    LRsiggenes
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{list}

