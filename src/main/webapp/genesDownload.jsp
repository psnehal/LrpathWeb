<%@ page language="java" import="java.util.*,org.ncibi.commons.db.JDBCExecuter"%> 
<%
	//**************************************************************************************************************************************

	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-disposition", "attachment;filename=Element-List.xls");

	JDBCExecuter db = new JDBCExecuter(ResourceBundle.getBundle("org.ncibi.resource.bundle.database"));
	ResourceBundle sql = ResourceBundle.getBundle("org.ncibi.resource.bundle.sql");

	//**************************************************************************************************************************************
	// HTTP Request

	String conceptId = request.getParameter("cid");
	String species = request.getParameter("s");
	String query = "";
	
	if(species.equals("9606"))
	{
		query = sql.getString("conceptGeneList");
		query = query.replaceFirst("\\?", conceptId);
	}
	else
	{
		query = sql.getString("conceptGeneListSpecies");
		query = query.replaceFirst("\\?", species);
		query = query.replaceFirst("\\?", conceptId);
	}
	
	List<List<String>> list = db.select(query);

	//**************************************************************************************************************************************
	
%>
<table border="1">
  <tr>
    <td>Gene Id</td>
    <td>Gene Symbol</td>
    <td>Gene Name</td>
  </tr>
<% 

for(int i=0; i<list.size(); i++)
{
  List<String> row = list.get(i);
%>
  <tr>
    <td><%= (String)row.get(0) %></td>
    <td><%= (String)row.get(1) %></td>
    <td><%= (String)row.get(2) %></td>
  </tr>
<% 
}
%>
</table>