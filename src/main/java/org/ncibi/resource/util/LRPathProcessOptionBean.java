package org.ncibi.resource.util;

public class LRPathProcessOptionBean {

	private LRPathProcessOption option = LRPathProcessOption.LRPATH_ONLY;
	
	// NOTE: do not change these values without also changes JS and JSP files (main.jsp, action.jsp, js/validate.js)
	public String FORM_OPTION_NAME="thinkBackOption";
	public String FORM_OPTION_LRPATH_ONLY = "LRPath.only";
	public String FORM_OPTION_THINKBACK_GENE_APPEARANCE_FREQUENCY = "ThinkBack.Gene.Appearance.Frequency";
	public String FORM_OPTION_THINKBACK_DENSITY_ANALYSIS = "ThinkBack.Density.Analysis";

	public LRPathProcessOption getOption() {
		return option;
	}

	public void setOption(LRPathProcessOption option) {
		this.option = option;
	}
	
	public LRPathProcessOption makeLRPathProcessOptionFromParameter(String parameter){
		if (parameter == null) return LRPathProcessOption.LRPATH_ONLY;;
		if (parameter.isEmpty()) return LRPathProcessOption.LRPATH_ONLY;;
		if (parameter.equals(FORM_OPTION_LRPATH_ONLY)) return LRPathProcessOption.LRPATH_ONLY;;
		if (parameter.equals(FORM_OPTION_THINKBACK_DENSITY_ANALYSIS)) return LRPathProcessOption.THINKBACK_DENSITY_ANALYSIS;
		if (parameter.equals(FORM_OPTION_THINKBACK_GENE_APPEARANCE_FREQUENCY)) return LRPathProcessOption.THINKBACK_GENE_APPEARANCE_FREQUENCY;
		return LRPathProcessOption.LRPATH_ONLY;
	}
	
}
