<%@ page language="java" import="javazoom.upload.*,java.util.*,java.io.*,java.text.*,java.math.*,org.ncibi.lrpath.*,org.ncibi.resource.util.*" %>
<%
//******************************************************************************************************************************************
// Variable Declaration

//
double filter = 0;
String database = "external";
String directionField = "Enriched";
String outFileNum = "";
int cursor = 0;
int resultSize = 0;
String warning="";
//out.println("in view");
try
{
    database = request.getParameter("db");
    directionField = request.getParameter("r");
	filter = Double.parseDouble(request.getParameter("f"));
	outFileNum = request.getParameter("t");
	cursor = Integer.parseInt(request.getParameter("c"));
	resultSize = Integer.parseInt(request.getParameter("s"));
	warning= request.getParameter("w");
}
catch (NullPointerException e){}

ResourceBundle url = ResourceBundle.getBundle("org.ncibi.resource.bundle.url");
NumberFormat formatter = new DecimalFormat();
formatter = new DecimalFormat("0.####E0");
StringBuffer html = new StringBuffer();
int count = 0;
int navsize = 100;
int setsize = navsize + cursor;

try
{
	String fileInput = url.getString("resultDirectory") + "file"+ outFileNum +".txt";
	BufferedReader input = new BufferedReader(new FileReader(fileInput));
	String line = null;

	while ((line = input.readLine()) != null && count < setsize)
	{	
	
		if (count == 0 || (count < cursor))
		{
			count++;
		}
		else
		{
			String[] token = line.split("\t");
			//System.out.println(token[0]);
			if (Double.parseDouble(token[6]) <= filter)
			{
				count++;
				html.append("<tbody><tr>");

				for (int i = 0; i < token.length; i++)
				{
					if (i == 0){
						html.append("<td>" + token[i] + "</td>");
					}
					else if (i == 1 && database.equals("external"))
					{
						//System.out.println("Concept id "+token[0] );
						html.append("<td><a href=\"http://conceptgen.ncibi.org/core/conceptGen/explorer.jsp?conceptid=" + token[0] 
						+ "&queryType=concept&owner=Public\">" + token[i] + "</a></td>");
					}
					else if (i == 4 || i == 5 || i == 6 || i == 7)
					{
						html.append("<td>" + formatter.format(Double.parseDouble(token[i])) + "</td>");
					}
					else if (i == 9)
					{
						String [] geneid = 	token[i].split(",");
						//System.out.println(geneid.length);
						if (geneid.length < 20 )
						{
						html.append("<td><a href='http://www.ncbi.nlm.nih.gov/gene?term=" + token[i] + "'>" + token[i] +"</a></td>");
						}
						else
						{
							String Rgeneid = "";
							for (int j = 1; j < 20; j++)
							{
								Rgeneid = geneid[j] +","+ Rgeneid;
								
							}
							Rgeneid = Rgeneid+".....";
							html.append("<td><a href='http://www.ncbi.nlm.nih.gov/gene?term=" + token[i] + "'>" + Rgeneid +"</a></td>");
						}
					}
					else
					{
						html.append("<td>" + token[i] + "</td>");
					}
				}
				
				html.append("</tr></tbody>");
			}
		}
	}	
	input.close();
}
catch (Exception e)
{
	System.out.println(e);
}



//******************************************************************************************************************************************				
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>LRpath - Pathway Analysis using Logistic Regression</title>
		<link rel="stylesheet" type="text/css" href="css/style.css">
		<script type="text/javascript" src="js/validation.js"></script>
		<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript" src="js/jquery.tablesorter.min.js"></script>
		<script type="text/javascript">
  		$(document) .ready(function() {    
  			$('tbody tr' ) .hover( 
		    function(){    
		      $(this) .find(' td' ). addClass(' hover' );    
		    },  
		    function(){    
		      $(this) .find(' td' ). removeClass(' hover' ) ; 
		    } 
		  ) ; 
		});
		
		function filterData()
		{
			
			var value = document.getElementById("filter").value;
			if(value < 0 || value > 1)
			{
				alert("Filter value should be > 0 or <= 1");
			}
			else if (value == "")
			{
				alert("Filter value cannot be blank");
			}
			else
			{
				var db = document.getElementById("database").value;
				var df = document.getElementById("directionField").value;
				var outFileNum = document.getElementById("outFileNum").value;
				window.location = "view.jsp?db="+ db +"&r="+ df +"&f=" + value +"&t=" + outFileNum + "&c=0&s=" + <%= resultSize %>;
			}
		}
		
		
		</script>
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
				
				<div id="toolbarPanel">
				 <input type="hidden" id="database" value="<%= database %>" />
				 <input type="hidden" id="directionField" value="<%= directionField %>" />
				 <input type="hidden" id="outFileNum" value="<%= outFileNum %>" />
				 <% if(!warning.equals("Done")){%>    <%= warning  %> <br/>
					 <br/><% } %>
				 
				 <span class="textMediumBold">Results <%= cursor + 1 %> - <%= count - 1 %> of about <%= resultSize %>  (Results sorted by p-value <= <%= filter %>) | 
				 <%
				 //System.out.println("cursor "+ cursor + "navsize : "+navsize + "count  "+ count + "resultSize : " +resultSize);
				 if((cursor - navsize) > -1)
				 {
				  %>
				 <a href="view.jsp?db=<%= database %>&r=<%= directionField %>&f=<%= filter %>&t=<%= outFileNum %>&c=<%= (cursor - navsize) %>&s=<%= resultSize %>">&#60;Previous</a> 
				 <%
				 }
				 if(count < resultSize)
				 {
				  %>
				  <a href="view.jsp?db=<%= database %>&r=<%= directionField %>&f=<%= filter %>&t=<%= outFileNum %>&c=<%= setsize %>&s=<%= resultSize %>">Next&#62</a>
				  <%
				 }
				 System.out.println("just above the call");
				 %>
				 <br/><br/>
				 Filter result by p-value </span><input type="text" id="filter" name="filter" size="6" /><input type="button" value="Go" onclick="filterData()"><br/><br/>
 
				 <a href="javascript:mypopwin();"> How do I interpret these results?</a> | Download all results :
				 <a href="result/download<%= outFileNum %>.txt">Text</a> or <a href="result/download.jsp?db=<%= database %>&r=<%= directionField %>&g=<%= outFileNum %>">Excel</a>
				</div>				
				
<!--  RESULTS PANEL ---------------------------------------------------------------------------------------------------------------------->	
				
				<div id="contentPanel">
					<table id="result" border="1">
					 <thead>
						<tr class="tableHeader">							
							<td>Concept ID</td>
							<td>Concept Name</td>
							<td>ConceptType</td>
							<td>#Genes</td>
							<td>Coeff</td>
							<td>OddsRatio</td>
							<td>P-Value</td>
							<td>FDR</td>
							<td><%= directionField %></td>
							<td>SigGenes</td>
						</tr>
					</thead>
					 <%= html.toString() %>
					</table>
					<br /><br />
				</div>
			</div>
		</center>
 	</body>
</html>	