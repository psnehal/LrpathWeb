function expandAdvancedOptions()
{
	if(document.getElementById("advanced").style.display == 'none')
	{
		document.getElementById("advanced").style.display = 'block';
		document.getElementById("advancedIcon").innerHTML = 
			'<span class="formTitle">Advanced Analysis Options</span>'
			+ '<img title="Click to close advanced options" src="images/unexpand.jpg" border="0" style="margin-left: 460px;" onclick="expandAdvancedOptions()"/>';
	}
	else
	{
		document.getElementById("advanced").style.display = 'none';
		document.getElementById("advancedIcon").innerHTML = 
			'<span class="formTitle">Advanced Analysis Options</span>'
			+ '<img title="Click to expand for advanced options" src="images/expand.jpg" border="0" style="margin-left: 460px;" onclick="expandAdvancedOptions()"/>';
	}
	
}


function selectAllGO()
{

	if(document.getElementById("go").checked == false)
	{
		document.getElementById("gobio").checked=false;
		document.getElementById("gocell").checked=false;
		document.getElementById("gomol").checked=false;
	}
	else
	{
		document.getElementById("gobio").checked=true;
		document.getElementById("gocell").checked=true;
		document.getElementById("gomol").checked=true;
	} 
}

function  uploadFile()
{
	
console.log("its in function");

document.getElementById("custom").checked = true;

}


