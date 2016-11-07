package org.ncibi.resource.util;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

import org.ncibi.lrpath.LRPathResult;

public class DataWriter
{

	public String writeToFile(LRPathResult[] obj, String directionLabel)
	{
		String directionField = directionLabel;
		String directionValue1 = "enriched";
		String directionValue2 = "depleted";
		long rnum = (Math.round(Math.random() * 1000000000));
		
		String outFileName = "file" + rnum  + ".txt";
		String outFileName2 = "download" + rnum  + ".txt";
		
		String outFile = ResourceUtil.getResultsDirectoryUrl() + outFileName;
		String outFile2 = ResourceUtil.getResultsDirectoryUrl() + outFileName2;
		
		if (directionField.equals("Direction"))
		{
			directionValue1 = "up";
			directionValue2 = "down";
		}

		try
		{
			BufferedWriter out = new BufferedWriter(new FileWriter(outFile));
			BufferedWriter out2 = new BufferedWriter(new FileWriter(outFile2));

			out.write("Id" + "\t" + "Name" + "\t" + "ConceptType" + "\t" + "#Genes" + "\t" + "Coeff" + "\t" + "OddsRatio" + "\t"
					+ "P-Value" + "\t" + "FDR" + "\t" + directionField + "\t" + "SigGenes" + "\n");
			
			out2.write("Name" + "\t" + "ConceptType" + "\t" + "#Genes" + "\t" + "Coeff" + "\t" + "OddsRatio" + "\t"
					+ "P-Value" + "\t" + "FDR" + "\t" + directionField + "\t" + "SigGenes" + "\n");

			for (int i = 0; i < obj.length; i++)
			{
				LRPathResult lrp = (LRPathResult) obj[i];
				String direc = directionValue1;
				String genes = lrp.getSigGenes().toString();
				genes = genes.replaceAll("\\[", "");
				genes = genes.replaceAll("\\]", "");

				if (lrp.getOddsRatio() < 1)
				{
					direc = directionValue2;
				}

				out.write(lrp.getConceptId() + "\t" + lrp.getConceptName() + "\t" + lrp.getConceptType() + "\t" + lrp.getNumUniqueGenes()
						+ "\t" + lrp.getCoeff() + "\t" + lrp.getOddsRatio() + "\t" + lrp.getPValue() + "\t" + lrp.getFdr() + "\t" + direc
						+ "\t" + genes + "\n");
				
				out2.write(lrp.getConceptName() + "\t" + lrp.getConceptType() + "\t" + lrp.getNumUniqueGenes()
						+ "\t" + lrp.getCoeff() + "\t" + lrp.getOddsRatio() + "\t" + lrp.getPValue() + "\t" + lrp.getFdr() + "\t" + direc
						+ "\t" + genes + "\n");
			}

			out.close();
			out2.close();
		}
		catch (IOException ex)
		{
			ex.printStackTrace();
		}

		return String.valueOf(rnum);
	}

}
