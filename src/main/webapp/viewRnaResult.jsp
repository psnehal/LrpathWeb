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


String filepath="";
try
{
    database = request.getParameter("db");
    directionField = request.getParameter("r");
	filter = Double.parseDouble(request.getParameter("f"));
	outFileNum = request.getParameter("t");
	cursor = Integer.parseInt(request.getParameter("c"));
	resultSize = Integer.parseInt(request.getParameter("s"));
	filepath=request.getParameter("fp");
}
catch (NullPointerException e){}
System.out.println("in view"+filepath );
ResourceBundle url = ResourceBundle.getBundle("org.ncibi.resource.bundle.url");
NumberFormat formatter = new DecimalFormat();
formatter = new DecimalFormat("0.####E0");
StringBuffer html = new StringBuffer();
int count = 0;
int navsize = 100;
int setsize = navsize + cursor;
String imageFile = "result/"+filepath;
String mainPage = "viewRna.jsp?db=" + database + "&r=" + directionField + "&f=1&t=" + outFileNum + "&s=" + resultSize + "&fp=" + filepath+ "&c=0";


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
							for (int j = 1; j < 21; j++)
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
		 <link rel="stylesheet" type="text/css" href="css/style1.css">
	    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
	    <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
	
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
 <!--  TABS PANEL --------------------------------------------------------------------------------------------------------------------------->				
				
	<table id="result">
	<thead>
	<tr class="tableHeader">
	<div id="tabsF">
	    <ul>
			
			<li><a href="<%=mainPage %>"><span> &nbsp;Results &nbsp;</span></a></li>
			<li><a href="#tab1"><span> &nbsp;Plots &nbsp;</span></a></li>
			
	     </ul>
	</div>
	</tr>
	</thead>
	</table>                      

				
				
<!--  TOOLBAR PANEL ----------------------------------------------------------------------------------------------------------------------->			
				
						
				
<!--  RESULTS PANEL ---------------------------------------------------------------------------------------------------------------------->
			<div id="contentPanel">
					<div id="#tab1">
					<span class="text">
					Plot showing relationship between read count and -log10(p-values).  Each point represents 25 genes.  
					The red line is the spline fit between read count and -log10(p-value).  The spline is used to 
					calculate weights when testing for enrichment of gene sets.
					<br/>
					Interpretation:  If the fitted line appears flat, this indicates there is little to no bias due 
					to read count level and any alternative enrichment test may be used. The more the fitted line shows
					 a strong relationship between read count and significance, the more benefit using RNA-Enrich adds. 
					 Using an alternative method when a strong relationship exists may lead to biased and/or less powerful gene 
					 set enrichment results. 
					</span>
					<center> <img src="<%= imageFile %>" alt="Rna Seq data"></center>									
					</div>
					
			</div>  
			</div>
		</center>
 	</body>
</html>	
