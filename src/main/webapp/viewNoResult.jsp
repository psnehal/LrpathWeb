<%@ page language="java" import="javazoom.upload.*,java.util.*,java.io.*,java.text.*,java.math.*,org.ncibi.lrpath.*,org.ncibi.resource.util.*" %>
<%
ResourceBundle url = ResourceBundle.getBundle("org.ncibi.resource.bundle.url");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>LRpath - Pathway Analysis using Logistic Regression</title>
		<link rel="stylesheet" type="text/css" href="css/style.css">
		<script type="text/javascript" src="js/validation.js"></script>
		<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript" src="js/jquery.tablesorter.min.js"></script>
		 <link rel="stylesheet" type="text/css" href="css/style1.css">
	    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
	    <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
	
		
		
	</head>
	<body>
		<center>
			<div id="mainPanel">

<!--  LOGO PANEL -------------------------------------------------------------------------------------------------------------------------->			

				<div id="logoPanel">
					<a href="<%= url.getString("webRoot")%>"><img alt="LRpath" src="images/logo.jpg" border="0"></a>
					<br />
					<br />
					<span class="logoTitle">Pathway Analysis using Logistic Regression</span>
					<hr>
				</div>

				
				
<!--  TOOLBAR PANEL ----------------------------------------------------------------------------------------------------------------------->			
				
						
				
<!--  RESULTS PANEL ---------------------------------------------------------------------------------------------------------------------->
				<div id="contentPanel">
						<br/><br/>
				             <span class="formText">No result found for the given parameters. Please try using other databases.</span>
				        <br/><br/>
                </div>

					
			</div>  
			</div>
		</center>
 	</body>
</html>	
