<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="optionBean" scope="session" class="org.ncibi.resource.util.LRPathProcessOptionBean" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>LRpath - Pathway Analysis using Logistic Regression</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
<script type="text/javascript" src="js/menu.js"></script>
<script type="text/javascript" src="js/validation.js"></script>
<script>




</script>
</head>
<body>
	<center>
		<div id="mainPanel">

<!--  LOGO PANEL -------------------------------------------------------------------------------------------------------------------------->

			<div id="logoPanel">
				<img alt="LRpath" src="images/logo.jpg"> <br /> <br /> <span
					class="logoTitle">Pathway Analysis using Logistic Regression</span>
				<hr>
			</div>
			
<!--  RNA-Enrich PANEL -------------------------------------------------------------------------------------------------------------------------->			
			
			
			<div id="contentPanel2">
			<br/>
				<sup>NEW!!!!</sup> &nbsp;<span class="contentTitle">RNA-Enrich option for RNA-seq data</span>
				<div id="textPanel">
			<span class="text">Why use our RNA-Enrich version?  In tests for differential expression (DE) in RNA-seq data, there is often a relationship between gene read
				count and the statistical power to detect DE. This relationship has been shown to bias gene set enrichment testing. RNA-Enrich accounts for this bias empirically.
			<ul>
			  <li>Like our standard LRpath test, RNA-Enrich does not require a p-value cut-off to define differentially expressed genes, and it works well even with small sample 
            	sized experiments.</li>
              <li>Adjusting for read counts per gene improves the type 1 error rate and power of the test.</li>
              <li> RNA-Enrich runs significantly faster than the standard LRpath </li>
              <li> When no relationship between gene read count and power exists, the results approximate the standard LRpath results. </li>
   			 </span>          
			</div>				
			</div>	

<!--  OVERVIEW PANEL ---------------------------------------------------------------------------------------------------------------------->

			<div id="contentPanel">
				<span class="contentTitle">Overview</span>
				<div id="textPanel">
					<span class="text">LRpath performs gene set enrichment
						testing, an approach used to test for predefined
						biologically-relevant gene sets that contain more significant
						genes from an experimental dataset than expected by chance. Given
						a high-throughput dataset with continuous significance values
						(i.e. p-values), LRpath tests for gene sets (termed concepts) that
						have significantly higher significance values (e.g. for
						differential expression) than expected at random. LRpath can
						identify both concepts that have a few genes with very significant
						differential expression and concepts containing many genes with
						only moderate differential expression. This user interface
						provides a user-friendly implementation of LRpath, and greatly
						expands the set of concepts available to test from the <a
						href="http://www.ncbi.nlm.nih.gov/pubmed/19038984">original
							publication</a><sup2>1</sup2>. Genes are mapped to concepts using their
						<a href="http://www.ncbi.nlm.nih.gov/gene">Entrez Gene</a> IDs.
						The pre-defined gene sets (<a
						href="browse.jsp">concept
							databases</a>) available to test depend on the species, but for
						human, mouse, and rat include all those used in <a
						href="http://conceptgen.ncibi.org/core/conceptGen/index.jsp">ConceptGen</a>.
						The use of <a
						href="http://en.wikipedia.org/wiki/Logistic_regression">logistic
							regression</a> allows the data to remain on a continuous scale while 
							maintaining the interpretation of
						results in terms of an <a
						href="http://en.wikipedia.org/wiki/Odds_ratio">odds ratio</a> , as
						is used with the standard <a
						href="http://en.wikipedia.org/wiki/Fisher's_exact_test">Fisher's
							Exact test</a>. Detailed methods are provided <a href="method.pdf">here</a>.
						When LRpath is run for multiple comparisons in an experiment, it
						can be useful to visualize the results in a clustering heatmap
						(see example). To cluster your own LRpath results, scroll down to
						the bottom of the page to the Clustering section. </span>

                        <span class="text">
                            <p>
                                You can watch a tutorial on LRPath <a href="http://sibko.med.umich.edu/av/lrp.html">here</a>.
                            </p>
                        </span>
				</div>
				<hr>
			</div>

