<%@ page language="java" import="java.util.*,java.io.*" pageEncoding="ISO-8859-1"%>
<%
String database = request.getParameter("db");
String directionField = request.getParameter("r");
String outFileNum = request.getParameter("g");
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-disposition", "attachment;filename=download.xls");

ResourceBundle url = ResourceBundle.getBundle("org.ncibi.resource.bundle.url");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
  </head>
  
  <body>
   <table border="1">
  	 <tr class="tableHeader">
		<td>Id</td>
		<td>name</td>
		<td>ConceptType</td>
		<td>#Genes</td>
		<td>Coeff</td>
		<td>OddsRatio</td>
		<td>P-Value</td>
		<td>FDR</td>
		<td><%= directionField %></td>
		<td>SigGenes</td>
	 </tr>
<% 
	 try
		{
			String fileInput = url.getString("resultDirectory") + "file"+ outFileNum +".txt";
			System.out.println("yes isd above " + fileInput );
			BufferedReader input = new BufferedReader(new FileReader(fileInput));
			try
			{
				String line = null;
				int count = 0;

				while ((line = input.readLine()) != null)
				{
				  if(count != 0)
				  {
					String[] token = line.split("\t");
%>
					<tr class="tableHeader">
<%				
					for (int i = 0; i < token.length; i++)
					{
						
						if(i == 1 && database.equals("external"))
						{
%>
						<td><a href="http://conceptgen.ncibi.org/core/conceptGen/explorer.jsp?conceptid=<%= token[0] %>&queryType=concept&owner=Public"><%= token[i] %></a></td>
<% 							
						}
						else if(i == 9)
						{					
%>
						<td><a href="http://www.ncbi.nlm.nih.gov/gene?term=<%= token[i] %>"><%= token[i] %></a></td>
<% 							
						}
						else					
						{
%>
						<td><%= token[i] %></td>
<% 						
						}
						

					}
%>					
					 </tr>
<%
				  }
				  count++;
				}
			}
			finally
			{
				input.close();
				out.close();
			}
		}
		catch (IOException ex)
		{
			ex.printStackTrace();
		}
%>	 
	</table>
  </body>
</html>
