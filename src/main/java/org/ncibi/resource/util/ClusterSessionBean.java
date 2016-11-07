package org.ncibi.resource.util;

public class ClusterSessionBean
{
	private double cutoff;
	private String columnNames;
	private String rowNames;
	private String data;
	private String sigvals;
	private String method;
	private String link;
	private String outputFilePath;
	private String outFile;
	private int rowSize;
	private int columnSize;
	private int numExpans;

	public String getOutFile()
	{
		return outFile;
	}

	public void setOutFile(String outFile)
	{
		this.outFile = outFile;
	}

	public double getCutoff()
	{
		return cutoff;
	}

	public void setCutoff(double cutoff)
	{
		this.cutoff = cutoff;
	}

	public String getColumnNames()
	{
		return columnNames;
	}

	public void setColumnNames(String columnNames)
	{
		this.columnNames = columnNames;
	}

	public String getRowNames()
	{
		return rowNames;
	}

	public void setRowNames(String rowNames)
	{
		this.rowNames = rowNames;
	}

	public String getData()
	{
		return data;
	}

	public void setData(String data)
	{
		this.data = data;
	}

	public String getSigvals()
	{
		return sigvals;
	}

	public void setSigvals(String sigvals)
	{
		this.sigvals = sigvals;
	}

	public String getMethod()
	{
		return method;
	}

	public void setMethod(String method)
	{
		this.method = method;
	}

	public String getLink()
	{
		return link;
	}

	public void setLink(String link)
	{
		this.link = link;
	}

	public String getOutputFilePath()
	{
		return outputFilePath;
	}

	public void setOutputFilePath(String outputFilePath)
	{
		this.outputFilePath = outputFilePath;
	}

	public int getRowSize()
	{
		return rowSize;
	}

	public void setRowSize(int rowSize)
	{
		this.rowSize = rowSize;
	}

	public int getColumnSize()
	{
		return columnSize;
	}

	public void setColumnSize(int columnSize)
	{
		this.columnSize = columnSize;
	}

	public int getNumExpans()
	{
		return numExpans;
	}

	public void setNumExpans(int numExpans)
	{
		this.numExpans = numExpans;
	}
}
