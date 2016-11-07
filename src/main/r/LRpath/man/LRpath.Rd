\name{LRpath}
\Rdversion{1.1}
\alias{LRpath}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Test for enriched biological categories in gene expression data
%%  ~~function to do ... ~~
}
\description{ LRpath uses a logistic regression-based method for identifying predefined sets of biologically related genes 
(concepts) enriched with (or depleted of) differentially expressed transcripts in microarray experiments. Enrichment can be
determined either for all differentially expressed genes, or for up- and down-regulated genes separately.
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
LRpath(sigvals, geneids, species, direction = NULL, min.g = 10, max.g = NA, sig.cutoff = 0.05, database = "GO", odds.min.max = c(0.001, 0.5))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{sigvals}{ a vector of p-values
%%     ~~Describe \code{sigvals} here~~
}
  \item{geneids}{ a vector of Entrez Gene IDs, may contain duplicates and missing values 
%%     ~~Describe \code{geneids} here~~
}
  \item{species}{ Used only for testing KEGG, GO, and cytoband. Acceptable values are human="hsa", mouse="mmu", rat="rno",
etc. (no default). Other species for GO & cytoband are: "Dm" for fly, "Dr" for zebrafish, "Ce" for C.elegans, "Sc" for yeast (For yeast, C.elegan, and zebrafish, chromosome is tested instead of cytoband.)
%%     ~~Describe \code{species} here~~
}
  \item{direction}{ Optional parameter for directional testing.  If desired, a vector of same length and order as sigvals.
	Values should be negative if down-regulated and positive if up-regulated (e.g. -1 or 1). Only the sign is used.
%%     ~~Describe \code{direction} here~~
}
  \item{min.g}{ The minimum number of unique gene IDs analyzed in category to be tested (default = 10)
%%     ~~Describe \code{min.g} here~~
}
  \item{max.g}{ The maximum number of unique gene IDs analyzed in category to be tested (default = NA (99999))
%%     ~~Describe \code{max.g} here~~
}
  \item{sig.cutoff}{ Entrez gene IDs in each category with p-values<sig.cutoff will be returned (default = 0.05)
%%     ~~Describe \code{sig.cutoff} here~~
}
  \item{database}{ database (concept type) to be tested- choices are "GO", "KEGG", "OMIM", "DrugBank", "miRBase",
	"Panther","Biocarta", "Metabolite","MeSH","Pfam","MiMI","Cytoband" (default = "GO")
%%     ~~Describe \code{database} here~~
}
  \item{odds.min.max}{ lower and upper p-values to be used for odds ratio calculation. default= c(0.001, 0.5)
%%     ~~Describe \code{odds.min.max} here~~
}
}
\details{ As stated above, the species argument is used only for testing against the concept types KEGG, GO, and Cytoband. All
other concept types are human-centric, and gene ids must first be converted to human homologs.  See the get_hs_homolgs()
function for this purpose.

Details of Concept Types
GO -  source = GO.db package

KEGG Pathway - source = KEGG.db package

MiMI - gene-centered protein interaction groups. source = MiMI (Michigan Molecular Interactions) database (http://mimi.ncibi.org)

MeSH - Medical Subject Heading gene sets derived from medical literature, created from Gene2MeSH (http://gene2mesh.ncibi.org)

OMIM - Online Mendelian Inheritance in Man (human diseases, manually curated to remove duplicates)

DrugBank - Drug Targets; source = DrugBank

Cytoband - chromosomal locations, source = NCBI

Panther Pathways - source = PANTHER database

Biocarta Pathways - source = Biocarta database

Pfam - protein family gene sets; source = Pfam

miRBase - microRNA predicted gene targets; source = miRBase

Metabolite - Metabolite/compound-centered gene sets.  Derived from linking compound --> chemical reactions --> enzymes --> genes; source = Edinburgh human metabolic network

For large concept types, it may take several minutes for analysis to complete. 

Note: The one exception to using Entrez Gene IDs is testing GO for yeast; for this, the geneids should be a vector of ORFs.
%%  ~~ If necessary, more details than the description above ~~
}
\value{ A data frame with components
\item{Concept.ID }{ KEGG, GO, or Concept ID }
\item{Concept.name }{ Concept term or description }
\item{n.genes }{ Number of unique Entrez Gene IDs in category/concept }
\item{coeff }{ coefficient of slope (i.e. beta) in logistic regression model (positive values indicate enrichment or up-regulation; negative values indicate depletion or down-regulation}
\item{odds.ratio }{ Odds ratio, as measure of strength of enrichment (or depletion). odds.ratio > 1 indicates enrichment or up-regulation }
\item{p.value }{ P-value that the slope coefficient does not equal zero using Wald's test, i.e. p-value that the category/concept is enriched/depleted }
\item{FDR }{ False Discover Rate (Benjamini & Hochberg) }
\item{sig.genes }{ comma separated Entrez Gene IDs in category/concept with p-value < "sig.cutoff" }
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
Sartor, M.A., Leikauf, G.D. and Medvedovic, M. (2009) LRpath: a logistic regression approach for identifying enriched biological groups in gene expression data, Bioinformatics, 25, 211-217.

Tarcea, V.G., Weymouth, T., Ade, A., Bookvich, A., Gao, J., Mahavisno, V., Wright, Z., Chapman, A., Jayapandian, M., Ozgur, A., Tian, Y., Cavalcoli, J., Mirel, B., Patel, J., Radev, D., Athey, B., States, D. and Jagadish, H.V. (2008) Michigan molecular interactions r2: from interacting proteins to pathways, Nucleic Acids Res.

Wishart, D.S., Knox, C., Guo, A.C., Cheng, D., Shrivastava, S., Tzur, D., Gautam, B. and Hassanali, M. (2008) DrugBank: a knowledgebase for drugs, drug actions and drug targets, Nucleic Acids Res, 36, D901-906.

Ma, H., Sorokin, A., Mazein, A., Selkov, A., Selkov, E., Demin, O. and Goryanin, I. (2007) The Edinburgh human metabolic network reconstruction and its functional analysis, Mol Syst Biol, 3, 135.

Benjamini, Y. and Hochberg, Y. (1995) Controlling the False Discovery Rate: a Practical and Powerful Approach to Multiple Testing, Journal of the Royal Statistical Society B, 57 289-300.
%% ~put references to the literature/web site here ~
}
\author{ R implementation by Maureen Sartor and Manjusha Pande (University of Michigan)
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{get_hs_homologs}} for obtaining human homolog Entrez IDs, and \code{\link{LRpath_sig}} for display of top significant results
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
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{list }
%\keyword{ enrichment }% __ONLY ONE__ keyword per line
