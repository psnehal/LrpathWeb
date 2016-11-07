<%@ page language="java" import="java.io.*,java.util.*,java.text.*,java.math.*,org.ncibi.resource.util.*, org.ncibi.lrpath.*, org.ncibi.lrpath.config.RServerConfiguration;" %>
<jsp:useBean id="csb" scope="session" class="org.ncibi.resource.util.ClusterSessionBean" />
<%
//******************************************************************************************************************************************
// VARIABLES

ResourceBundle url = ResourceBundle.getBundle("org.ncibi.resource.bundle.url");
String clusterType = request.getParameter("clusterType");
String clusterFilterOn = request.getParameter("clusterFilterOn");
int numExpans = Integer.parseInt(request.getParameter("clusterFilterNum"));
String method = request.getParameter("distanceMatrix");
String link = request.getParameter("linkClustering");
double cutoff = Double.parseDouble(request.getParameter("clusterFilterValue"));


String[] filePath = request.getParameterValues("clusterURL");
String[] fileNames = request.getParameterValues("fileNames");

String sigvals = "";

long rnum = (Math.round(Math.random() * 1000000000));
String outFile = "cluster" + rnum;

String outFileName = url.getString("rserverOutputDirectory") + outFile + ".cdt";
ArrayList<HashMap<String, Double>> datacheck = new ArrayList<HashMap<String, Double>>();
ArrayList<HashMap<String, Double>> sigcheck = new ArrayList<HashMap<String, Double>>();


//******************************************************************************************************************************************
// PARSE FILES

for(int i=0; i<filePath.length; i++)
{
	String f = filePath[i];
	HashMap<String, Double> tdata = new HashMap<String, Double>();
	HashMap<String, Double> sdata = new HashMap<String, Double>();
	
	try
	{
		String[] fileName = f.split("/");
		String fileInput = url.getString("resultDirectory") + fileName[fileName.length - 1];
		fileInput = fileInput.trim();

		BufferedReader input = new BufferedReader(new FileReader(fileInput));
		String line = null;
		int count = 0;
		
		while ((line = input.readLine()) != null)		
		{	
			if(count != 0)
			{
				String[] token = line.split("\t");
	
				double coeff = Double.parseDouble(token[3]);
				double oddsRatio = Double.parseDouble(token[4]);
				double pval = Double.parseDouble(token[5]);
				double fdr = Double.parseDouble(token[6]);
				double value = 0;
				String conceptName = token[0] + " | " + token[1];
				String direction = token[7];									
				
				if(clusterType.equals("log10"))
				{			
					value = (Math.log((pval)/Math.log(10)) * -1);
					if(direction.equals("up") || direction.equals("down"))
					{
						if(coeff < 0)
						{
							value = value * -1;
						}
					}
				}
				else
				{
					value = (Math.log(oddsRatio)/Math.log(2));					
				}
					
				
				tdata.put(conceptName,value);
				if(clusterFilterOn.equals("fdr"))
				{
					sdata.put(conceptName,fdr);
				}
				else
				{
					sdata.put(conceptName,pval);
				}
			}
			count++;
		}
		input.close();
		datacheck.add(tdata);
		sigcheck.add(sdata);
		

	}
	catch (Exception e)
	{
		System.out.println(e);
	}

}

//******************************************************************************************************************************************
//DATA VALIDATION

HashMap<String, Double> c1 = new HashMap<String, Double>();
String rowNames = "";
String columnNames = "";
String data = "";
int dataCount = 0;

if(datacheck.size() > 0)
{
	c1 = datacheck.get(0);
}

System.out.println("Datache size"+datacheck.size());
for (int i=1; i<datacheck.size(); i++) 
{
	HashMap<String, Double> c2 = datacheck.get(i);
	HashMap<String, Double> tmp = new HashMap<String, Double>();
		
	for (String k  : c1.keySet())
	{
		if(c2.containsKey(k))
		{
			tmp.put(k, 0.0);
		}	
	}
	c1 = tmp;
}


for (String k  : c1.keySet())
{
	rowNames += "," + "\"" + k + "\"";
	for (int i=0; i<datacheck.size(); i++)
	{
		HashMap<String, Double> c2 = datacheck.get(i);
		HashMap<String, Double> s2 = sigcheck.get(i);
		//System.out.println("c2 is "+ c2 +"k is "+ k);
		
		if(c2.containsKey(k))
		{
			double val = c2.get(k);
			double sig = s2.get(k);
			//System.out.println("val "+ val);
			data += "," + val;
			sigvals += "," + sig;
			dataCount++;
		}
	}
}

for(int j=0; j<fileNames.length; j++)
{
	columnNames += ", \"" + fileNames[j].trim() + "\"";
}

rowNames = rowNames.replaceFirst(",", "");
data = data.replaceFirst(",", "");
sigvals = sigvals.replaceFirst(",", "");
columnNames = columnNames.replaceFirst(",", "");

System.out.println("Data size "+data.length()+ "data ");
if(dataCount > 6000)
{
	csb.setColumnNames(columnNames);
	csb.setColumnSize(fileNames.length);
	csb.setCutoff(cutoff);
	csb.setData(data);
	csb.setLink(link);
	csb.setMethod(method);
	csb.setNumExpans(numExpans);
	csb.setOutputFilePath(outFileName);
	csb.setRowNames(rowNames);
	csb.setRowSize(c1.size());
	csb.setSigvals(sigvals);
	csb.setOutFile(outFile);
	%>
		<jsp:forward page="status.jsp" />
	<% 
}


//******************************************************************************************************************************************
// RUN ANALYSIS
System.out.println("calling rserver");
LRPathRServer rserver = new LRPathRServer("localhost", RServerConfiguration.rserverPort());
System.out.println("done rserver");
LRPathHCluster analysis = new LRPathHCluster(rserver);

analysis.run(sigvals, cutoff, numExpans, columnNames, fileNames.length, rowNames, data, c1.size(), method, link, outFileName);


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