<!--  FORM PANEL -------------------------------------------------------------------------------------------------------------------------->

			<div id="formContentPanel">
				<span class="contentTitle">Input</span>
				<div id="textPanel">
					<center>
						<div id="formPanel">
							<form action="action.jsp" method="post" id="upform" name="upform"
								enctype="multipart/form-data">
								<input type="hidden" name="isDatabaseExternal" value="true" />
								<input type="hidden" name="todo" value="upload">


<!--  BASIC FORM -------------------------------------------------------------------------------------------------------------------------->

								<span class="formTitle">LRPath Analysis (Basic Options)</span>
								<hr>
								<table id="basic">
									<tr>
										<td align="right" valign="top" width="140"><span
											class="formText">Species</span></td>
										<td><select name="species" id="species" size="1" class="formObject"
											onChange="SelectSubCat();">
												<option value="hsa">Human</option>
												<option value="mmu">Mouse</option>
												<option value="rno">Rat</option>
												<option value="dme">Drosophila melanogaster</option>
												<option value="dre">Zebrafish</option>
												<option value="cel">C.elegans</option>
												<option value="sce">Yeast</option>
										</select>
										</td>
									</tr>
									<tr>
										<td align="right" valign="top"><span class="formText">Database</span>
										</td>
										<td>
											<div id="databaseList">
												<ul class="checklist">
													<li><label>Functional Annotations</label>
														<ul>
															<li><label><input name="database"
																	value="Biocarta Pathway" type="checkbox" /><a
																	href="http://www.biocarta.com/">Biocarta Pathway</a>
															</label>
															</li>
															<li><label><input name="database"
																	value="EHMN Pathway Gene" type="checkbox" /><a
																	href="http://www.ehmn.bioinformatics.ed.ac.uk">EHMN
																		metabolic pathways</a>
															</label>
															</li>

															<li><label><input name="database" value="GO"
																	type="checkbox" id="go" onclick="selectAllGO()" /><a
																	href="http://www.geneontology.org/">GO</a>
															</label>
																<ul>
																	<li><label><input name="database"
																			value="GOBP" id="gobio"
																			type="checkbox" /><a
																			href="http://www.geneontology.org/">GO Biological
																				Process</a>
																	</label>
																	</li>
																	<li><label><input name="database"
																			value="GOCC" id="gocell"
																			type="checkbox" /><a
																			href="http://www.geneontology.org/">GO Cellular
																				Component</a>
																	</label>
																	</li>
																	<li><label><input name="database"
																			value="GOMF" id="gomol"
																			type="checkbox" /><a
																			href="http://www.geneontology.org/">GO Molecular
																				Function</a>
																	</label>
																	</li>
																</ul></li>
															<li><label><input name="database"
																	value="KEGG" type="checkbox" /><a
																	href="http://www.genome.jp/kegg/">KEGG Pathway</a>
															</label>
															</li>
															<li><label><input name="database"
																	value="Panther Pathway" type="checkbox" /><a
																	href="http://www.pantherdb.org/pathway/">Panther
																		Pathway</a>
															</label>
															</li>
															<li><label><input name="database"
																	value="pFAM" type="checkbox" /><a
																	href="http://pfam.sanger.ac.uk/">pFAM</a>
															</label>
															</li>
															<li><label><input name="database"
																	value="reactome" type="checkbox" /><a
																	href="http://www.reactome.org/">Reactome</a>
															</label>
															</li>
														</ul></li>
													<li><label>Literature Derived</label>
														<ul>
															<li><label><input name="database"
																	value="MeSH" type="checkbox" /><a
																	href="http://gene2mesh.ncibi.org/">MeSH</a>
															</label>
															</li>
															
														</ul></li>
													<li><label>Targets</label>
														<ul>
															<li><label><input name="database"
																	value="Drug Bank" type="checkbox" /><a
																	href="http://www.drugbank.ca/">Drug Bank</a>
															</label>
															</li>
															<li><label><input name="database"
																	value="miRBase" type="checkbox" /><a
																	href="http://www.mirbase.org/">miRBase</a>
															</label>
															</li>
															<li><label><input name="database"
																	value="Transcription Factors" type="checkbox" /><a
																	href="http://biobase-international.com/index.php?id=transfac">Transcription
																		Factors</a>
															</label>
															</li>
														</ul></li>
													<li><label>Interaction</label>
														<ul>
															<li><label><input name="database"
																	value="Protein Interaction (MiMI)" type="checkbox" /><a
																	href="http://mimi.ncibi.org/MimiWeb/main-page.jsp">Protein
																		Interaction (MiMI)</a>
															</label>
															</li>
														</ul></li>
													<li><label>Other</label>
														<ul>
															<li><label><input name="database"
																	value="Metabolite" type="checkbox" /><a
																	href="http://www.ncibi.org">Metabolite</a>
															</label>
															</li>
															<li><label><input name="database"
																	value="Cytoband" type="checkbox" /><a
																	href="http://www.ncbi.nlm.nih.gov/sites/entrez?db=gene">Cytoband</a>
															</label>
															</li>
															
														</ul></li>
														
														<li><label><span style="color:red;font-size:5pt"><sup>NEW!!!!</sup></span><label>Custom</label></label></li>
														<ul>
														 <li><label><input name="database" value="custom" type="checkbox" id="custom" /><a href="">Custom</a></label>
																	<input id="uploadCustomfile" type="file" name="uploadcustomfile" size="30" class="formObject" onchange="uploadFile()">
															
														</li>
														<p><span class="footnote">To test custom gene sets, please provide a text file with 2 columns in 
															the following order:(1) gene set ID or name.  An example is provided <a href="images/customeg.txt" target="_blank">here</a>.</p></span>
														</ul>
		
												</ul>
											</div> <span class="footnote">Selecting multiple, or a
												large, concept database may require several minutes of
												computation time.</span> 
												<span class="footnote">For approximate LRPath
												running times against different databases view 
												<a href="EstimatedTimesPerDB.html" target="_blank">this</a> table.</span>
											 <br /></td>
									</tr>
									<tr>
									<td align="right" valign="top"><span class="formText">Methods</span>
										</td>
									<td>
									
									<ul class="methods">
									<li><input type="radio" name="methods" value="lrpath" /><span class="formText"> LRpath</span><br />
									<span class="footnote1">
									LRpath is best for microarray data or RNA-seq data known not to exhibit any relationship between gene read counts and differential gene expression p-values.
									</span></li>
									
									<li><input type="radio" name="methods" value="rnaenrich"/><span class="formText">RNA-Enrich</span><br />
									<span class="footnote1">RNA-Enrich is faster than LRpath and best for RNA-seq data that exhibit a relationship between gene read counts and significance of differential gene expression (e.g. genes with higher read counts may have more significant p-values, and vice versa). Unless a thorough analysis has been done, we recommend RNA-Enrich for RNA-seq data.
									</span></li>
									
									<li><input type="radio" name="methods" value="randomsets"/><span class="formText">Random Sets</span><br />
									<span class="footnote1">The random sets method provides an approximation of LRpath also with faster calculation time.
									</span></li>								
									</ul> 
									</td>
									</tr>
									
									<tr>
									<td align="right" valign="top"><span class="formText">Directional test?</span>
										</td>
										<td><input type="radio" name="isDirection"
											class="formObject" value="true" /><span class="formText">Yes</span>
											<input type="radio" name="isDirection" class="formObject"
											value="false" checked="checked" /><span class="formText">No</span>
											<br /> <br /> <span class="footnote">Yes - A test
												will be performed that allows the user to distinguish
												between 'Up' or 'Down' regulated concepts. A directional
												test requires the user to specify a direction for each gene
												in the input file.</span> <br /> <span class="footnote">No
												- A test will be performed that allows the user to
												distinguish between 'Enriched' and 'Depleted' concepts, but
												not between concepts enriched with 'Up' versus 'Down'
												regulated genes.</span> <br /> <br /></td>
									</tr>
									<tr>
										<td align="right" valign="top"><span class="formText">Select
												input file</span>
										</td>
										<td><input id="uploadfile" type="file" name="uploadfile"
											size="30" class="formObject"> <br /> <br /> 
											<span class="footnote">											
											<b>LRpath or Random sets: </b>Tab-delimited text with columns: (1) Entrez Gene ID or official gene symbol (Entrez Gene ID is recommended), (2) p-value, and (3) if a directional test is selected, a column indicating Up-regulation (any positive value) or Down (any negative value). <br /> 
											<b>RNA-Enrich:</b> Same as above but also include (4) either a column with average read count for each gene, or multiple columns with read counts for each gene and each subject/sample. See top of an example input file <a href="images/HSA_Prostate_RNAEnrich.txt" target="_blank">here</a>  <br /> 
											<b>Drosophila with KEGG:</b>  FlyBase IDs are used instead of Entrez Gene IDs (ex: FBgn0036605). Yeast: use SGD IDs (Ex: YBL091C) for all databases
										</span>
										</td>
									</tr>
									<tr>
										<td align="right" valign="top"></td>
										<td><input type="radio" name="isGeneId"
											class="formObject" value="geneId" checked="checked" /><span
											class="formText">Entrez Gene Id</span> <input type="radio"
											name="isGeneId" class="formObject" value="geneSymbol" /><span
											class="formText">Official Gene Symbol</span>
											<input type="radio"name="isGeneId" class="formObject" value="otherId" /><span
											class="formText">Other Identifier</span>
										</td>
									</tr>
									<tr>
										<td align="right" valign="top"><span class="formText">Significance
												cut-off for reporting the driving genes</span>
										</td>
										<td><input type="text" name="sigCutoff" size="7"
											class="formObject" value="0.05" />									
									</tr>
									<tr>
									<td align="right" valign="top"><span class="formText">Analysis Name</span></td>
									<td><input id="outname" type="text" name="outname" size="30" class="formObject" onChange="validate(this);"> <br />
										<span class="footnote">
										Please provide a meaningful name for this analysis.
										</span>
										<br/>
									</td>									
									</tr>
									<tr>
										<td align="right" valign="top"><span class="formText">Email</span>
										</td>
										<td><input id="email" type="text" name="email" size="30"
											class="formObject"> <br /> <br /> <span
											class="footnote">Please provide your email address if
												you wish to be notified when the analysis has been
												completed.</span>
										</td>
									</tr>
								</table>
								<hr>

