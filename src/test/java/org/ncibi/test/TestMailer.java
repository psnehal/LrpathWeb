package org.ncibi.test;

import java.util.ResourceBundle;

import org.junit.Test;
import org.ncibi.resource.util.JavaMailer;

public class TestMailer
{
	@Test
	public void test()
	{
		ResourceBundle u = ResourceBundle.getBundle("org.ncibi.resource.bundle.url");
		String uid = "43535353151513";
		String url = "result.jsp?uid=" + uid + "&df=" + "Direction";
		String sender = "vmahavis@umich.edu";
		String recipient = "vmahavis@gmail.com";
		String subject = "LRpath Analysis";
		String emailMessage = "";

		emailMessage += "Hello, \n Your analyis on LRPath as been submitted. Please use the link below to check on the status of your analysis.\n\n";
		emailMessage += u.getString("webRoot") + url;

		JavaMailer mail = new JavaMailer();
		mail.sendMail(sender, recipient, subject, emailMessage);
	}
}
