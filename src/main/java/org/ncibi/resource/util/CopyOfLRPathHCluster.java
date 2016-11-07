package org.ncibi.resource.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import org.ncibi.lrpath.LRPathRServer;
import org.rosuda.REngine.REXPMismatchException;

public final class CopyOfLRPathHCluster
{
	private final LRPathRServer rserver;

	public CopyOfLRPathHCluster(LRPathRServer rserver)
	{
		this.rserver = rserver;
	}

	public void run(String sigvals, double cutoff, int numExpans, String columnNames, int columnSize, String rowNames, String data,
			int rowSize, String method, String link, String outputFilePath) throws REXPMismatchException, IOException
	{

		
		
		File file =new File("log.txt");
		FileWriter fileWritter = new FileWriter("log.txt",true);
        BufferedWriter bufferWritter = new BufferedWriter(fileWritter);
      
        bufferWritter.write("numExpans  " + numExpans +"\n");
		bufferWritter.write("cutoff  " + cutoff +"\n");
		bufferWritter.write("sigvals " + sigvals +"\n");

		bufferWritter.write("method " + method +"\n");
		bufferWritter.write("link " + link+"\n");
		bufferWritter.write("data " + data +"\n");

		bufferWritter.write("rowSize " + rowSize +"\n");
		bufferWritter.write("columnSize " + columnSize +"\n");

		bufferWritter.write("rowNames " + rowNames +"\n");
		bufferWritter.write("columnNames " + columnNames +"\n");

		bufferWritter.write("outputFilePath " + outputFilePath +"\n") ;
  

        bufferWritter.write("Done");
		
    bufferWritter.write("sigvals2<- matrix(c(" + sigvals + "),nrow=" + rowSize + ",ncol=" + columnSize
				+ ",byrow=TRUE, dimnames = list(c(" + rowNames + "), c(" + columnNames + ")))"+ "\n");
    System.out.println("sigvals2<- matrix(c(" + sigvals + "),nrow=" + rowSize + ",ncol=" + columnSize
			+ ",byrow=TRUE, dimnames = list(c(" + rowNames + "), c(" + columnNames + ")))"+ "\n");
    
    bufferWritter.write("********************************************************************************"+"\n");
		rserver.voidEvalRCommand("library(ctc)");
		rserver.voidEvalRCommand("sigvals2<- matrix(c(" + sigvals + "),nrow=" + rowSize + ",ncol=" + columnSize
				+ ",byrow=TRUE, dimnames = list(c(" + rowNames + "), c(" + columnNames + ")))");
		
		bufferWritter.write("satisfy<- which(sigvals2 < " + cutoff + ")"+"\n");
		bufferWritter.write("********************************************************************************"+"\n");
		rserver.voidEvalRCommand("satisfy<- which(sigvals2 < " + cutoff + ")");
		
		bufferWritter.write("criteria<-matrix(0, nrow=" + rowSize + ", ncol=" + columnSize + ", byrow=T)"+"\n");
		bufferWritter.write("********************************************************************************"+"\n");
		rserver.voidEvalRCommand("criteria<-matrix(0, nrow=" + rowSize + ", ncol=" + columnSize + ", byrow=T)");
		
		bufferWritter.write("criteria[satisfy] <- 1"+"\n");
		bufferWritter.write("********************************************************************************"+"\n");
		rserver.voidEvalRCommand("criteria[satisfy] <- 1");
		
		bufferWritter.write("mdat <- matrix(c(" + data + "), nrow = " + rowSize + ", ncol=" + columnSize
				+ ", byrow=TRUE,  dimnames = list(c(" + rowNames + "), c(" + columnNames + ")))" +"\n");
		bufferWritter.write("********************************************************************************" +"\n");
		rserver.voidEvalRCommand("mdat <- matrix(c(" + data + "), nrow = " + rowSize + ", ncol=" + columnSize
				+ ", byrow=TRUE,  dimnames = list(c(" + rowNames + "), c(" + columnNames + ")))");
		
		bufferWritter.write("mdat2 <- mdat[rowSums(criteria) >= " + numExpans + ", ]"+"\n");
		bufferWritter.write("********************************************************************************"+"\n");
		rserver.voidEvalRCommand("mdat2 <- mdat[rowSums(criteria) >= " + numExpans + ", ]");
		
		bufferWritter.write("hclust2treeview(mdat2, file=\"" + outputFilePath + "\" , method=\"" + method + "\" , link=\"" + link
				+ "\")"+"\n");
		bufferWritter.write("********************************************************************************"+"\n");
		rserver.voidEvalRCommand("hclust2treeview(mdat2, file=\"" + outputFilePath + "\" , method=\"" + method + "\" , link=\"" + link
				+ "\")");
	      bufferWritter.close();
	}
}
