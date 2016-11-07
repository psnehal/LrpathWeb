package org.ncibi.resource.util;

public enum LRPathProcessOption {

	LRPATH_ONLY("LRPath only"),
	THINKBACK_GENE_APPEARANCE_FREQUENCY("ThinkBack (with LRPath): Gene Appearance Frequency"),
	THINKBACK_DENSITY_ANALYSIS("ThinkBack (with LRPath): Density Analysis");

	private final String humanReadableString;
	
	private LRPathProcessOption(String s){
		humanReadableString = s;
	}
	
	public String toString(){
		return humanReadableString;
	}
}


