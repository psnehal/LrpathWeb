<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//******************************************************************************************************************************************

String uid = request.getParameter("uid");
String df = request.getParameter("df");

//******************************************************************************************************************************************
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>LRpath - Pathway Analysis using Logistic Regression</title>
		<link rel="stylesheet" type="text/css" href="css/style.css">
		<script type="text/javascript" src="js/action.js"></script>
	</head>
	<body>
		<center>
			<div id="mainPanel">

<!--  LOGO PANEL -------------------------------------------------------------------------------------------------------------------------->			

				<div id="logoPanel">
					<img alt="LRpath" src="images/logo.jpg">
					<br />
					<br />
					<span class="logoTitle">Pathway Analysis using Logistic Regression</span>
					<hr>
				</div>
							
<!--  RESULTS PANEL ---------------------------------------------------------------------------------------------------------------------->	
				
				<div id="contentPanel">
				    <span class="contentTitle">Analysis Status</span>
					<div id="textPanel">
					<span class="text">
						Your dataset has been submitted for analysis. Please check back using this link
				    	<br>
				    	<br>
				    	<a href="result.jsp?uid=<%= uid %>&df=<%= df %>">
				    	result.jsp?uid=<%= uid %>&df=<%= df %></a>
					</span>
					</div>
					<hr>
				</div>
				
<!--  FOOTER PANEL ------------------------------------------------------------------------------------------------------------------------>	
							
				<div id="contentPanel">
					<div id="textPanel">			
					<center>
					<img src="images/ncibiLogo.gif" />
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