<%@ page language="java" import="javazoom.upload.*,java.io.*,java.util.*,java.text.*,java.math.*,org.ncibi.lrpath.*,org.ncibi.resource.util.*" %>
<jsp:useBean id="dataBean" scope="session" class="org.ncibi.lrpath.LRPathArguments" />
<jsp:useBean id="upBean" scope="session" class="javazoom.upload.UploadBean" />
<jsp:useBean id="optionBean" scope="session" class="org.ncibi.resource.util.LRPathProcessOptionBean" />
<%
//******************************************************************************************************************************************
System.out.println("11");        
ResourceBundle url = ResourceBundle.getBundle("org.ncibi.resource.bundle.url");
upBean.setFolderstore(url.getString("uploadDirectory"));
String filePath = url.getString("uploadDirectory");
String filePath2 = url.getString("uploadDirectory");
System.out.println("22");    
String dirPathCustom = "";
//******************************************************************************************************************************************
// Get MultipartForm and upload file

if (MultipartFormDataRequest.isMultipartFormData(request))
{
	System.out.println("33");        
	MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
	String todo = null;
	System.out.println("44");        
    String folderStore = filePath;
    System.out.println("55");        
         
    upBean.setFolderstore(folderStore);
	upBean.setOverwrite(true);
	
    if (mrequest != null) todo = mrequest.getParameter("todo");
	if ( (todo != null) && (todo.equalsIgnoreCase("upload")) )
	{
    	Hashtable files = mrequest.getFiles();
        if ( (files != null) && (!files.isEmpty()) )
        {
        	System.out.println("abaove1");        	
        	UploadFile file = (UploadFile) files.get("uploadfile");   
            filePath += file.getFileName() ;
            System.out.println("abovve2");
            upBean.store(mrequest, "uploadfile");
            System.out.println("belows");
            
            
        	UploadFile mappa = (UploadFile) files.get("uploadcustomfile"); 
        	System.out.println("File path is for custom file   [ "+  mappa );
		  	dirPathCustom= filePath2+mappa.getFileName() ;
		  	File fileM = new File(dirPathCustom);
        	System.out.println("File path is for custom file   [ "+dirPathCustom+ " ] " );
        	dataBean.setCustomfile(dirPathCustom);
        	upBean.store(mrequest, "uploadcustomfile");
            
            
         }
         else
         {
         	System.out.println("<li>No uploaded files");
         }
	}
    else
    { 
    	out.println("<BR> todo="+todo);
    }
	
	//******Outpath Setting for bed file************************************************************************************************************************************	

		
	
         
				
		
		
          
    String[] database = mrequest.getParameterValues("database");
   
    String isDirection = mrequest.getParameter("isDirection");    
    String dataBase = "";

    boolean addedFirstItem = false;
    for(int i=0; i<database.length; i++)
    {
        if ("GO".equals(database[i]))
        {
            continue;
        }

    	if(! addedFirstItem)
    	{
            dataBase += database[i];
            addedFirstItem = true;
    	}
    	else
    	{
    		dataBase += "," + database[i];
    	}
    }
    
//    String processOption = mrequest.getParameter(optionBean.FORM_OPTION_NAME);
	String processOption = optionBean.FORM_OPTION_LRPATH_ONLY;
    optionBean.setOption(optionBean.makeLRPathProcessOptionFromParameter(processOption));
    dataBean.setDatabase(dataBase);
    dataBean.setMaxg(Integer.parseInt(mrequest.getParameter("maxG")));
    dataBean.setMing(Integer.parseInt(mrequest.getParameter("minG")));
    dataBean.setOddsmax(Double.parseDouble(mrequest.getParameter("oddsMax")));
    dataBean.setOddsmin(Double.parseDouble(mrequest.getParameter("oddsMin")));
    dataBean.setSigcutoff(Double.parseDouble(mrequest.getParameter("sigCutoff")));
    dataBean.setSpecies(mrequest.getParameter("species"));
    dataBean.setEmail(mrequest.getParameter("email"));    
    String outname= mrequest.getParameter("outname");
    String rnaseqtest="";
    String avgread="";
    if(outname != null)
    {
    	outname= mrequest.getParameter("outname");
    }
    else
    {
    	outname= "lrpath";
    }
    dataBean.setOutname(outname);
   
    String methods = mrequest.getParameter("methods");
    if(methods.equals("lrpath"))
    {
    	
    	rnaseqtest ="no";
    	avgread= "no";
    	
    }
    else if(methods.equals("rnaenrich"))
    {
    	rnaseqtest ="yes";
    	avgread= "yes";
    	
    }
    else if(methods.equals("randomsets"))
    {
    	rnaseqtest ="yes";
    	avgread= "no";
    	
    }
    	
    
    
    dataBean.setRnaseq(rnaseqtest);
    dataBean.setAvgread(avgread);
   
   
    System.out.println("OutName is " + outname);
    System.out.println("rnaseqtest" + rnaseqtest);
    System.out.println("avgread" + avgread);
    dataBean.setAvgread(avgread);
    dataBean.setEmail(mrequest.getParameter("email"));

    String isgeneid = mrequest.getParameter("isGeneId");
   
		DataValidator validate = new DataValidator(filePath,"\t", false, isDirection, dataBean.getSpecies(), isgeneid,rnaseqtest);		
		dataBean.setDirection(validate.getDirection());
		dataBean.setIdentifiers(validate.getIdentifiers());
		dataBean.setSigvals(validate.getSigvals());
		dataBean.setReadcount(validate.getReadcounts());
		
		//System.out.println("From action. jsp"+validate.getReadcounts().length);
   
	
//******************************************************************************************************************************************
	
	if(dataBean.getSpecies().equals("dme") || dataBean.getSpecies().equals("dre") || dataBean.getSpecies().equals("cel") || dataBean.getSpecies().equals("sce"))
	{
	%>
		<jsp:forward page="analyze.jsp" />
	<%
	}
	else if((!validate.isDataValid()) || (!validate.isCompleteMatch()))
	{
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
				    <center>
				    <table border="0">
				    	<tr>
				    		<td>	 			
				    		<%
				    		HashMap<String, String> errorMessage = validate.getErrorMessage();
				    		if(validate.getUnMatchedGenes().size() > 0)
				    		{
				    			%>
			    					<span class="textTitle"><%= validate.getUnMatchedGenes().size() %> of <%= validate.getGenes().size() %> Genes not matched</span>
			    			    <% 
				    		}
				    		%>
				    			<br/><span class="textTitle">Reasons for genes not matching:</span>
				    			<ul> 
				    		<% 
				    		for(String key : errorMessage.keySet())
				    		{
				    			%>
				    				<li><span class="textTitle"><%= errorMessage.get(key) %></span></li>
				    			<% 
				    		}
				    		%>
				    		 	</ul>
				    		</td>
				    	</tr>
				    	<tr>
				    		<td><textarea cols="35" rows="25"><%
					for(int i=0; i<validate.getUnMatchedGenes().size(); i++)
					{
%><%= validate.getUnMatchedGenes().get(i) %>
<%}%></textarea></td>
				    	</tr>
				    </table>
				    <br/><br />
				    <input type="button" value="Back" onclick="history.go(-1)">
				    <input type="button" value="Continue" onclick="continueAnalysis()">	
				    <br/><br />	
					</center>
					<hr>
				</div>
			</div>
		</center>
 	</body>
</html>	
<%
	}
	else
	{
	%>
		<jsp:forward page="analyze.jsp" />
	<%
	}
}

%>




