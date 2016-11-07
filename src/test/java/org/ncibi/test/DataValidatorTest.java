package org.ncibi.test;

import java.util.Arrays;

import org.ncibi.resource.util.DataValidator;

public class DataValidatorTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		String direction = "true";
		String[] copyFrom = {"12345","2345","+","34","45","657","678"};
		String isDirection = "true";
		int lenArr = 0;
		String[] copyTo;
		if (isDirection.equals("true"))
			{
			lenArr = copyFrom.length - 3;	
			copyTo = new String[lenArr];
			System.arraycopy(copyFrom, 3, copyTo, 0, lenArr);
			}
		else
			{
				lenArr = copyFrom.length - 2;
				copyTo= new String[lenArr];
				System.arraycopy(copyFrom, 2, copyTo, 0, lenArr);
			}
		
		 System.out.println(Arrays.toString(copyTo) + "len" + copyTo.length);
		 
		 DataValidator validate = new DataValidator("/home/snehal/LrpathProd/LrpathOriginalWorking/RNA-enrich_script/atf4_WTcon_vs_WTmock_edgeR-differentialexpression_normalized_readcounts.txt","\t", false, "no", "cel", "geneid","no");	
		 System.out.println(Arrays.toString(validate.getReadcounts()));
		 System.out.println(validate.getIdentifiers().length);
	}

}
