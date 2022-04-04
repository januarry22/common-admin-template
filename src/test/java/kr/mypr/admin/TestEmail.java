package kr.mypr.admin;

import static org.junit.Assert.assertEquals;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.junit.Test;

public class TestEmail {
	
	
	@Test
	public void testEmail() throws Exception { 
		//email 전송 검증 코드 
		String USERNAME = "tls2330@naver.com";
		String PASSWORD = "rh5481rh@!";
		
		
		Properties props =  new Properties();
		props.put("mail.smtp.starttls.enable", "true");   
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.host", "smtp.naver.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");
		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(USERNAME, PASSWORD);
			}
		  });		

		Message message = new MimeMessage(session);
		String toAddr = "tlswldnjs8865@gmail.com";
		String subject = "[gonee] 문의 답변 입니다.";
		StringBuffer sendText = new StringBuffer();
	    sendText.append("<h2>[gonne] 문의 메일 답변입니다.</h2>\n");
	    sendText.append("<h2>[E-mail] : "+toAddr+"</h2>\n");
	    sendText.append("<hr/><hr/><h2>[내용] : </h2>\n<p>"+"Content"+"</p>\n");
	    String html = sendText.toString();
	    
		message.setFrom(new InternetAddress(USERNAME, toAddr));
		message.addRecipients(Message.RecipientType.TO,InternetAddress.parse(toAddr));
		message.setSubject(subject);
		message.setContent(html, "text/html;charset=UTF-8");
		Transport.send(message);
		
		assertEquals("test", "test");
	}

}
