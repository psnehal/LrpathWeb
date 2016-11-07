package org.ncibi.resource.util;

public class LRPathCluster
{
	private String conceptName;
	private String fileName;
	private double oddsRatio;
	private double pValue;
	private double fdr;

	public String getConceptName()
	{
		return conceptName;
	}

	public void setConceptName(String conceptName)
	{
		this.conceptName = conceptName;
	}

	public String getFileName()
	{
		return fileName;
	}

	public void setFileName(String fileName)
	{
		this.fileName = fileName;
	}

	public double getOddsRatio()
	{
		return oddsRatio;
	}

	public void setOddsRatio(double oddsRatio)
	{
		this.oddsRatio = oddsRatio;
	}

	public double getpValue()
	{
		return pValue;
	}

	public void setpValue(double pValue)
	{
		this.pValue = pValue;
	}

	public double getFdr()
	{
		return fdr;
	}

	public void setFdr(double fdr)
	{
		this.fdr = fdr;
	}
}
