<%@ page language="java" import="java.util.*,org.ncibi.commons.db.JDBCExecuter"%>
<%

JDBCExecuter db = new JDBCExecuter(ResourceBundle.getBundle("org.ncibi.resource.bundle.database"));
ResourceBundle sql = ResourceBundle.getBundle("org.ncibi.resource.bundle.sql");

String query = sql.getString("selectBrowseConcepts");
List<List<String>> list = db.select(query);

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
				    <span class="formTitle">Browse Concept Types</span>
					<div id="textPanel">
					   <div class="formBox">
						<table width="100%" class="tableStyle" border="1" cellpadding="0">
							<tr>
								<td>
									<span class="text"><b>Concept Type</b></span>
								</td>
								<td>
									<span class="text"><b>Category</b></span>
								</td>
								<td>
									<span class="text"><b>Concept Size</b></span>
								</td>
							</tr>
						
						<%
							for (int i = 0; i < list.size(); i++)
							{
								List<String> row = list.get(i);
						%>
							<tr>
								<td>
									<span class="text"> 
										<a href="concepts.jsp?cid=<%= (String) row.get(0) %>"><%=(String) row.get(1)%></a> 
									</span>
								</td>
								<td>
									<span class="text"><%=(String) row.get(2)%></span>
								</td>
								<td>
									<span class="text"><%=(String) row.get(3)%> </span>
								</td>
							</tr>
						<%
							}
						%>
						</table>
					  </div>
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