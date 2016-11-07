package org.ncibi.resource.util;

public class WebSessionBean
{
	private String[] database;
	private String maxG;
	private String minG;
	private String oddsMax;
	private String oddsMin;
	private String sigCutoff;
	private String species;
	private String isDirection;
	private String isDBExternal;
	private String filePath;
	private String email;
	private int resultSize;
	private int[] geneids;
	private double[] sigvals;
	private double[] direction;

	public WebSessionBean(String[] database, String maxG, String minG, String oddsMax, String oddsMin, String sigCutoff, String species,
			String isDirection, String isDBExternal, String filePath, String email, int resultSize, int[] geneids, double[] sigvals,
			double[] direction)
	{
		super();
		this.database = database;
		this.maxG = maxG;
		this.minG = minG;
		this.oddsMax = oddsMax;
		this.oddsMin = oddsMin;
		this.sigCutoff = sigCutoff;
		this.species = species;
		this.isDirection = isDirection;
		this.isDBExternal = isDBExternal;
		this.filePath = filePath;
		this.email = email;
		this.resultSize = resultSize;
		this.geneids = geneids;
		this.sigvals = sigvals;
		this.direction = direction;
	}

	public String[] getDatabase()
	{
		return database;
	}

	public void setDatabase(String[] database)
	{
		this.database = database;
	}

	public String getMaxG()
	{
		return maxG;
	}

	public void setMaxG(String maxG)
	{
		this.maxG = maxG;
	}

	public String getMinG()
	{
		return minG;
	}

	public void setMinG(String minG)
	{
		this.minG = minG;
	}

	public String getOddsMax()
	{
		return oddsMax;
	}

	public void setOddsMax(String oddsMax)
	{
		this.oddsMax = oddsMax;
	}

	public String getOddsMin()
	{
		return oddsMin;
	}

	public void setOddsMin(String oddsMin)
	{
		this.oddsMin = oddsMin;
	}

	public String getSigCutoff()
	{
		return sigCutoff;
	}

	public void setSigCutoff(String sigCutoff)
	{
		this.sigCutoff = sigCutoff;
	}

	public String getSpecies()
	{
		return species;
	}

	public void setSpecies(String species)
	{
		this.species = species;
	}

	public String getIsDirection()
	{
		return isDirection;
	}

	public void setIsDirection(String isDirection)
	{
		this.isDirection = isDirection;
	}

	public String getIsDBExternal()
	{
		return isDBExternal;
	}

	public void setIsDBExternal(String isDBExternal)
	{
		this.isDBExternal = isDBExternal;
	}

	public String getFilePath()
	{
		return filePath;
	}

	public void setFilePath(String filePath)
	{
		this.filePath = filePath;
	}

	public String getEmail()
	{
		return email;
	}

	public void setEmail(String email)
	{
		this.email = email;
	}

	public int getResultSize()
	{
		return resultSize;
	}

	public void setResultSize(int resultSize)
	{
		this.resultSize = resultSize;
	}

	public int[] getGeneids()
	{
		return geneids;
	}

	public void setGeneids(int[] geneids)
	{
		this.geneids = geneids;
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

}