<!--  ADVANCED FORM ----------------------------------------------------------------------------------------------------------------------->

								<div id="advancedIcon">
									<span class="formTitle">Advanced Analysis Options</span> <img
										title="Click to expand for advanced options"
										src="images/expand.jpg" border="0" style="margin-left: 460px;"
										onclick="expandAdvancedOptions()" />
								</div>

								<hr>

								<table id="advanced" style="display: none">
									<tr>
										<td colspan="4"><br /> <span class="footnote">Options
												to filter which concepts are tested:</span>
										</td>
									</tr>
									<tr>
										<td align="right" valign="top" width="250"><span
											class="formText">Maximum number of genes in concept</span>
										</td>
										<td><input type="text" name="maxG" size="7"
											class="formObject" value="999999" />
										</td>
										<td align="right" valign="top"><span class="formText">Minimum
												number of genes in concept</span>
										</td>
										<td><input type="text" name="minG" size="7"
											class="formObject" value="10" />
										</td>
									</tr>
									<tr>
										<td colspan="4"><br /> <span class="footnote">Statistical
												Options:</span>
										</td>
									</tr>
									<tr>
										<td align="right" valign="top"><span class="formText">Low
												value used to calculate odds ratio</span>
										</td>
										<td><input type="text" name="oddsMin" size="7"
											class="formObject" value="0.001" />
										</td>
										<td align="right" valign="top"><span class="formText">High
												value used to calculate odds ratio</span>
										</td>
										<td><input type="text" name="oddsMax" size="7"
											class="formObject" value="0.5" />
										</td>
									</tr>
									
								</table>
