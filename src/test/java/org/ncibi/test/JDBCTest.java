package org.ncibi.test;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;

import org.junit.Test;
import org.ncibi.commons.db.JDBCExecuter;
import org.ncibi.lrpath.Species;

public class JDBCTest {
	private ResourceBundle sql = ResourceBundle.getBundle("org.ncibi.resource.bundle.sql");
	private HashMap<String, String> allGenes = new HashMap<String, String>();
	private HashMap<String, String> allGenesSymbol = new HashMap<String, String>();

	@Test
	public void testconnection()
	{	
		JDBCExecuter db = new JDBCExecuter(ResourceBundle.getBundle("org.ncibi.resource.bundle.database"));
		String query = sql.getString("selectAllGenesHuman");
		query = query.replaceFirst("\\?", String.valueOf(Species.toSpecies("hsa").taxid()));
		
		System.out.println(query);
		try
		{
			List<List<String>> list = db.select(query);
			
			for (List<String> gene : list)
			{
				allGenes.put(gene.get(0), gene.get(1));
				allGenesSymbol.put(gene.get(1), gene.get(0));
			}
			System.out.println(allGenes.size());
		} 
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		
		
	}
}