function SelectSubCat()
{
	removeAllOptions();

	if(document.upform.species.value == 'hsa' )
	{
		
		var list = 	
			'<ul class="checklist">'
			+ '<li><label>Functional Annotations</label>'
			+ '	<ul>'		
			+ '	<li><label><input name="database" value="Biocarta Pathway" type="checkbox"/><a href="http://www.biocarta.com/">Biocarta Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="EHMN Pathway Gene" type="checkbox"/><a href="http://www.ehmn.bioinformatics.ed.ac.uk">EHMN metabolic pathways</a></label></li>'
			+ '	<li><label><input name="database" value="GO" type="checkbox" id="go" onclick="selectAllGO()"/><a href="http://www.geneontology.org/">GO</a></label>'
			+ '		<ul>'
			+ '		<li><label><input name="database" value="GOBP" id="gobio" type="checkbox"/><a href="http://www.geneontology.org/">GO Biological Process</a></label></li>'
			+ '		<li><label><input name="database" value="GOCC" id="gocell" type="checkbox"/><a href="http://www.geneontology.org/">GO Cellular Component</a></label></li>'
			+ '		<li><label><input name="database" value="GOMF" id="gomol" type="checkbox"/><a href="http://www.geneontology.org/">GO Molecular Function</a></label></li>'
			+ '		</ul>'
			+ '	</li>'
			+ '	<li><label><input name="database" value="KEGG" type="checkbox" /><a href="http://www.genome.jp/kegg/">KEGG Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="Panther Pathway" type="checkbox"/><a href="http://www.pantherdb.org/pathway/">Panther Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="pFAM" type="checkbox"/><a href="http://pfam.sanger.ac.uk/">pFAM</a></label></li>'
			+ '	<li><label><input name="database" value="reactome" type="checkbox"/><a href="http://www.reactome.org">Reactome</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Literature Derived</label>'
			+ '	<ul>'	
			+ '	<li><label><input name="database" value="MeSH" type="checkbox"/><a href="http://gene2mesh.ncibi.org/">MeSH</a></label></li>'
			//+ '	<li><label><input name="database" value="OMIM" type="checkbox"/><a href="http://www.ncbi.nlm.nih.gov/omim">OMIM</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Targets</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Drug Bank" type="checkbox"/><a href="http://www.drugbank.ca/">Drug Bank</a></label></li>'
			+ '	<li><label><input name="database" value="miRBase" type="checkbox"/><a href="http://www.mirbase.org/">miRBase</a></label></li>'
			+ ' <li><label><input name="database" value="Transcription Factors" type="checkbox"/><a href="http://www.mirbase.org/">Transcription Factors</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Interaction</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Protein Interaction (MiMI)" type="checkbox"/><a href="http://mimi.ncibi.org/MimiWeb/main-page.jsp">Protein Interaction (MiMI)</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Other</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Metabolite" type="checkbox"/><a href="http://www.ncibi.org">Metabolite</a></label></li>'
			+ '	<li><label><input name="database" value="Cytoband" type="checkbox"/><a href="http://www.ncbi.nlm.nih.gov/sites/entrez?db=gene">Cytoband</a></label></li>'
			+' </ul>'
			+ '</li>'
			+ ' <li><label><span style="color:red;font-size:5pt"><sup>NEW!!!!</sup></span><label>Custom</label></li>'
			+ ' <ul>'
			+ '<li><label><input name="database" value="custom" type="checkbox" id="custom" /><a href="">Custom</a>'
			+ '	<input id="uploadCustomfile" type="file" name="uploadcustomfile" size="30" class="formObject" onchange="uploadFile()"></label>'
			+ ' </li>' 
			+ ' <p><span class="footnote">To test custom gene sets, please provide a text file with 2 columns in the following order:'
			+ ' (1) gene set ID or name, and (2) official gene symbol or gene ID.  The file should be a 1 gene set to 1 gene mapping.  An example is provided here.</p></span></ul>'
		
			+ '</ul>';
			+ '</ul>';
		
		document.getElementById("databaseList").innerHTML = list;		
		document.upform.isDatabaseExternal.value = 'true';
	}

	if(document.upform.species.value == 'mmu')
	{
		var list = 	
			'<ul class="checklist">'
			+ '<li><label>Functional Annotations</label>'
			+ '	<ul>'		
			+ '	<li><label><input name="database" value="Biocarta Pathway" type="checkbox"/><a href="http://www.biocarta.com/">Biocarta Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="EHMN Pathway Gene" type="checkbox"/><a href="http://www.ehmn.bioinformatics.ed.ac.uk">EHMN metabolic pathways</a></label></li>'
			+ '	<li><label><input name="database" value="GO" type="checkbox" id="go" onclick="selectAllGO()"/><a href="http://www.geneontology.org/">GO</a></label>'
			+ '		<ul>'
			+ '		<li><label><input name="database" value="GOBP" id="gobio" type="checkbox"/><a href="http://www.geneontology.org/">GO Biological Process</a></label></li>'
			+ '		<li><label><input name="database" value="GOCC" id="gocell" type="checkbox"/><a href="http://www.geneontology.org/">GO Cellular Component</a></label></li>'
			+ '		<li><label><input name="database" value="GOMF" id="gomol" type="checkbox"/><a href="http://www.geneontology.org/">GO Molecular Function</a></label></li>'
			+ '		</ul>'
			+ '	</li>'
			+ '	<li><label><input name="database" value="KEGG" type="checkbox" /><a href="http://www.genome.jp/kegg/">KEGG Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="Panther Pathway" type="checkbox"/><a href="http://www.pantherdb.org/pathway/">Panther Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="pFAM" type="checkbox"/><a href="http://pfam.sanger.ac.uk/">pFAM</a></label></li>'
			+ '	<li><label><input name="database" value="reactome" type="checkbox"/><a href="http://www.reactome.org">Reactome</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Literature Derived</label>'
			+ '	<ul>'	
			+ '	<li><label><input name="database" value="MeSH" type="checkbox"/><a href="http://gene2mesh.ncibi.org/">MeSH</a></label></li>'
			//+ '	<li><label><input name="database" value="OMIM" type="checkbox"/><a href="http://www.ncbi.nlm.nih.gov/omim">OMIM</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Targets</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Drug Bank" type="checkbox"/><a href="http://www.drugbank.ca/">Drug Bank</a></label></li>'
			+ '	<li><label><input name="database" value="miRBase" type="checkbox"/><a href="http://www.mirbase.org/">miRBase</a></label></li>'
			+ ' <li><label><input name="database" value="Transcription Factors" type="checkbox"/><a href="http://www.mirbase.org/">Transcription Factors</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Interaction</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Protein Interaction (MiMI)" type="checkbox"/><a href="http://mimi.ncibi.org/MimiWeb/main-page.jsp">Protein Interaction (MiMI)</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Other</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Metabolite" type="checkbox"/><a href="http://www.ncibi.org">Metabolite</a></label></li>'
			//+ '	<li><label><input name="database" value="Cytoband" type="checkbox"/><a href="http://www.ncbi.nlm.nih.gov/sites/entrez?db=gene">Cytoband</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ ' <li><label><span style="color:red;font-size:5pt"><sup>NEW!!!!</sup></span><label>Custom</label></li>'
			+ ' <ul>'
			+ '<li><label><input name="database" value="custom" type="checkbox" id="custom" /><a href="">Custom</a>'
			+ '	<input id="uploadCustomfile" type="file" name="uploadcustomfile" size="30" class="formObject" onchange="uploadFile()"></label>'
			+ ' </li>' 
			+ ' <p><span class="footnote">To test custom gene sets, please provide a text file with 2 columns in the following order:'
			+ ' (1) gene set ID or name, and (2) official gene symbol or gene ID.  The file should be a 1 gene set to 1 gene mapping.  An example is provided here.</p></span></ul>'
		
			+ '</ul>';
			+ '</ul>';
		
		document.getElementById("databaseList").innerHTML = list;
		document.upform.isDatabaseExternal.value = 'true';
	}

	if(document.upform.species.value == 'rno')
	{
		var list = 	
			'<ul class="checklist">'
			+ '<li><label>Functional Annotations</label>'
			+ '	<ul>'		
			+ '	<li><label><input name="database" value="Biocarta Pathway" type="checkbox"/><a href="http://www.biocarta.com/">Biocarta Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="EHMN Pathway Gene" type="checkbox"/><a href="http://www.ehmn.bioinformatics.ed.ac.uk">EHMN metabolic pathways</a></label></li>'
			+ '	<li><label><input name="database" value="GO" type="checkbox" id="go" onclick="selectAllGO()"/><a href="http://www.geneontology.org/">GO</a></label>'
			+ '		<ul>'
			+ '		<li><label><input name="database" value="GOBP" id="gobio" type="checkbox"/><a href="http://www.geneontology.org/">GO Biological Process</a></label></li>'
			+ '		<li><label><input name="database" value="GOCC" id="gocell" type="checkbox"/><a href="http://www.geneontology.org/">GO Cellular Component</a></label></li>'
			+ '		<li><label><input name="database" value="GOMF" id="gomol" type="checkbox"/><a href="http://www.geneontology.org/">GO Molecular Function</a></label></li>'
			+ '		</ul>'
			+ '	</li>'
			+ '	<li><label><input name="database" value="KEGG" type="checkbox" /><a href="http://www.genome.jp/kegg/">KEGG Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="Panther Pathway" type="checkbox"/><a href="http://www.pantherdb.org/pathway/">Panther Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="pFAM" type="checkbox"/><a href="http://pfam.sanger.ac.uk/">pFAM</a></label></li>'
			+ '	<li><label><input name="database" value="reactome" type="checkbox"/><a href="http://www.reactome.org">Reactome</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Literature Derived</label>'
			+ '	<ul>'	
			+ '	<li><label><input name="database" value="MeSH" type="checkbox"/><a href="http://gene2mesh.ncibi.org/">MeSH</a></label></li>'
			//+ '	<li><label><input name="database" value="OMIM" type="checkbox"/><a href="http://www.ncbi.nlm.nih.gov/omim">OMIM</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Targets</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Drug Bank" type="checkbox"/><a href="http://www.drugbank.ca/">Drug Bank</a></label></li>'
			+ '	<li><label><input name="database" value="miRBase" type="checkbox"/><a href="http://www.mirbase.org/">miRBase</a></label></li>'
			+ ' <li><label><input name="database" value="Transcription Factors" type="checkbox"/><a href="http://www.mirbase.org/">Transcription Factors</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Interaction</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Protein Interaction (MiMI)" type="checkbox"/><a href="http://mimi.ncibi.org/MimiWeb/main-page.jsp">Protein Interaction (MiMI)</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Other</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Metabolite" type="checkbox"/><a href="http://www.ncibi.org">Metabolite</a></label></li>'
			//+ '	<li><label><input name="database" value="Cytoband" type="checkbox"/><a href="http://www.ncbi.nlm.nih.gov/sites/entrez?db=gene">Cytoband</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ ' <li><label><span style="color:red;font-size:5pt"><sup>NEW!!!!</sup></span><label>Custom</label></li>'
			+ ' <ul>'
			+ '<li><label><input name="database" value="custom" type="checkbox" id="custom" /><a href="">Custom</a>'
			+ '	<input id="uploadCustomfile" type="file" name="uploadcustomfile" size="30" class="formObject" onchange="uploadFile()"></label>'
			+ ' </li>' 
			+ ' <p><span class="footnote">To test custom gene sets, please provide a text file with 2 columns in the following order:'
			+ ' (1) gene set ID or name, and (2) official gene symbol or gene ID.  The file should be a 1 gene set to 1 gene mapping.  An example is provided here.</p></span></ul>'
		
			+ '</ul>';
			+ '</ul>';
		
		document.getElementById("databaseList").innerHTML = list;
		document.upform.isDatabaseExternal.value = 'true';
	}
	
	if(document.upform.species.value == 'dme')
	{
		var list = 	
			'<ul class="checklist">'
			+ '<li><label>Functional Annotations</label>'
			+ '	<ul>'		
			+ '	<li><label><input name="database" value="Biocarta Pathway" type="checkbox" disabled="disabled"/><a href="http://www.biocarta.com/">Biocarta Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="EHMN Pathway Gene" type="checkbox" disabled="disabled"/><a href="http://www.ehmn.bioinformatics.ed.ac.uk">EHMN metabolic pathways</a></label></li>'
			+ '	<li><label><input name="database" value="GO" type="checkbox" id="go" onclick="selectAllGO()" /><a href="http://www.geneontology.org/">GO</a></label>'
			+ '		<ul>'
			+ '		<li><label><input name="database" value="GOBP" id="gobio" type="checkbox" /><a href="http://www.geneontology.org/">GO Biological Process</a></label></li>'
			+ '		<li><label><input name="database" value="GOCC" id="gocell" type="checkbox"/><a href="http://www.geneontology.org/">GO Cellular Component</a></label></li>'
			+ '		<li><label><input name="database" value="GOMF" id="gomol" type="checkbox" /><a href="http://www.geneontology.org/">GO Molecular Function</a></label></li>'
			+ '		</ul>'
			+ '	</li>'
			+ '	<li><label><input name="database" value="KEGG" type="checkbox" /><a href="http://www.genome.jp/kegg/">KEGG Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="Panther Pathway" type="checkbox" disabled="disabled"/><a href="http://www.pantherdb.org/pathway/">Panther Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="pFAM" type="checkbox" disabled="disabled"/><a href="http://pfam.sanger.ac.uk/">pFAM</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Literature Derived</label>'
			+ '	<ul>'	
			+ '	<li><label><input name="database" value="MeSH" type="checkbox" disabled="disabled"/><a href="http://gene2mesh.ncibi.org/">MeSH</a></label></li>'
			//+ '	<li><label><input name="database" value="OMIM" type="checkbox" disabled="disabled"/><a href="http://www.ncbi.nlm.nih.gov/omim">OMIM</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Targets</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Drug Bank" type="checkbox" disabled="disabled"/><a href="http://www.drugbank.ca/">Drug Bank</a></label></li>'
			+ '	<li><label><input name="database" value="miRBase" type="checkbox" disabled="disabled"/><a href="http://www.mirbase.org/">miRBase</a></label></li>'
			+ ' <li><label><input name="database" value="Transcription Factors" type="checkbox" disabled="disabled"/><a href="http://www.mirbase.org/">Transcription Factors</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Interaction</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Protein Interaction (MiMI)" type="checkbox" disabled="disabled"/><a href="http://mimi.ncibi.org/MimiWeb/main-page.jsp">Protein Interaction (MiMI)</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Other</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Metabolite" type="checkbox" disabled="disabled"/><a href="http://www.ncibi.org">Metabolite</a></label></li>'
			//+ '	<li><label><input name="database" value="Cytoband" type="checkbox"/><a href="http://www.ncbi.nlm.nih.gov/sites/entrez?db=gene">Cytoband</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ ' <li><label><span style="color:red;font-size:5pt"><sup>NEW!!!!</sup></span><label>Custom</label></li>'
			+ ' <ul>'
			+ '<li><label><input name="database" value="custom" type="checkbox" id="custom" /><a href="">Custom</a>'
			+ '	<input id="uploadCustomfile" type="file" name="uploadcustomfile" size="30" class="formObject" onchange="uploadFile()"></label>'
			+ ' </li>' 
			+ ' <p><span class="footnote">To test custom gene sets, please provide a text file with 2 columns in the following order:'
			+ ' (1) gene set ID or name, and (2) official gene symbol or gene ID.  The file should be a 1 gene set to 1 gene mapping.  An example is provided here.</p></span></ul>'
		
			+ '</ul>';
			+ '</ul>';

		document.getElementById("databaseList").innerHTML = list;
		document.upform.isDatabaseExternal.value = 'false';
	}
	
	if(document.upform.species.value == 'dre')
	{
		var list = 	
			'<ul class="checklist">'
			+ '<li><label>Functional Annotations</label>'
			+ '	<ul>'		
			+ '	<li><label><input name="database" value="Biocarta Pathway" type="checkbox" disabled="disabled"/><a href="http://www.biocarta.com/">Biocarta Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="EHMN Pathway Gene" type="checkbox" disabled="disabled"/><a href="http://www.ehmn.bioinformatics.ed.ac.uk">EHMN metabolic pathways</a></label></li>'
			+ '	<li><label><input name="database" value="GO" type="checkbox" id="go" onclick="selectAllGO()" /><a href="http://www.geneontology.org/">GO</a></label>'
			+ '		<ul>'
			+ '		<li><label><input name="database" value="GOBP" id="gobio" type="checkbox" /><a href="http://www.geneontology.org/">GO Biological Process</a></label></li>'
			+ '		<li><label><input name="database" value="GOCC" id="gocell" type="checkbox"/><a href="http://www.geneontology.org/">GO Cellular Component</a></label></li>'
			+ '		<li><label><input name="database" value="GOMF" id="gomol" type="checkbox" /><a href="http://www.geneontology.org/">GO Molecular Function</a></label></li>'
			+ '		</ul>'
			+ '	</li>'
			+ '	<li><label><input name="database" value="KEGG" type="checkbox" /><a href="http://www.genome.jp/kegg/">KEGG Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="Panther Pathway" type="checkbox" disabled="disabled"//><a href="http://www.pantherdb.org/pathway/">Panther Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="pFAM" type="checkbox" disabled="disabled"/><a href="http://pfam.sanger.ac.uk/">pFAM</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Literature Derived</label>'
			+ '	<ul>'	
			+ '	<li><label><input name="database" value="MeSH" type="checkbox" disabled="disabled"/><a href="http://gene2mesh.ncibi.org/">MeSH</a></label></li>'
			//+ '	<li><label><input name="database" value="OMIM" type="checkbox" disabled="disabled"/><a href="http://www.ncbi.nlm.nih.gov/omim">OMIM</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Targets</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Drug Bank" type="checkbox" disabled="disabled"/><a href="http://www.drugbank.ca/">Drug Bank</a></label></li>'
			+ '	<li><label><input name="database" value="miRBase" type="checkbox" disabled="disabled"/><a href="http://www.mirbase.org/">miRBase</a></label></li>'
			+ ' <li><label><input name="database" value="Transcription Factors" type="checkbox" disabled="disabled"/><a href="http://www.mirbase.org/">Transcription Factors</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Interaction</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Protein Interaction (MiMI)" type="checkbox" disabled="disabled"/><a href="http://mimi.ncibi.org/MimiWeb/main-page.jsp">Protein Interaction (MiMI)</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Other</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Metabolite" type="checkbox" disabled="disabled"/><a href="http://www.ncibi.org">Metabolite</a></label></li>'
			//+ '	<li><label><input name="database" value="Cytoband" type="checkbox"/><a href="http://www.ncbi.nlm.nih.gov/sites/entrez?db=gene">Cytoband</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ ' <li><label><span style="color:red;font-size:5pt"><sup>NEW!!!!</sup></span><label>Custom</label></li>'
			+ ' <ul>'
			+ '<li><label><input name="database" value="custom" type="checkbox" id="custom" /><a href="">Custom</a>'
			+ '	<input id="uploadCustomfile" type="file" name="uploadcustomfile" size="30" class="formObject" onchange="uploadFile()"></label>'
			+ ' </li>' 
			+ ' <p><span class="footnote">To test custom gene sets, please provide a text file with 2 columns in the following order:'
			+ ' (1) gene set ID or name, and (2) official gene symbol or gene ID.  The file should be a 1 gene set to 1 gene mapping.  An example is provided here.</p></span></ul>'
		
			+ '</ul>';
			+ '</ul>';
		
		document.getElementById("databaseList").innerHTML = list;
		document.upform.isDatabaseExternal.value = 'false';
	}
	
	if(document.upform.species.value == 'cel')
	{
		var list = 	
			'<ul class="checklist">'
			+ '<li><label>Functional Annotations</label>'
			+ '	<ul>'		
			+ '	<li><label><input name="database" value="Biocarta Pathway" type="checkbox" disabled="disabled"/><a href="http://www.biocarta.com/">Biocarta Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="EHMN Pathway Gene" type="checkbox" disabled="disabled"/><a href="http://www.ehmn.bioinformatics.ed.ac.uk">EHMN metabolic pathways</a></label></li>'
			+ '	<li><label><input name="database" value="GO" type="checkbox" id="go" onclick="selectAllGO()" /><a href="http://www.geneontology.org/">GO</a></label>'
			+ '		<ul>'
			+ '		<li><label><input name="database" value="GOBP" id="gobio" type="checkbox" /><a href="http://www.geneontology.org/">GO Biological Process</a></label></li>'
			+ '		<li><label><input name="database" value="GOCC" id="gocell" type="checkbox"/><a href="http://www.geneontology.org/">GO Cellular Component</a></label></li>'
			+ '		<li><label><input name="database" value="GOMF" id="gomol" type="checkbox" /><a href="http://www.geneontology.org/">GO Molecular Function</a></label></li>'
			+ '		</ul>'
			+ '	</li>'
			+ '	<li><label><input name="database" value="KEGG" type="checkbox" /><a href="http://www.genome.jp/kegg/">KEGG Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="Panther Pathway" type="checkbox" disabled="disabled"//><a href="http://www.pantherdb.org/pathway/">Panther Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="pFAM" type="checkbox" disabled="disabled"/><a href="http://pfam.sanger.ac.uk/">pFAM</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Literature Derived</label>'
			+ '	<ul>'	
			+ '	<li><label><input name="database" value="MeSH" type="checkbox" disabled="disabled"/><a href="http://gene2mesh.ncibi.org/">MeSH</a></label></li>'
			//+ '	<li><label><input name="database" value="OMIM" type="checkbox" disabled="disabled"/><a href="http://www.ncbi.nlm.nih.gov/omim">OMIM</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Targets</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Drug Bank" type="checkbox" disabled="disabled"/><a href="http://www.drugbank.ca/">Drug Bank</a></label></li>'
			+ '	<li><label><input name="database" value="miRBase" type="checkbox" disabled="disabled"/><a href="http://www.mirbase.org/">miRBase</a></label></li>'
			+ ' <li><label><input name="database" value="Transcription Factors" type="checkbox" disabled="disabled"/><a href="http://www.mirbase.org/">Transcription Factors</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Interaction</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Protein Interaction (MiMI)" type="checkbox" disabled="disabled"/><a href="http://mimi.ncibi.org/MimiWeb/main-page.jsp">Protein Interaction (MiMI)</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Other</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Metabolite" type="checkbox" disabled="disabled"/><a href="http://www.ncibi.org">Metabolite</a></label></li>'
			//+ '	<li><label><input name="database" value="Cytoband" type="checkbox"/><a href="http://www.ncbi.nlm.nih.gov/sites/entrez?db=gene">Cytoband</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ ' <li><label><span style="color:red;font-size:5pt"><sup>NEW!!!!</sup></span><label>Custom</label></li>'
			+ ' <ul>'
			+ '<li><label><input name="database" value="custom" type="checkbox" id="custom" /><a href="">Custom</a>'
			+ '	<input id="uploadCustomfile" type="file" name="uploadcustomfile" size="30" class="formObject" onchange="uploadFile()"></label>'
			+ ' </li>' 
			+ ' <p><span class="footnote">To test custom gene sets, please provide a text file with 2 columns in the following order:'
			+ ' (1) gene set ID or name, and (2) official gene symbol or gene ID.  The file should be a 1 gene set to 1 gene mapping.  An example is provided here.</p></span></ul>'
		
			+ '</ul>';
			+ '</ul>';
		
		document.getElementById("databaseList").innerHTML = list;
		document.upform.isDatabaseExternal.value = 'false';
	}
	
	if(document.upform.species.value == 'sce')
	{
		var list = 	
			'<ul class="checklist">'
			+ '<li><label>Functional Annotations</label>'
			+ '	<ul>'		
			+ '	<li><label><input name="database" value="Biocarta Pathway" type="checkbox" disabled="disabled"/><a href="http://www.biocarta.com/">Biocarta Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="EHMN Pathway Gene" type="checkbox" disabled="disabled"/><a href="http://www.ehmn.bioinformatics.ed.ac.uk">EHMN metabolic pathways</a></label></li>'
			+ '	<li><label><input name="database" value="GO" type="checkbox" id="go" onclick="selectAllGO()"/><a href="http://www.geneontology.org/">GO</a></label>'
			+ '		<ul>'
			+ '		<li><label><input name="database" value="GOBP" id="gobio" type="checkbox" /><a href="http://www.geneontology.org/">GO Biological Process</a></label></li>'
			+ '		<li><label><input name="database" value="GOCC" id="gocell" type="checkbox"/><a href="http://www.geneontology.org/">GO Cellular Component</a></label></li>'
			+ '		<li><label><input name="database" value="GOMF" id="gomol" type="checkbox" /><a href="http://www.geneontology.org/">GO Molecular Function</a></label></li>'
			+ '		</ul>'
			+ '	</li>'
			+ '	<li><label><input name="database" value="KEGG" type="checkbox" /><a href="http://www.genome.jp/kegg/">KEGG Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="Panther Pathway" type="checkbox" disabled="disabled"/><a href="http://www.pantherdb.org/pathway/">Panther Pathway</a></label></li>'
			+ '	<li><label><input name="database" value="pFAM" type="checkbox" disabled="disabled"/><a href="http://pfam.sanger.ac.uk/">pFAM</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Literature Derived</label>'
			+ '	<ul>'	
			+ '	<li><label><input name="database" value="MeSH" type="checkbox" disabled="disabled"/><a href="http://gene2mesh.ncibi.org/">MeSH</a></label></li>'
			//+ '	<li><label><input name="database" value="OMIM" type="checkbox" disabled="disabled"/><a href="http://www.ncbi.nlm.nih.gov/omim">OMIM</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Targets</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Drug Bank" type="checkbox" disabled="disabled"/><a href="http://www.drugbank.ca/">Drug Bank</a></label></li>'
			+ '	<li><label><input name="database" value="miRBase" type="checkbox" disabled="disabled"/><a href="http://www.mirbase.org/">miRBase</a></label></li>'
			+ ' <li><label><input name="database" value="Transcription Factors" type="checkbox" disabled="disabled"/><a href="http://www.mirbase.org/">Transcription Factors</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Interaction</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Protein Interaction (MiMI)" type="checkbox" disabled="disabled"/><a href="http://mimi.ncibi.org/MimiWeb/main-page.jsp">Protein Interaction (MiMI)</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ '<li><label>Other</label>'
			+ '	<ul>'
			+ '	<li><label><input name="database" value="Metabolite" type="checkbox" disabled="disabled"/><a href="http://www.ncibi.org">Metabolite</a></label></li>'
			//+ '	<li><label><input name="database" value="Cytoband" type="checkbox"/><a href="http://www.ncbi.nlm.nih.gov/sites/entrez?db=gene">Cytoband</a></label></li>'
			+ '	</ul>'
			+ '</li>'
			+ ' <li><label><span style="color:red;font-size:5pt"><sup>NEW!!!!</sup></span><label>Custom</label></li>'
			+ ' <ul>'
			+ '<li><label><input name="database" value="custom" type="checkbox" id="custom" /><a href="">Custom</a>'
			+ '	<input id="uploadCustomfile" type="file" name="uploadcustomfile" size="30" class="formObject" onchange="uploadFile()"></label>'
			+ ' </li>' 
			+ ' <p><span class="footnote">To test custom gene sets, please provide a text file with 2 columns in the following order:'
			+ ' (1) gene set ID or name, and (2) official gene symbol or gene ID.  The file should be a 1 gene set to 1 gene mapping.  An example is provided here.</p></span></ul>'
		
			+ '</ul>';
			+ '</ul>';
		
		document.getElementById("databaseList").innerHTML = list;
		document.upform.isDatabaseExternal.value = 'false';
	}
}

function removeAllOptions()
{
	document.getElementById("databaseList").innerHTML = "";
}


function UploadLdFile()
{

	 var radioButtons = document.getElementsByName("rnaseq");
	 for (var x = 0; x < radioButtons.length; x ++) {
	      if (radioButtons[x].checked) {
	      	console.log(radioButtons[x].value);
	      	if(radioButtons[x].value == "yes")
         	 {
         	 console.log(document.getElementById("avgread").value);
	      	  document.getElementById("avgread").checked= true;
	      	  document.getElementById("avgread").disabled= true;
         	 
         	 }
	      	else
	      		{
	      		document.getElementById("avgread").checked= false;
	      		document.getElementById("avgread").disabled= true;
	      		
	      		}
	      }
	      
	 }
	
}





