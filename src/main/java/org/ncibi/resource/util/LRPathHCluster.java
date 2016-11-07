package org.ncibi.resource.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import org.ncibi.lrpath.LRPathRServer;
import org.rosuda.REngine.REXPMismatchException;

public final class LRPathHCluster
{
	private final LRPathRServer rserver;

	public LRPathHCluster(LRPathRServer rserver)
	{
		this.rserver = rserver;
	}

	public void run(String sigvals, double cutoff, int numExpans, String columnNames, int columnSize, String rowNames, String data,
			int rowSize, String method, String link, String outputFilePath) throws REXPMismatchException, IOException
	{
		
        
    //System.out.println("sigvals2<- matrix(c(" + sigvals + "),nrow=" + rowSize + ",ncol=" + columnSize
		//	+ ",byrow=TRUE, dimnames = list(c(" + rowNames + "), c(" + columnNames + ")))"+ "\n");
		
		
		System.out.println(data.length());
    
    
		rserver.voidEvalRCommand("library(ctc)");
		System.out.println("1");
		rserver.voidEvalRCommand("sigvals2<- matrix(c(" + sigvals + "),nrow=" + rowSize + ",ncol=" + columnSize
				+ ",byrow=TRUE, dimnames = list(c(" + rowNames + "), c(" + columnNames + ")))");
		System.out.println("2");
		rserver.voidEvalRCommand("satisfy<- which(sigvals2 < " + cutoff + ")");
		System.out.println("3");
		
		rserver.voidEvalRCommand("criteria<-matrix(0, nrow=" + rowSize + ", ncol=" + columnSize + ", byrow=T)");
		
		System.out.println("4");
		rserver.voidEvalRCommand("criteria[satisfy] <- 1");
		System.out.println("5");
		rserver.voidEvalRCommand("mdat <- matrix(c(" + data + "), nrow = " + rowSize + ", ncol=" + columnSize
				+ ", byrow=TRUE,  dimnames = list(c(" + rowNames + "), c(" + columnNames + ")))");
	
		rserver.voidEvalRCommand("mdat2 <- mdat[rowSums(criteria) >= " + numExpans + ", ]");
		
		System.out.println(outputFilePath);
		rserver.voidEvalRCommand("hclust2treeview(mdat2, file=\"" + outputFilePath + "\" , method=\"" + method + "\" , link=\"" + link
				+ "\")");
		System.out.println("6");
	     
	}
}
