
##  Functions included: LRpath, LRpath_sig, and get_hs_homologs

LRpath<-function(sigvals, geneids, species, direction=NULL, min.g=10, max.g=NA, sig.cutoff=0.05,
	database="GO", conceptList=NULL, nullsetList=NULL,  odds.min.max=c(0.001,0.5)) {

###########################################################################################
#  Function for LRpath: testing functional enrichment with logistic regression
#  Written by: Maureen Sartor, University of Michigan, 2009
###########################################################################################
##
##  This function uses logistic regression to test for enriched (or depleted) biological
##  categories in gene expression data. Our method models the probability 
##  of a randomly selected gene belonging to a specific category given the
##  significance level of that gene.  For categories significantly affected by
##  the experimental condition, this probability will increase as the significance
##  statistic increases.  Categories with significant p-values and positive slope 
##  coefficients are enriched with differentially expressed genes. 
##
##  Please acknowledge your use of LRpath in publications by referencing:
##  Sartor MA, Leikauf GD, and Medvedovic M.  LRpath: a logistic regression approach for
##  identifying enriched biological groups in gene expression data. Bioinformatics. 
##  25(2):211-7, 2009.
##
##  Inputs:
##  9 parameters: sigvals, geneids, species, direction, min.g, max.g, sig.cutoff, database, odds.min.max
##  "sigvals" a vector of p-values, same length and order as "geneids"
##  "geneids" a vector of Entrez gene IDs, may contain duplicates and missing values, same length and order as sigvals.
##  "species"  Used only for KEGG, GO, and Cytoband.  human="hsa", mouse="mmu", rat="rno", etc. (no default)
##		All other databases must be human, or first converted to human homologs
##		Other species for GO & cytoband are as follows: "Dm" for fly, "Dr" for zebrafish, "Ce" for C.elegans, "Sc" for yeast
##  "direction"  Optional parameter for directional testing.  If desired, a vector, of same length and order as sigvals.
##		Values should be negative if down-regulated and positive if up-regulated. (e.g. -1 or 1) Only the sign is used.
##  "min.g"  The minimum number of unique gene IDs analyzed in category to be tested
##		default = 10
##  "max.g"  The maximum number of unique gene IDs analyzed in category to be tested
##		default = NA (99999)
##  "sig.cutoff" Entrez gene IDs in each category with p-values<sig.cutoff will be returned
##		default = 0.05
##  "database" database to be tested- choices are "GO", "KEGG", "OMIM", "DrugBank", "miRBase",
##		"Panther","Biocarta", "Metabolite","MeSH","Pfam","MiMI","Cytoband"
##		default = "GO"
##  "odds.min.max" lower and upper p-values to be used for odds ratio calculation.
##		default= c(0.001, 0.5)
##	"conceptList" List of concepts and genelist
##	"nullsetList" List of genes for external data source

##
##  Outputs:
##  object is dataframe with the following columns:
##	1) GO, KEGG, or Concept ID	
##	2) GO, KEGG, or Concept term - name of category
##	3) Ontology (only for GO) - BP, MF, or CC
##	4) n.genes - Number of unique Entrez Gene IDs in category
##	5) coeff - coefficient of slope (positive values indicate enrichment or up-regulation; negative values 
##		   indicate depletion or down-regulation)
##      6) odds.ratio -  Odds ratio, as measure of strenth of enrichment (or depletion)
##      7) direction - "Enriched" or "Depleted", or if direction is used "Up-regulated" or "Down-regulated"
## 	8) p.value	-  P-value that slope does not equal zero, i.e. that term is enriched (or depleted)
##	9) FDR	- False Discovery Rate (Benjamini & Hochberg, 1995)
##  	10) sig.genes	- comma separated Entrez gene ids in category with p-value<"sig.cutoff"

##
##    Examples:
##    pvalues <- IBMT.results$IBMT.p[,1]
##    entrez.geneid <- unlist(mget(featureNames(affy.eset),env=hgu133aENTREZID))
##    GO.results <- LRpath(sigvals=pvalues, geneids=entrez.geneid, species="hsa", database="GO")
##    KEGG.results <- LRpath(sigvals=pvalues, geneids=entrez.geneid, database="KEGG",
##		species="hsa")
##
##########################################################################################


library("annotate")
library("stats")
	
if (database=="GO") {
     library("GO.db")
     if (species=="hsa") {
	library("org.Hs.eg.db")
        ###  Get GO list of Entrez genes
	xx<-as.list(org.Hs.egGO2ALLEGS)
     }
     else if (species=="mmu") {
	library("org.Mm.eg.db")
        ###  Get GO list of Entrez genes
	xx<-as.list(org.Mm.egGO2ALLEGS)
     }
     else if (species=="rno") {
	library("org.Rn.eg.db")
        ###  Get GO list of Entrez genes
	xx<-as.list(org.Rn.egGO2ALLEGS)
     }
     else if (species=="Dm") {
	library("org.Dm.eg.db")
	xx<-as.list(org.Dm.egGO2ALLEGS)
     }
     else if (species=="Dr") {
	library("org.Dr.eg.db")
	xx<-as.list(org.Dr.egGO2ALLEGS)
     }
     else if (species=="Ce") {
	library("org.Ce.eg.db")
	xx<-as.list(org.Ce.egGO2ALLEGS)
     }
     else if (species=="Sc") {
	library("org.Sc.sgd.db")
	xx<-as.list(org.Sc.sgdGO2ALLORFS)
     }

     ##Remove GO ids that aren't mapped to any Gene id
     xx<-xx[!is.na(xx)]

	## Determine which Entrez Gene IDs are annotated anywhere in GO
	## Gene ids not annotated in GO are left out of the environment
     nullset<-as.numeric(unique(unlist(xx)))

}
#########  KEGG works for human, mouse, rat, and any other species that uses Entrez geneID
if (database=="KEGG") {	
	library(KEGG.db)
	xx<-as.list(KEGGPATHID2EXTID)
	xx<-xx[!is.na(xx)]

	## Determine which Entrez Gene IDs are annotated anywhere in KEGG
	if (species=="Dm") {						#############  Added
	   nullset <-names(as.list(KEGGEXTID2PATHID))			#############  Added
	} else								#############  Added
	nullset<- as.numeric(names(as.list(KEGGEXTID2PATHID)))	
	nullset<- nullset[!is.na(nullset)]
}

if (database=="OMIM") {
	xx<-OMIM
	
	## Get null set vector for OMIM
	nullset<- as.numeric(OMIM.nullset[,1])
	nullset<- nullset[!is.na(nullset)]
}

if (database=="DrugBank") {
	xx<-DrugBank
	
	## Get null set vector for DrugBank
	nullset<- as.numeric(DrugBank.nullset[,1])
	nullset<- nullset[!is.na(nullset)]
}

if (database=="miRBase") {
	xx<-miRBase
	
	## Get null set vector for miRBase
	nullset<- as.numeric(miRBase.nullset[,1])
	nullset<- nullset[!is.na(nullset)]
}

if (database=="Panther") {
	xx<-Panther
	
	## Get null set vector for Panther Pathway
	nullset<- as.numeric(Panther.nullset[,1])
	nullset<- nullset[!is.na(nullset)]
}

if (database=="Biocarta") {
	xx<-Biocarta
	
	## Get null set vector for Biocarta Pathway
	nullset<- as.numeric(Biocarta.nullset[,1])
	nullset<- nullset[!is.na(nullset)]
}

if (database=="Metabolite") {
	xx<-Metabolite
	
	## Get null set vector for Metabolite
	nullset<- as.numeric(Metabolite.nullset[,1])
	nullset<- nullset[!is.na(nullset)]
}

if (database=="MeSH") {
	xx<-MeSH
	
	## Get null set vector for MeSH
	nullset<- as.numeric(MeSH.nullset[,1])
	nullset<- nullset[!is.na(nullset)]
}

if (database=="Pfam") {
	xx<-pFAM
	
	## Get null set vector for pFAM
	nullset<- as.numeric(pFAM.nullset[,1])
	nullset<- nullset[!is.na(nullset)]
}

if (database=="MiMI") {
	xx<-MiMI
	
	## Get null set vector for MiMI
	nullset<- as.numeric(MiMI.nullset[,1])
	nullset<- nullset[!is.na(nullset)]
}

if (database=="External") {
	xx<-conceptList
	nullset<- nullsetList
	nullset<- nullset[!is.na(nullset)]
}

#######  For this, we'll use data in species specific R packages, e.g. org.Hs.eg.db for human
if (database=="Cytoband") {
     if (species=="hsa") {
	library("org.Hs.eg.db")
        ###  Get GO list of Entrez genes
	xx1<-as.list(org.Hs.egMAP)
     }
     else if (species=="mmu") {
	library("org.Mm.eg.db")
        ###  Get GO list of Entrez genes
	xx1<-as.list(org.Mm.egMAP)
     }
     else if (species=="rno") {
	library("org.Rn.eg.db")
        ###  Get GO list of Entrez genes
	xx1<-as.list(org.Rn.egMAP)
     }
     else if (species=="Dm") {
	library("org.Dm.eg.db")
	xx1<-as.list(org.Dm.egMAP)
     }
     else if (species=="Dr") {
	library("org.Dr.eg.db")
	xx1<-as.list(org.Dr.egCHR)
     }
     else if (species=="Ce") {
	library("org.Ce.eg.db")
	xx1<-as.list(org.Ce.egCHR)
     }
     else if (species=="Sc") {
    	library("org.Sc.sgd.db")
    	xx1<-as.list(org.Sc.sgdCHR)
     }
	
	## Currently, list names are Entrez IDs, and values are cytobands.  Need to switch.
	xx1<-xx1[!is.na(xx1)]
	cyto.1<-as.vector(sapply(xx1,function(x) { x[1] }))  ## names(xx1) are the entrez IDs to match this
	xx<-list()
	for (i in 1:length(unique(cyto.1))) {
		xx[[i]]<- names(xx1)[cyto.1==unique(cyto.1)[i]]
	}
	names(xx)<-as.character(unique(cyto.1))

	## Get null set vector for Cytoband
	nullset<- as.numeric(names(xx1))
	nullset<- nullset[!is.na(nullset)]
}


sigvals[sigvals==0]<- 10^(-15)
geneids2<-geneids[!is.na(geneids)&!is.na(sigvals)&geneids %in% nullset]
sigvals2<-sigvals[!is.na(geneids)&!is.na(sigvals)&geneids %in% nullset]

uniqids<-unique(geneids2)
numuniq<-length(uniqids)
LOR.mult<-log(odds.min.max[2])-log(odds.min.max[1])

################  Directionality test?
if (!is.null(direction)) {
	direction2<-direction[!is.na(geneids)&!is.na(sigvals)&geneids %in% nullset]
}

################ Average -log(p-values) for duplicate locusids
nlp<-(-1)*log(sigvals2)
if (!is.null(direction)) {
	nlp[direction2<0]<-(-1)*nlp[direction2<0]
}
newp<-NA
for (i in (1:numuniq)){
	current<-nlp[geneids2==uniqids[i]]  #Get all values for i-th geneid
	#numrep<-length(current)
	newp[i]<-mean(current)
}
### Limit testing to those categories with at least min.g genes TOTAL
catsizes<-sapply(xx,length)
yy<-xx[catsizes>=min.g]
ncats<-length(yy)

siggenes <- uniqids[exp(-newp)<sig.cutoff]
if (!is.null(direction)) {
	siggenes<-ifelse(newp>0,uniqids[exp(-newp)<sig.cutoff],uniqids[exp(newp)<sig.cutoff])
}

######################################################################
###  Test all categories to which at least min ANALYZED genes belong

LRcoeff<-NA; LRpval<-NA; cattots<-NA; yyind<-NA; concept_ids<-NA
catsigIDs<-NA
ind<-0
if (is.na(max.g)) {
	max.g<-99999
}
for (i in (1:ncats)){
	if (species=="Dm") {							#############  Added
	   catgenes <- as.vector(sapply(yy[[i]], as.character))			#############  Added
	} else									#############  Added
	catgenes<-as.vector(sapply(yy[[i]],as.integer)) #as.vector(yy[[1]])
	catgenes<-unique(catgenes)
	if (species=="Dm") {							#############  Added
	   catpoprows<-match(catgenes, as.vector(uniqids, mode="character"))	#############  Added
	} else									#############  Added
	catpoprows<-match(catgenes,as.vector(uniqids,mode="integer"))
	catpoprows<-catpoprows[!is.na(catpoprows)]

	cattot<-length(catpoprows)	#Number of analyzed genes in category
	if (cattot>=min.g&cattot<=max.g) {
		ind<-ind+1
		cat<-rep(0,numuniq)
		cat[catpoprows]<- 1
		forLR<- as.data.frame(cbind(cat,newp))
		names(forLR)<-c("cat","nlogp")

		glm.lrGO <- glm(cat ~ nlogp, family=binomial(link="logit"),forLR)
		lrGO<-summary(glm.lrGO)

		###########  Extract p-value and coefficient
		LRcoeff[ind]<-lrGO$coefficients["nlogp","Estimate"]
		LRpval[ind]<-lrGO$coefficients["nlogp","Pr(>|z|)"]
		cattots[ind]<-cattot
		#yyind[ind]<-i
		concept_ids[ind]<-names(yy[i])
		catsig.IDlist<-intersect(siggenes,catgenes)
		if (!is.null(direction)) {
		   if (LRcoeff[ind]>0) {
			catsig.IDlist<-intersect(catsig.IDlist,uniqids[newp>0])
		   }
		   else { catsig.IDlist<-intersect(catsig.IDlist,uniqids[newp<0]) }
		}
		catsigIDs[ind]<-paste(catsig.IDlist[order(catsig.IDlist)],collapse=", ")
      }
	if ((i-ncats/10)>0&(i-ncats/10)<1.1) {
		print("10% categories finished.")
	}
	if ((i-ncats/5)>0&(i-ncats/5)<1.1) {
		print("20% categories finished.")
	}
	if ((i-ncats/2)>0&(i-ncats/2)<1.1) {
		print("50% categories finished.")
	}
	if ((i-9*ncats/10)>0&(i-9*ncats/10)<1.1) {
		print("90% categories finished.")
	}

}

odds.ratio<-exp(LOR.mult*LRcoeff)
BenjFDR<-p.adjust(LRpval,"BH")

if (database=="GO") {
	############## Annotate with GO names and Ontology
	GOterms<-as.list(GOTERM)
	GOterms<-GOterms[!is.na(GOterms)]
	terms<-as.vector(sapply(GOterms,Term))  
	Ontologies<-as.vector(sapply(GOterms,Ontology))
	AllGOids<-as.vector(names(GOterms))
	terms2<-cbind(AllGOids,terms,Ontologies)

	GOrows<-match(concept_ids,AllGOids)
	GOannot<-terms2[GOrows,]
	LRresults<-cbind(concept_ids,GOannot[,c("terms","Ontologies")],cattots,LRcoeff,
	     odds.ratio,as.data.frame(LRpval),BenjFDR,catsigIDs)
	names(LRresults)<- c("Concept.ID", "Concept.name", "Ontology", "n.genes", "coeff", "odds.ratio",
		"p.value", "FDR", "sig.genes")
}

if (database=="KEGG") {
	KEGGterms<- as.list(KEGGPATHNAME2ID)
	kterms<- as.vector(names(KEGGterms))
	if (species=="Dm") {                                        #############  Added
	   k.ids <- paste("dme", unlist(KEGGterms), sep = "")       #############  Added
	} else if (species=="Ce") {                                 #############  Added - tew 3/15/11 - fixed concept name problem 
	   k.ids <- paste("cel",  unlist(KEGGterms), sep = "")      #############  Added - tew 3/15/11 - for Ce/KEGG
	} else {                                                    #############  Added
	   k.ids<- paste(species,unlist(KEGGterms),sep="")
	}
	keggrows<- match(concept_ids,k.ids)
	kegg.annot<-kterms[keggrows]
	LRresults<-cbind(concept_ids,kegg.annot,cattots,LRcoeff,
	     odds.ratio,as.data.frame(LRpval),BenjFDR,catsigIDs)
	names(LRresults)<- c("Concept.ID", "Concept.name", "n.genes", "coeff", "odds.ratio",
		"p.value", "FDR", "sig.genes")
}

if (database=="OMIM") {
	omimrows = match(concept_ids, OMIM.annot[, "CONCEPT_ID"])	
	LRresults<-cbind(concept_ids,OMIM.annot[omimrows, "CONCEPT_NAME"],cattots,LRcoeff,
	     odds.ratio,as.data.frame(LRpval),BenjFDR,catsigIDs)
	names(LRresults)<- c("Concept.ID", "Concept.name", "n.genes", "coeff", "odds.ratio",
		"p.value", "FDR", "sig.genes")
}

if (database=="DrugBank") {
	DrugBankrows = match(concept_ids, DrugBank.annot[, "CONCEPT_ID"])	
	LRresults<-cbind(concept_ids,DrugBank.annot[DrugBankrows, "CONCEPT_NAME"],cattots,LRcoeff,
	     odds.ratio,as.data.frame(LRpval),BenjFDR,catsigIDs)
	names(LRresults)<- c("Concept.ID", "Concept.name", "n.genes", "coeff", "odds.ratio",
		"p.value", "FDR", "sig.genes")
}

if (database=="miRBase") {
	miRBaserows = match(concept_ids, miRBase.annot[, "CONCEPT_ID"])	
	LRresults<-cbind(concept_ids,miRBase.annot[miRBaserows, "CONCEPT_NAME"],cattots,LRcoeff,
	     odds.ratio,as.data.frame(LRpval),BenjFDR,catsigIDs)
	names(LRresults)<- c("Concept.ID", "Concept.name", "n.genes", "coeff", "odds.ratio",
		"p.value", "FDR", "sig.genes")
}

if (database=="Panther") {
	Pantherrows = match(concept_ids, Panther.annot[, "CONCEPT_ID"])	
	LRresults<-cbind(concept_ids,Panther.annot[Pantherrows, "CONCEPT_NAME"],cattots,LRcoeff,
	     odds.ratio,as.data.frame(LRpval),BenjFDR,catsigIDs)
	names(LRresults)<- c("Concept.ID", "Concept.name", "n.genes", "coeff", "odds.ratio",
		"p.value", "FDR", "sig.genes")
}

if (database=="Biocarta") {
	Biocartarows = match(concept_ids, Biocarta.annot[, "CONCEPT_ID"])	
	LRresults<-cbind(concept_ids,Biocarta.annot[Biocartarows, "CONCEPT_NAME"],cattots,LRcoeff,
	     odds.ratio,as.data.frame(LRpval),BenjFDR,catsigIDs)
	names(LRresults)<- c("Concept.ID", "Concept.name", "n.genes", "coeff", "odds.ratio",
		"p.value", "FDR", "sig.genes")
}

if (database=="Metabolite") {
	Metaboliterows = match(concept_ids, Metabolite.annot[, "CONCEPT_ID"])	
	LRresults<-cbind(concept_ids,Metabolite.annot[Metaboliterows, "CONCEPT_NAME"],cattots,LRcoeff,
	     odds.ratio,as.data.frame(LRpval),BenjFDR,catsigIDs)
	names(LRresults)<- c("Concept.ID", "Concept.name", "n.genes", "coeff", "odds.ratio",
		"p.value", "FDR", "sig.genes")
}

if (database=="MeSH") {
	MeSHrows = match(concept_ids, MeSH.annot[, "CONCEPT_ID"])	
	LRresults<-cbind(concept_ids,MeSH.annot[MeSHrows, "CONCEPT_NAME"],cattots,LRcoeff,
	     odds.ratio,as.data.frame(LRpval),BenjFDR,catsigIDs)
	names(LRresults)<- c("Concept.ID", "Concept.name", "n.genes", "coeff", "odds.ratio",
		"p.value", "FDR", "sig.genes")
}

if (database=="Pfam") {
	pFAMrows = match(concept_ids, pFAM.annot[, "CONCEPT_ID"])	
	LRresults<-cbind(concept_ids,pFAM.annot[pFAMrows, "CONCEPT_NAME"],cattots,LRcoeff,
	     odds.ratio,as.data.frame(LRpval),BenjFDR,catsigIDs)
	names(LRresults)<- c("Concept.ID", "Concept.name", "n.genes", "coeff", "odds.ratio",
		"p.value", "FDR", "sig.genes")
}

if (database=="MiMI") {
	MiMIrows = match(concept_ids, MiMI.annot[, "CONCEPT_ID"])	
	LRresults<-cbind(concept_ids,MiMI.annot[MiMIrows, "CONCEPT_NAME"],cattots,LRcoeff,
	     odds.ratio,as.data.frame(LRpval),BenjFDR,catsigIDs)
	names(LRresults)<- c("Concept.ID", "Concept.name", "n.genes", "coeff", "odds.ratio",
		"p.value", "FDR", "sig.genes")
}

if (database=="Cytoband") {
	#Cytobandrows = match(concept_ids, Cytoband.annot[, "CONCEPT_ID"])	
	LRresults<-cbind(concept_ids,concept_ids,cattots,LRcoeff,
	     odds.ratio,as.data.frame(LRpval),BenjFDR,catsigIDs)
	names(LRresults)<- c("Concept.ID", "Concept.name", "n.genes", "coeff", "odds.ratio",
		"p.value", "FDR", "sig.genes")
}

if (database=="External") {
	LRresults<-cbind(concept_ids,concept_ids,cattots,LRcoeff,
	     odds.ratio,as.data.frame(LRpval),BenjFDR,catsigIDs)
	names(LRresults)<- c("Concept.ID", "Concept.name", "n.genes", "coeff", "odds.ratio",
		"p.value", "FDR", "sig.genes")
}

LRresults

} #End function LRpath



LRpath_sig<-function(LRresults, n = 10) {
	LRsiggenes = LRresults[order(LRresults[, "p.value"])[1:n],]

LRsiggenes
}
	

get_hs_homologs <- function(geneids) {
	library(homolog.db)
	human.ids<- as.list(homologTAXID)
	human.ids<-names(human.ids)[human.ids==9606] 
	print("Human IDs acquired.")
	xx<-as.list(homologHOMOLOG)	
	hids<- xx[match(geneids,names(xx))]
	homologs <- names(xx)[names(xx) %in% human.ids][match(hids,xx)]

homologs
}

