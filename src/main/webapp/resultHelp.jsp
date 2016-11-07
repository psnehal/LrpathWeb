<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>LRpath - Result Help</title>
	<link rel="stylesheet" type="text/css" href="css/style.css">	
  </head>
  
  <body>
  	<div id="mainPanel" style="width: 540">
  		<div id="contentPanel" style="width: 500; padding: 20px; padding-top: 10px;">
  		
  		   <span class="textTitle">Descriptions of the columns in the LRpath results.</span><br /><br>
   		   1. Concept Name - Official name of the concept<br /><br>
		   2. Concept Type - the database or source of the concept<br /><br>
		   3. # Genes - the number of input genes that belong to the concept<br /><br>
		   4. Coeff - the estimated beta coefficient from the logistic regression model (a significant value &gt; 0 implies enrichment or 'up' 
		   regulation, a significant value &lt; 0 implies depletion or 'down' regulation)<br /><br>
		   5. OddsRatio - the odds ratio for enrichment (a significant value &gt; 1 implies enrichment or 'up' regulation, a significant value 
		   &lt; 1 implies depletion or 'down' regulation) (The p-values used to calculate the odds ratio can be adjusted in the Advanced Options section.)<br /><br>
		   6. P-value - the p-value for enrichment/depletion<br /><br>
		   7. FDR - the False Discovery Rate, estimated using the method of Benjamini and Hochberg (When results are sorted by p-value, a FDR &lt; 0.05 
		   is interpreted to mean that approximately 5% of the concepts with lesser or equal p-value are false positives.)<br /><br>
		   8. Direction - If a directional test was chosen, 'up' or 'down' is provided. If a non-directional test was chosen, 'Enriched' or 'Depleted' is provided.<br /><br>
		   9. SigGenes - comma delimited list of all the Entrez Gene IDs that had p-value &lt; 0.05 in the concept. The p-value cutoff value used can 
		   be adjusted in the Advanced Options section.<br><br>
		   Results can be downloaded in two formats. 1.text 2. excel. Text format doesn't contain the concept ID column and can be used for the Lrpath cluster analysls
		   
   		</div>
   	</div>
  </body>
</html>