<!--  SUBMIT FORM ------------------------------------------------------------------------------------------------------------------------->

								<hr />
								<!--  <input type="button" value="Submit" class="formButton" onclick="loadOnSubmit();" /> -->
								<center>
									<input type="button" id="submit_prog" value='Submit'
										onclick="validateForm()" />
								</center>
							</form>
						</div>
					</center>
				</div>
			</div>


<!--  CLUSTERING FORM --------------------------------------------------------------------------------------------------------------------->


			<div id="clusteringPanel">
				<hr />
				<span class="contentTitle">LRpath Clustering Analysis</span>
				<div id="textPanel">
					<span class="text"> LRpath Cluster Analysis allows you to
						integrate your LRpath results from multiple experiments in order
						to interactively view and explore the enrichment profiles of a set
						of concepts across experiments. It provides a user-friendly method
						for filtering, merging, and clustering LRpath results using
						several options. The output of this section is a set of files
						required to view the hierarchical clustering with each row
						corresponding to a concept, and each column corresponding to an
						experiment. In order to view and interact with the results of the
						cluster analysis you can use the freely available <a
						href="http://jtreeview.sourceforge.net/" target="_new">TreeView software</a>.
						Simply save the output files from the cluster analysis in one
						folder, and then once TreeView is installed, start the program,
						and open the saved .cdt file. For more help, see the <a
						href="http://jtreeview.sourceforge.net/manual.html" target="_new">Java
							TreeView Documentation</a>. An example of the resulting clustering is
						provided <a href="LRPATH_Heatmap.pdf"  target="_new">here</a>.
						</span>
					</div>
					<hr> 
					<center>
						<div id="formPanel">
							<div id="advancedIcon">
								<span class="formTitle"> Analysis Form</span>
							</div>
							<hr />
							<form name="clusterForm" action="cluster/action.jsp"
								method="post">
								<table id="advanced">
									<tr>
										<td align="right" valign="top" colspan="2">
											<table>
												<tr>
													<td colspan="2"><span class="formText">Select
															value to cluster by:</span> <select name="clusterType" size="1"
														class="formObject">
															<option value="log10">-log10(p-values)</option>
															<option value="log2">log2(odds ratios)</option>
													</select></td>
												</tr>
												<tr>
													<td colspan="2"><span class="formText">Select
															method for distance matrix:</span> <select name="distanceMatrix"
														size="1" class="formObject">
															<option value="euclidean">euclidean</option>
															<option value="maximum">maximum</option>
															<option value="manhattan">manhattan</option>
															<option value="canberra">canberra</option>
															<option value="binary">binary</option>
															<option value="pearson">Pearson correlation
																(uncentered)</option>
															<option value="correlation">Pearson correlation
																(centered)</option>
															<option value="spearman">spearman</option>
													</select></td>
												</tr>
												<tr>
													<td colspan="2"><span class="formText">Select
															link for clustering:</span> <select name="linkClustering"
														size="1" class="formObject">
															<option value="ward">ward</option>
															<option value="single">single</option>
															<option value="complete">complete</option>
															<option value="average">average</option>
															<option value="mcquitty">mcquitty</option>
															<option value="median">median</option>
															<option value="centroid">centroid</option>
													</select></td>
												</tr>
												<tr>
													<td colspan="2"><span class="formText">Cluster
															concepts with <select name="clusterFilterOn" size="1"
															class="formObject">
																<option value="p-value">P-value</option>
																<option value="fdr">FDR</option>
														</select> < <input type="text" name="clusterFilterValue" size="7"
															class="formObject" value="0.05" /> in at least <input
															type="text" name="clusterFilterNum" size="2"
															class="formObject" value="1" /> LRpath comparisons.</span><br />
														<span class="footnote">cannot exeed the number of
															URLs provided</span></td>
												</tr>
												<tr>
													<td><br />
													<br />
														<table id="dataTable">
															<tr>
																<td><span class="formText">URL</span><input id="cluster1"
																	type="text" name="clusterURL" class="formObject"
																	size="40"></td>
																<td><span class="formText">Comparison Name</span><input
																	type="text" name="fileNames" class="formObject"
																	size="20"></td>
															</tr>
															<tr>
																<td><span class="formText">URL</span><input id="cluster2"
																	type="text" name="clusterURL" class="formObject"
																	size="40"></td>
																<td><span class="formText">Comparison Name</span><input
																	type="text" name="fileNames" class="formObject"
																	size="20"></td>
															</tr>
														</table></td>
												</tr>
												<tr>
													<td colspan="2"><input type="button" id="button2"
														value="Add File" class="formColor" onclick="addRow()">
													</td>
												</tr>

												<tr>
													<td colspan="2"><span class="footnote"> Enter
															two or more URLs for LRpath <b>text</b> results to
															cluster, and a name for each comparison/LRpath result
															(must be in same order). Example URL: external link:
															http://lrpath.ncibi.org/result/download999999999.txt</span></td>
												</tr>
											</table></td>
									</tr>
								</table>
								<hr />
								<center>
									<input type="submit" id="submit_prog" value='Submit' />
								</center>
							</form>
						</div>
					</center>
				
			</div>


