package org.ncibi.resource.util;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;

import org.ncibi.commons.db.JDBCExecuter;
import org.ncibi.lrpath.Species;

public class DataValidator
{
	private boolean isDataValid = true;
	private boolean isCompleteMatch = true;
	private HashMap<String, String> errorMessage;
	private IdentifierType isGeneId;

	private double[] sigvals;
	private double[] direction;
	private String[] identifiers;
	private double[] readcounts;

	private ArrayList<String> unMatchedGenes = new ArrayList<String>();
	private HashMap<String, String> matchedGenes = new HashMap<String, String>();
	private HashMap<String, String> allGenes = new HashMap<String, String>();
	private HashMap<String, String> allGenesSymbol = new HashMap<String, String>();

	private ArrayList<String> genes = new ArrayList<String>();
	private HashMap<String, String> geneSigval = new HashMap<String, String>();
	private HashMap<String, String> geneDirection = new HashMap<String, String>();
	private HashMap<String, Double> geneReadCount = new HashMap<String, Double>();

	private JDBCExecuter db = new JDBCExecuter(ResourceBundle.getBundle("org.ncibi.resource.bundle.database"));
	private ResourceBundle sql = ResourceBundle.getBundle("org.ncibi.resource.bundle.sql");

	public DataValidator()
	{
		errorMessage = new HashMap<String, String>();
	}

	public DataValidator(String filePath, String delimiter, boolean headerOffset, String isDirection, String species, String isGeneId, String rnaseqtest)
	{
		this.isGeneId = IdentifierType.toIdentifierType(isGeneId);
		System.out.println("isGeneId" +isGeneId);
		errorMessage = new HashMap<String, String>();
		validate(filePath, delimiter, headerOffset, isDirection, species,rnaseqtest);
		storeData(isDirection,rnaseqtest);
	}

	private void storeData(String isDirection,String rnaseqtest)
	{
	
		identifiers = new String[matchedGenes.size()];
		sigvals = new double[matchedGenes.size()];
		if (isDirection.equals("true"))
		{
			direction = new double[matchedGenes.size()];
		}
		if (rnaseqtest.equals("yes"))
		{
			readcounts = new double[matchedGenes.size()];
		}
		int i = 0;
		String geneid = "";

		for (String key : matchedGenes.keySet())
		{
			geneid = matchedGenes.get(key);
			identifiers[i] = geneid;
			//System.out.println("geneid is" + geneid);
			sigvals[i] = Double.parseDouble(geneSigval.get(geneid));
			if (isDirection.equals("true"))
			{
				direction[i] = Double.parseDouble(geneDirection.get(geneid));
			}
			else
			{
				direction = new double[0];
			}
			if (rnaseqtest.equals("yes"))
			{
				readcounts[i] = geneReadCount.get(geneid);
			}
			else
			{
				readcounts = new double[0];
			}
			i++;
		}
		/*
		System.out.println("********************************************************************readcount*******************************************************************************");
		System.out.println(Arrays.toString(readcounts));
		System.out.println("**********************************************************************Direction*****************************************************************************");
		System.out.println(Arrays.toString(direction));
		System.out.println("***********************************************************************Sigvals****************************************************************************");
		System.out.println(Arrays.toString(sigvals));
		*/
	//	System.out.println("***********************************************************************Sigvals****************************************************************************");
		//System.out.println(Arrays.toString(identifiers));
	}

	private void downloadGeneData(String species) throws SQLException
	{
		//System.out.println("1" + species);
		String query = sql.getString("selectAllGenes");
		//System.out.println("2");
		if (species.equals("hsa"))
		{
			//System.out.println("3");
			query = sql.getString("selectAllGenesHuman");
		}
		System.out.println("4  taxid is :" + Species.toSpecies(species).taxid());
		query = query.replaceFirst("\\?", String.valueOf(Species.toSpecies(species).taxid()));		
		List<List<String>> list = db.select(query);
		System.out.println("5 list size is" + query);
		
	for (List<String> gene : list)
		{
			//System.out.println ("gene id is " + gene.get(0) + "gene symbol is"+ gene.get(1));
			allGenes.put(gene.get(0), gene.get(1));
			allGenesSymbol.put(gene.get(1), gene.get(0));
		}
	System.out.println("7: size:::" + allGenes.size());
	}

