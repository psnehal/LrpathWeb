package org.ncibi.resource.util;


import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import org.hibernate.Session;
import org.ncibi.db.EntityManagers;
import org.ncibi.db.PersistenceSession;
import org.ncibi.db.PersistenceUnit;
import org.ncibi.db.ws.Task;
import org.ncibi.db.ws.TaskType;
import org.ncibi.hibernate.SessionProcedure;
import org.ncibi.hibernate.Sessions;
import org.ncibi.lrpath.LRPathRServer;
import org.ncibi.lrpath.config.RServerConfiguration;
import org.ncibi.task.TaskStatus;
import org.rosuda.REngine.REXPMismatchException;

public class test
{
	public static void main(String[] args) throws IOException, REXPMismatchException
	{
		
		

		ClusterSessionBean csb = new ClusterSessionBean();
		
		String clusterType = "log10";
		String clusterFilterOn = "fdr";
		int numExpans = 1;
		String method = "euclidean";
		String link = "single";
		double cutoff =0.05;


		String[] filePath = new String[] { "/home/snehal/DataFiles/cluster/c1.txt" ,"/home/snehal/DataFiles/cluster/c2.txt" ,"/home/snehal/DataFiles/cluster/c3.txt"   };
		String[] fileNames = new String[] { "c1", "c2", "c3"};

		String sigvals = "";

		long rnum = (Math.round(Math.random() * 1000000000));
		String outFile = "cluster" + rnum;
		String outFileName = "/home/snehal/DataFiles/cluster/cluster" + outFile + ".cdt";
		ArrayList<HashMap<String, Double>> datacheck = new ArrayList<HashMap<String, Double>>();
		ArrayList<HashMap<String, Double>> sigcheck = new ArrayList<HashMap<String, Double>>();


		//******************************************************************************************************************************************
		// PARSE FILES

		for(int i=0; i<filePath.length; i++)
		{
			String f = filePath[i];
			HashMap<String, Double> tdata = new HashMap<String, Double>();
			HashMap<String, Double> sdata = new HashMap<String, Double>();
			
			try
			{
				String[] fileName = f.split("/");
				String fileInput = "/home/snehal/DataFiles/cluster/" + fileName[fileName.length - 1];
				fileInput = fileInput.trim();
				//System.out.println(fileInput);
				BufferedReader input = new BufferedReader(new FileReader(fileInput));
				String line = null;
				int count = 0;
				
				while ((line = input.readLine()) != null)		
				{	
					if(count != 0)
					{
						String[] token = line.split("\t");
			
						double coeff = Double.parseDouble(token[3]);
						double oddsRatio = Double.parseDouble(token[4]);
						double pval = Double.parseDouble(token[5]);
						double fdr = Double.parseDouble(token[6]);
						double value = 0;
						String conceptName = token[0] + " | " + token[1];
						String direction = token[7];									
						
						if(clusterType.equals("log10"))
						{			
							value = (Math.log((pval)/Math.log(10)) * -1);
							if(direction.equals("up") || direction.equals("down"))
							{
								if(coeff < 0)
								{
									value = value * -1;
								}
							}
						}
						else
						{
							value = (Math.log(oddsRatio)/Math.log(2));					
						}
							
						
						tdata.put(conceptName,value);
						if(clusterFilterOn.equals("fdr"))
						{
							sdata.put(conceptName,fdr);
						}
						else
						{
							sdata.put(conceptName,pval);
						}
					}
					count++;
				}
				input.close();
				datacheck.add(tdata);
				sigcheck.add(sdata);

			}
			catch (Exception e)
			{
				System.out.println(e);
			}

		}

		//******************************************************************************************************************************************
		//DATA VALIDATION

		HashMap<String, Double> c1 = new HashMap<String, Double>();
		String rowNames = "";
		String columnNames = "";
		String data = "";
		int dataCount = 0;

		if(datacheck.size() > 0)
		{
			c1 = datacheck.get(0);
		}

		for (int i=1; i<datacheck.size(); i++) 
		{
			HashMap<String, Double> c2 = datacheck.get(i);
			HashMap<String, Double> tmp = new HashMap<String, Double>();
				
			for (String k  : c1.keySet())
			{
				if(c2.containsKey(k))
				{
					tmp.put(k, 0.0);
				}	
			}
			c1 = tmp;
		}


		for (String k  : c1.keySet())
		{
			rowNames += "," + "\"" + k + "\"";
			for (int i=0; i<datacheck.size(); i++)
			{
				HashMap<String, Double> c2 = datacheck.get(i);
				HashMap<String, Double> s2 = sigcheck.get(i);
				
				
				if(c2.containsKey(k))
				{
					//System.out.println("inside contains K"+ k);
					double val = c2.get(k);
					double sig = s2.get(k);
					data += "," + val;
					sigvals += "," + sig;
					dataCount++;
				}
			}
		}

		for(int j=0; j<fileNames.length; j++)
		{
			columnNames += ", \"" + fileNames[j].trim() + "\"";
		}

		rowNames = rowNames.replaceFirst(",", "");
		data = data.replaceFirst(",", "");
		sigvals = sigvals.replaceFirst(",", "");
		columnNames = columnNames.replaceFirst(",", "");


		if(dataCount > 6000)
		{
			csb.setColumnNames(columnNames);
			csb.setColumnSize(fileNames.length);
			csb.setCutoff(cutoff);
			csb.setData(data);
			csb.setLink(link);
			csb.setMethod(method);
			csb.setNumExpans(numExpans);
			csb.setOutputFilePath(outFileName);
			csb.setRowNames(rowNames);
			csb.setRowSize(c1.size());
			csb.setSigvals(sigvals);
			csb.setOutFile(outFile);
			
		}
		LRPathRServer rserver = new LRPathRServer("localhost",6311);
		LRPathHCluster analysis = new LRPathHCluster(rserver);
		System.out.println(sigvals.length());
		analysis.run(sigvals, cutoff, numExpans, columnNames, fileNames.length, rowNames, data, c1.size(), method, link, outFileName);

	}




	}

	