<!--  LOADING ANIMATION PANEL ------------------------------------------------------------------------------------------------------------->

			<div id="loadingPanel" style="display: none;">
				<center>
					<img src="images/loading.gif" id="preloader" />
				</center>
				<hr>
			</div>

<!--  REFERENCE PANEL --------------------------------------------------------------------------------------------------------------------->

			<div id="contentPanel">
				<hr>
				<span class="contentTitle">Reference</span>
				<div id="textPanel">
					<span class="text">Please reference the following
						publication when citing LRpath: <br /> <br />
						Kim JH, Karnovsky A, Mahavisno V, Weymouth T, Pande M, Dolinoy DC, Rozek LS, Sartor MA. (2012) LRpath analysis 
						reveals common pathways dysregulated via DNA methylation across cancer types, BMC Genomics, 13, 526.<br/> <br/>
						Lee, C, Patil S, Sartor MA.  RNA-Enrich: A cut-off free functional enrichment testing method for RNA-seq with improved power.  In progress.
						<br/>
						<br/> 
						Newton MA, Quintana FA, Boon JA, Sengupta S and Ahlquist P:Random-set methods identify distinct aspects of the enrichment signal in gene-set analysis,Ann. Appl. Stat.Volume 1, Number 1 (2007), 85-106
						<br/>
						<br/><span class="text">For support and questions email: snehal@med.umich.edu  <br /> </span>
						 </span>
				</div>
				<hr />
			</div>

			<!--  FOOTER PANEL ------------------------------------------------------------------------------------------------------------------------>


			<div id="contentPanel">
				<div id="textPanel">
					<center>
						<img src="images/dcmb.jpg" /> <br /> <br /> <span
							class="text"> Copyright 2010 The University of Michigan <br />
							<br /> Grant # R01 LM008106 ("Representing and
							Acquiring Knowledge of Genome <br /> Regulation") and the
							National Center for Integrative Biomedical <br /> Informatics
							(NCIBI), NIH Grant # U54 DA021519 01A1 <br /> Terms of Use </span>
					</center>
				</div>
			</div>

		</div>
	</center>
</body>
</html>
