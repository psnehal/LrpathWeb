package org.ncibi.resource.util;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Vector;

import org.ncibi.lrpath.LRPathArguments;


public class LRPathParser {
	
	public LRPathArguments fileParser(String filePath, String delimiter, boolean headerOffset, boolean isDirection)
	{
		LRPathArguments data = new LRPathArguments();
		
		try
		{		
			FileInputStream fstream = new FileInputStream(filePath);
			DataInputStream in = new DataInputStream(fstream);
			BufferedReader br = new BufferedReader(new InputStreamReader(in));
			String strLine;
			
			Vector<String> g = new Vector<String>();
			Vector<String> s = new Vector<String>();
			Vector<String> d = new Vector<String>();
			
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
					
					if(isDirection)
					{

						if (value[0] != null && value[1] != null && value[0].matches("\\d+") && value[1].matches("-?\\d+(.\\d+)?")
								&& value[2].matches("-?\\d+(.\\d+)?"))
						{
							g.add(value[0]);
							s.add(value[1]);
							d.add(value[2]);
						}
					}
					else
					{
						if (value[0] != null && value[1] != null && value[0].matches("\\d+") && value[1].matches("-?\\d+(.\\d+)?"))
						{
							g.add(value[0]);
							s.add(value[1]);
						}
					}

				}
				lineNum++;
			}
			
			int[] geneids = new int[g.size()];
			double[] sigvals = new double[g.size()];
			double[] direction = new double[0];


			if(isDirection)
			{
				direction = new double[g.size()];
				for(int i=0; i<g.size(); i++)
				{
					geneids[i] = Integer.parseInt(g.get(i));
					sigvals[i] = Double.parseDouble(s.get(i));
					direction[i] = Double.parseDouble(d.get(i));
				}
			}
			else
			{
				for(int i=0; i<g.size(); i++)
				{
					geneids[i] = Integer.parseInt(g.get(i));
					sigvals[i] = Double.parseDouble(s.get(i));
				}
			}
			
			data.setGeneids(geneids);
			data.setSigvals(sigvals);
			data.setDirection(direction);

			in.close();
		}
		catch (IOException e)
		{
			System.out.println("Error: " + e.getMessage());
		}

		return data;
	}
}
