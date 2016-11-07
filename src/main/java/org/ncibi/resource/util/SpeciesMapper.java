package org.ncibi.resource.util;

import java.util.HashMap;

public class SpeciesMapper {
	private static HashMap<String, String> species = new HashMap<String, String>();
	
	public static String getTaxId(String taxName)
	{
		return (String) getSpecies().get(taxName);
	}
	
	private static HashMap getSpecies()
	{
		
		//HUMAN(9606, "hsa"), MOUSE(10090, "mmu"), RAT(10116, "rno"), DROSOPHILA_MELANOGASTER(-1, "dm"), ZEBRAFISH(
	     //       -1, "dr"), CELEGANS(-1, "ce"), YEAST(-1, "sc");

		species.put("hsa","9606");
		species.put("mmu","10090");
		
		return species;
		
	}
}
