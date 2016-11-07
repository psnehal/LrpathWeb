<%@ page language="java" import="java.io.*,java.util.*,java.text.*,java.math.*,org.ncibi.resource.util.*, org.ncibi.lrpath.*, org.ncibi.lrpath.config.RServerConfiguration;" %>
<jsp:useBean id="csb" scope="session" class="org.ncibi.resource.util.ClusterSessionBean" />
<%

//******************************************************************************************************************************************
// RUN ANALYSIS

LRPathRServer rserver = new LRPathRServer(RServerConfiguration.rserverAddress(), RServerConfiguration.rserverPort());
LRPathHCluster analysis = new LRPathHCluster(rserver);
String outFile = csb.getOutFile();

analysis.run(csb.getSigvals(), csb.getCutoff(), csb.getNumExpans(), csb.getColumnNames(), csb.getColumnSize(), csb.getRowNames(), csb.getData(), csb.getRowSize(), csb.getMethod(), csb.getLink(), csb.getOutputFilePath());


//******************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>LRpath - Pathway Analysis using Logistic Regression</title>
		<link rel="stylesheet" type="text/css" href="../css/style.css">
		<script type="text/javascript" src="../js/action.js"></script>
	</head>
	<body>
		<center>
			<div id="mainPanel">

<!--  LOGO PANEL -------------------------------------------------------------------------------------------------------------------------->			

				<div id="logoPanel">
					<img alt="LRpath" src="../images/logo.jpg">
					<br />
					<br />
					<span class="logoTitle">Pathway Analysis using Logistic Regression</span>
					<hr>
				</div>
							
<!--  RESULTS PANEL ---------------------------------------------------------------------------------------------------------------------->	
				
				<div id="contentPanel">
				    <span class="contentTitle">Analysis Results</span>
					<div id="textPanel">
					<span class="text">
						<a href="http://lrpath.ncibi.org/result/<%= outFile %>.cdt"><%= outFile %>.cdt</a><br />
						<a href="http://lrpath.ncibi.org/result/<%= outFile %>.atr"><%= outFile %>.atr</a><br />
						<a href="http://lrpath.ncibi.org/result/<%= outFile %>.gtr"><%= outFile %>.gtr</a><br />
					</span>
					</div>
					<hr>
				</div>
				
<!--  FOOTER PANEL ------------------------------------------------------------------------------------------------------------------------>	
							
				<div id="contentPanel">
					<div id="textPanel">			
					<center>
					<img src="../images/ncibiLogo.gif" />
					<br />
					<br />
					<span class="text">
						Copyright 2010 The University of Michigan 
						<br />
						Developed under the support of the NIH/National Library of Medicine 
						<br />
						Grant # R01 LM008106 ("Representing and Acquiring Knowledge of Genome 
						<br />
						Regulation") and the National Center for Integrative Biomedical 
						<br />
						Informatics (NCIBI), NIH Grant # U54 DA021519 01A1 
						<br />
						Terms of Use 
					</span>
					</center>
					</div>
				</div>							
			</div>
		</center>
 	</body>
</html>	





