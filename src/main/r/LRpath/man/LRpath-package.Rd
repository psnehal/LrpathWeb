\name{LRpath-package}
\Rdversion{1.1}
\alias{LRpath-package}
\docType{package}
\title{
The LRpath package: Functional enrichment testing for gene expression data using logistic regression
}
\description{
This package contains functions to perform functional enrichment testing using logistic regression. 
The method models the significance levels of differential expression (x-axis) against gene set membership (y-axis).
Several types of biological gene sets may be tested against in addition to GO and KEGG, and one may test enrichment for
all differential expression, or use a directional test for up- versus down-regulated genes.
}
\details{
\tabular{ll}{
Package: \tab LRpath\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2009-07-13\cr
License: \tab What license is it under?\cr
LazyLoad: \tab yes\cr
}
Current functions are LRpath (main function; performs enrichment testing), get_hs_homologs (used to obtain human homologs, if using other species; not needed for testing GO, KEGG, or Cytoband) 
and LRpath_sig (display the top ranked results). \cr
}
\author{
Maureen Sartor and Manjusha Pande (University of Michigan)

Maintainer: Maureen Sartor <sartorma@umich.edu>

}
\references{
Sartor, M.A., Leikauf, G.D. and Medvedovic, M. (2009) LRpath: a logistic regression approach for identifying enriched biological groups in gene expression data, Bioinformatics, 25, 211-217.
}

\keyword{ package }
\seealso{
\code{\link{LRpath}}, \code{\link{get_hs_homologs}}, and \code{\link{LRpath_sig}}
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

mouse.ids <- c(68421,15077,67204)
get_hs_homologs(mouse.ids)
}
