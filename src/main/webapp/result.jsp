<%@ page language="java" import="javazoom.upload.*,java.util.*,java.text.*,java.math.*,org.ncibi.lrpath.*,org.ncibi.resource.util.*,org.ncibi.ws.client.*" %>
<%@ page import="org.ncibi.ws.request.RequestStatus, org.ncibi.ws.*,org.ncibi.task.TaskStatus"%>
<%
//******************************************************************************************************************************************

String uid = request.getParameter("uid");
String df = request.getParameter("df");
String db = "false";
 

NcibiLRPathService client = new NcibiLRPathService(HttpRequestType.POST);
Response<RequestStatus<List<LRPathResult>>> rs = client.lrpathStatus(uid);
TaskStatus status = rs.getResponseValue().getTask().getStatus();

ResourceBundle url = ResourceBundle.getBundle("org.ncibi.resource.bundle.url");

//******************************************************************************************************************************************

if(status == TaskStatus.DONE)
{
	System.out.println("task done");
	/*
	List<LRPathResult> result = rs.getResponseValue().getData();  	
	LRPathResult[] res = new LRPathResult[result.size()];
	System.out.println("Rna decision is "+ result.get(1).getRnaseq());
	System.out.println("filename is "+ result.get(1).getImageFilePath());
	
	
	for(int i=0; i<result.size(); i++)
	{
		//System.out.println("Concept id from the reults"+result.get(i).getConceptId());
		res[i] = result.get(i);
	}
	
	Arrays.sort(res);

	String outFileNum = write.writeToFile(res, df);
	String val = String.valueOf(res.length);
	String rnaseq = result.get(1).getRnaseq();
	*/
	System.out.println("1");
	List<LRPathResult> result = rs.getResponseValue().getData();	
	String val = String.valueOf(result.get(0).getNumUniqueGenes());
	String rnaseq = result.get(0).getRnaseq();
	String outFileNum = result.get(0).getResultFilePath();
	System.out.println("result.get(0).getImageFilePath()" + outFileNum);
	System.out.println("2");
	System.out.println("rnaseq decision :" + rnaseq);
	System.out.println("Warning from executor decision :" + result.get(0).getStatus().length());
	
	 String warning = result.get(0).getStatus();
	 if(warning.length() > 4)
	 {
		 
		 warning = warning.replace("Done", "Error from the Database:");
		 
	 }
	 
	String viewurl = "";
	if(rnaseq.equals("yes"))
	{
		System.out.println("3");	
		 viewurl = "viewRna.jsp?db=" + db + "&r=" + df + "&f=1&t=" + outFileNum + "&s=" + val + "&fp=" + result.get(0).getImageFilePath().replace("/usr/share/tomcat6/webapps/ROOT/result/", "")+"&c=0&w="+warning;
		
		
	}
	else if(rnaseq.equals("zero"))
	{
		System.out.println("4");
		
		 viewurl = "viewNoResult.jsp?db=" + db + "&r=" + df + "&f=1&t=" + outFileNum + "&s=" + val + "&fp=" + result.get(0).getImageFilePath().replace("/usr/share/tomcat6/webapps/ROOT/result/", "")+"&c=0&w="+warning;
		
		
	}
	else
	{
		System.out.println("5");
		 viewurl = "view.jsp?db=" + db + "&r=" + df + "&f=1&t=" + outFileNum + "&s=" + val + "&c=0&w="+warning;
		
	}

	response.sendRedirect(viewurl);	
	
}
else
{
	System.out.println("6");
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
						<a href="<%= url.getString("webRoot")%>"><img alt="LRpath" src="images/logo.jpg" border="0"></a>
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
							Your analysis status is : <%= status.toString() %>. Please check back using this link
					    	<br>
					    	<br>
					    	<a href="<%= url.getString("webRoot") %>/result.jsp?uid=<%= uid %>&df=<%= df %>">
					    	<%= url.getString("webRoot") %>/result.jsp?uid=<%= uid %>&df=<%= df %></a>
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
<%	
}
%>