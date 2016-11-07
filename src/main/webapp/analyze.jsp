<%@ page language="java" import="javazoom.upload.*,java.util.*,java.text.*,java.math.*,
	org.ncibi.lrpath.*,
	org.ncibi.ws.thinkback.ThinkbackAdjustmentMethod,
	org.ncibi.ws.thinkback.LRThinkArgs,
	org.ncibi.resource.util.*,org.ncibi.ws.client.*" %>
<%@ page import="org.ncibi.ws.request.RequestStatus, org.ncibi.ws.*,org.ncibi.lrpath.LRPathArguments"%>
<jsp:useBean id="dataBean" scope="session" class="org.ncibi.lrpath.LRPathArguments" />
<jsp:useBean id="optionBean" scope="session" class="org.ncibi.resource.util.LRPathProcessOptionBean" />

<%
//******************************************************************************************************************************************
// Variable Declaration

ResourceBundle msg = ResourceBundle.getBundle("org.ncibi.resource.bundle.message");
ResourceBundle u = ResourceBundle.getBundle("org.ncibi.resource.bundle.url");
JavaMailer mail = new JavaMailer();

String sender = msg.getString("sender");
String emailMessage = msg.getString("emailMessage");

String directionField = "Enriched";

//******************************************************************************************************************************************
// Check Directional Test

if(dataBean.getDirection().length > 1)
{
	directionField = "Direction";
}

//******************************************************************************************************************************************
// Set LRPathData & Run Analysis

String uid = "null";
LRPathProcessOption option = optionBean.getOption();

if (option == LRPathProcessOption.LRPATH_ONLY) {
	NcibiLRPathService lrPathClient = new NcibiLRPathService(HttpRequestType.POST);
	Response<String> res = lrPathClient.submitLRPathRequest(dataBean);

	uid = res.getResponseValue();
	out.println(uid);
	
	
	
	
	
} else if ((option == LRPathProcessOption.THINKBACK_DENSITY_ANALYSIS) || (option == LRPathProcessOption.THINKBACK_GENE_APPEARANCE_FREQUENCY)){
	NcibiLrpathThinkService thinkBackClient = new NcibiLrpathThinkService();
	List<String> pathways = new ArrayList<String>();
	ThinkbackAdjustmentMethod method = ThinkbackAdjustmentMethod.DS;
	if (option == LRPathProcessOption.THINKBACK_GENE_APPEARANCE_FREQUENCY) method = ThinkbackAdjustmentMethod.AF;
	LRThinkArgs lrThinkArgs = new LRThinkArgs();
	lrThinkArgs.setLrpathArgs(dataBean);
	lrThinkArgs.setPathways(pathways);
	lrThinkArgs.setAdjustmentMethod(method);
	Response<String> res = thinkBackClient.submitLrpathThinkRequest(lrThinkArgs);

	uid = res.getResponseValue();
}
	System.out.println(uid);
String url = "error.jsp";
if(!uid.equals("null"))
{
	url = "status.jsp?uid=" + uid + "&df=" + directionField ;
	ChipEnrichDbConnection con = new ChipEnrichDbConnection();	
	String name =dataBean.getOutname()+";"+directionField+";"+dataBean.getRnaseq();
	String email = dataBean.getEmail();	
	con.saveUuid(name, uid,email);
	System.out.println(" Its after db connection :"  );
	
	if(!dataBean.getEmail().equals(""))
	{
		String method;
		if(dataBean.getRnaseq().equals("yes"))
		{
			method = "RNA Enrich";
		}
		else
		{
			method = "LR Path";
		}
		String subject = method+" Analysis";
		emailMessage = "Hello,\nYour "+method+" " + dataBean.getOutname() +" analysis has been submitted.. Please use the link below to check on the status of your analysis.\n\n";
		emailMessage += u.getString("webRoot") + url;
		System.out.println("sender is :"+ sender + " email id is : "+ dataBean.getEmail() + " subject  " + subject + " emailMessage  :=" + emailMessage  );
		mail.sendMail(sender, dataBean.getEmail(), subject, emailMessage);
	}
}

response.sendRedirect(url);

//******************************************************************************************************************************************
%>