	private void validate(String filePath, String delimiter, boolean headerOffset, String isDirection, String species, String rnaseqtest)
	{
		try
		{
			System.out.println("paramaters are filepath " +filePath + " delimiter :" + delimiter + " headerOffset:  " + headerOffset + "isDirection : " + isDirection + "species :" + species+ " rnaseqtest :" +rnaseqtest);
			downloadGeneData(species);
			System.out.println("Donwload downloadGeneData");
			FileInputStream fstream = new FileInputStream(filePath);
			DataInputStream in = new DataInputStream(fstream);
			BufferedReader br = new BufferedReader(new InputStreamReader(in));
			String strLine;
			int lenArr = 0;
			String[] copyTo;
			//System.out.println("7");
			int lineNum = 0;

			if (headerOffset)
			{
				lineNum = 0;
			}

			while ((strLine = br.readLine()) != null)
			{
				if (lineNum != 0)
				{
					//System.out.println(strLine);
					String[] value = strLine.split(delimiter);
					System.out.println(value.length);
					String geneid = validateGene(value[0], species);
					
					
					if (!geneid.equals("NULL"))
					{
						validateSignalValue(geneid, value[1]);
						if (isDirection.equals("true"))
						{
							validateDirectionValue(geneid, value[2]);
							
							lenArr = value.length - 3;	
							//System.out.println(lenArr + "value length" +  value.length);
							copyTo = new String[lenArr];
							if(rnaseqtest.equals("yes"))
							{
								System.arraycopy(value, 3, copyTo, 0, lenArr);
								validateReadCount(geneid,copyTo);
								System.out.println("copied arryay " + Arrays.toString(copyTo) + Arrays.toString(value));
								
							}
						}
						else
						{
							
							lenArr = value.length - 2;
							copyTo= new String[lenArr];			
							if(rnaseqtest.equals("yes"))
							{
								System.arraycopy(value, 2, copyTo, 0, lenArr);
								validateReadCount(geneid,copyTo);
								//System.out.println("copied from no direction arryay " + Arrays.toString(copyTo));
								
							}
							
						}
						
					}
				}
				lineNum++;
			}
			
			if (matchedGenes.size() < genes.size())
			{
				isCompleteMatch = false;
				for (int i = 0; i < genes.size(); i++)
				{
					if (!matchedGenes.containsKey(genes.get(i)))
					{
						unMatchedGenes.add(genes.get(i));
					}
				}
			}

			in.close();
			if(matchedGenes.size() < 1000)
			{
				
				errorMessage.put("6", "You have input <1000 genes that have an identified annotation. Since LRpath is meant to run with all analyzed genes, the results will not be optimal. Do you want to continue?");
				
			}
			
			System.out.println("8");
		}
		catch (IOException e)
		{
			System.out.println("Error: " + e.getMessage());
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
	
	public void validateReadCount(String geneid, String [] countsArray)
	{
		Double avg;
		double sumNo = 0;
		boolean isValid = true;
		for ( int i = 0; i < countsArray.length; i++ ){
			
			try
			{
				sumNo = sumNo+ Double.parseDouble(countsArray[i]);		
				
				
			}
			catch (NumberFormatException e)
			{
				errorMessage.put("5", "Input for read counts is not valid");
				isValid = false;
				matchedGenes.remove(geneid);
			}
		}
		avg = sumNo / countsArray.length;		
		//System.out.println("avg for read count : " + Math.round(avg)+ "  sum no is : " + sumNo+ "counts array length : " +  countsArray.length);
		geneReadCount.put(geneid, avg);
		
	
				
		
	}

	public String validateGene(String gene, String species)
	{
		boolean isValid = true;
		String geneid = "NULL";

		if (isGeneId == IdentifierType.GENEID)
		{
			try
			{
				Integer.parseInt(gene);

				geneid = gene;
				genes.add(gene);
				if (species.equals("hsa") || species.equals("rno") || species.equals("mmu"))
				{
					if (allGenes.containsKey(gene))
					{
						matchedGenes.put(geneid, geneid);
					}
				}
				else
				{
					matchedGenes.put(geneid, geneid);
				}
			}
			catch (NumberFormatException e)
			{
				errorMessage.put("1", "Geneid is not valid");
				isValid = false;
			}
		}
		else if (isGeneId == IdentifierType.GENE_SYMBOL)
		{
			
			if (gene == null || gene.equals(""))
			{
				isValid = false;
				errorMessage.put("2", "Gene Symbol is not valid");
			}
			else if (gene.toLowerCase().equals("na"))
			{
				isValid = false;
				errorMessage.put("3", "Gene Symbol has NA as value");
			}
			else
			{
				genes.add(gene);
				if (allGenesSymbol.containsKey(gene.toUpperCase()))
				{
					geneid = allGenesSymbol.get(gene.toUpperCase());
					//System.out.println("geneid is :: " + geneid + "symbol is :::"+ gene.toUpperCase());
					if(!geneid.isEmpty())
					{
					matchedGenes.put(gene, geneid);
					}
				}
				else
				{
					errorMessage.put("1", "Gene Symbol is not valid");
				}
			}
		}
		else
		{
			geneid = gene;
			genes.add(gene);
			matchedGenes.put(geneid, geneid);
		}

		isDataValid = isValid;
		return geneid;
	}

	private void validateSignalValue(String geneid, String value)
	{
		boolean isValid = true;
		try
		{
			Double.parseDouble(value);
			geneSigval.put(geneid, value);
		}
		catch (NumberFormatException e)
		{
			errorMessage.put("4", "Input for signal is not valid");
			isValid = false;
			matchedGenes.remove(geneid);
		}
		isDataValid = isValid;
	}

	private void validateDirectionValue(String geneid, String value)
	{
		boolean isValid = true;
		try
		{
			Double.parseDouble(value);
			geneDirection.put(geneid, value);
		}
		catch (NumberFormatException e)
		{
			errorMessage.put("4", "Input for direction is not valid");
			isValid = false;
			matchedGenes.remove(geneid);
		}
		isDataValid = isValid;
	}

	public boolean isDataValid()
	{
		return isDataValid;
	}

	public void setDataValid(boolean isDataValid)
	{
		this.isDataValid = isDataValid;
	}

	public boolean isCompleteMatch()
	{
		return isCompleteMatch;
	}

	public void setCompleteMatch(boolean isCompleteMatch)
	{
		this.isCompleteMatch = isCompleteMatch;
	}

	public ArrayList<String> getUnMatchedGenes()
	{
		return unMatchedGenes;
	}

	public void setUnMatchedGenes(ArrayList<String> unMatchedGenes)
	{
		this.unMatchedGenes = unMatchedGenes;
	}

	public ArrayList<String> getGenes()
	{
		return genes;
	}

	public void setGenes(ArrayList<String> genes)
	{
		this.genes = genes;
	}

	public HashMap<String, String> getErrorMessage()
	{
		return errorMessage;
	}

	public void setErrorMessage(HashMap<String, String> errorMessage)
	{
		this.errorMessage = errorMessage;
	}

	public double[] getSigvals()
	{
		return sigvals;
	}

	public void setSigvals(double[] sigvals)
	{
		this.sigvals = sigvals;
	}

	public double[] getDirection()
	{
		return direction;
	}

	public void setDirection(double[] direction)
	{
		this.direction = direction;
	}

	public double[] getReadcounts() {
		return readcounts;
	}

	public void setReadcounts(double[] readcounts) {
		this.readcounts = readcounts;
	}

	public String[] getIdentifiers()
	{
		return identifiers;
	}

	public void setIdentifiers(String[] identifiers)
	{
		this.identifiers = identifiers;
	}
	

}
