package org.ncibi.resource.util;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;

import org.ncibi.commons.db.JDBCExecuter;
import org.ncibi.lrpath.Species;

public class CopyOfDataValidatorOriginal
{
	private boolean isDataValid = true;
	private boolean isCompleteMatch = true;
	private HashMap<String, String> errorMessage;
	private IdentifierType isGeneId;

	private double[] sigvals;
	private double[] direction;
	private String[] identifiers;

	private ArrayList<String> unMatchedGenes = new ArrayList<String>();
	private HashMap<String, String> matchedGenes = new HashMap<String, String>();
	private HashMap<String, String> allGenes = new HashMap<String, String>();
	private HashMap<String, String> allGenesSymbol = new HashMap<String, String>();

	private ArrayList<String> genes = new ArrayList<String>();
	private HashMap<String, String> geneSigval = new HashMap<String, String>();
	private HashMap<String, String> geneDirection = new HashMap<String, String>();

	private JDBCExecuter db = new JDBCExecuter(ResourceBundle.getBundle("org.ncibi.resource.bundle.database"));
	private ResourceBundle sql = ResourceBundle.getBundle("org.ncibi.resource.bundle.sql");

	public CopyOfDataValidatorOriginal()
	{
		errorMessage = new HashMap<String, String>();
	}

	public CopyOfDataValidatorOriginal(String filePath, String delimiter, boolean headerOffset, String isDirection, String species, String isGeneId)
	{
		this.isGeneId = IdentifierType.toIdentifierType(isGeneId);
		errorMessage = new HashMap<String, String>();
		validate(filePath, delimiter, headerOffset, isDirection, species);
		storeData(isDirection);
	}

	private void storeData(String isDirection)
	{
		identifiers = new String[matchedGenes.size()];
		sigvals = new double[matchedGenes.size()];
		if (isDirection.equals("true"))
		{
			direction = new double[matchedGenes.size()];
		}
		int i = 0;
		String geneid = "";

		for (String key : matchedGenes.keySet())
		{
			geneid = matchedGenes.get(key);
			identifiers[i] = geneid;
			sigvals[i] = Double.parseDouble(geneSigval.get(geneid));
			if (isDirection.equals("true"))
			{
				direction[i] = Double.parseDouble(geneDirection.get(geneid));
			}
			else
			{
				direction = new double[0];
			}
			i++;
		}
	}

	private void downloadGeneData(String species) throws SQLException
	{
		String query = sql.getString("selectAllGenes");

		if (species.equals("hsa"))
		{
			query = sql.getString("selectAllGenesHuman");
		}

		query = query.replaceFirst("\\?", String.valueOf(Species.toSpecies(species).taxid()));

		List<List<String>> list = db.select(query);
		for (List<String> gene : list)
		{
			allGenes.put(gene.get(0), gene.get(1));
			allGenesSymbol.put(gene.get(1), gene.get(0));
		}
	}

	private void validate(String filePath, String delimiter, boolean headerOffset, String isDirection, String species)
	{
		try
		{
			downloadGeneData(species);
			FileInputStream fstream = new FileInputStream(filePath);
			DataInputStream in = new DataInputStream(fstream);
			BufferedReader br = new BufferedReader(new InputStreamReader(in));
			String strLine;

			int lineNum = 0;

			if (headerOffset)
			{
				lineNum = 0;
			}

			while ((strLine = br.readLine()) != null)
			{
				if (lineNum != 0)
				{
					String[] value = strLine.split(delimiter);
					String geneid = validateGene(value[0], species);
					if (!geneid.equals("NULL"))
					{
						validateSignalValue(geneid, value[1]);
						if (isDirection.equals("true"))
						{
							validateDirectionValue(geneid, value[2]);
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
				if (allGenesSymbol.containsKey(gene))
				{
					geneid = allGenesSymbol.get(gene);
					matchedGenes.put(gene, geneid);
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

	public String[] getIdentifiers()
	{
		return identifiers;
	}

	public void setIdentifiers(String[] identifiers)
	{
		this.identifiers = identifiers;
	}
}
