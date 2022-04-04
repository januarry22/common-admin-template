package kr.mypr.admin.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.mail.*;
import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;


@Component
public class MultiMailUtil {
	/** <code>USERNAME</code> : Gmail 전송 유저 아이디 */
	public static final String USERNAME = "gonee801@gmail.com";
	
	/** <code>PASSWORD</code> : Gmail 전송 패스워드 */
	private static final String PASSWORD = "yeqnikqxvwhxabpq";
	  @Value("#{props['mail.sendaddr']}")
	  public String sendMail;

	  @Value("#{props['mail.port']}")
	  public String port;

	  @Value("#{props['mail.host']}")
	  public String host;

	  @Value("#{props['mail.protocol']}")
	  public String protocol;

	  @Value("#{props['mail.authid']}")
	  public String authId;

	  @Value("#{props['mail.authpw']}")
	  public String authPw;

	  @Value("#{props['mail.senduser']}")
	  public String sendUser;
	  

	  private Session session;
	  String result = null;
	  
	  public String sendMail(Map<String, Object> res) {
	 	HashMap<String, Object> param = new HashMap(res);
	 	System.out.print("param :: "+param.get("email").toString());
	    // 메일 인코딩
	    final String bodyEncoding = "UTF-8"; //콘텐츠 인코딩
	    String content=param.get("content").toString();
	    String subject = "[gonee] 문의 답변 입니다.";
	    String toEmail = param.get("email").toString();
	    
	    // 메일에 출력할 텍스트
	    StringBuffer sendText = new StringBuffer();
	    sendText.append("<h2>[gonne] 문의 메일 답변입니다.</h2>\n");
	    sendText.append("<h2>[E-mail] : "+toEmail+"</h2>\n");
	    sendText.append("<hr/><hr/><h2>[내용] : </h2>\n<p>"+content+"</p>\n");
	    String html = sendText.toString();
	    // 메일 옵션 설정
	    Properties props = new Properties();   
	    props.put("mail.smtp.starttls.enable", "true");   
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
//	    props.put("mail.smtp.auth", "true");
//	    props.put("mail.smtp.host", "smtp.gmail.com");
//	    props.put("mail.smtp.starttls.enable", "true");
//		props.put("mail.smtp.port", "465");
	//    props.put("mail.transport.protocol", protocol);
	    

	    try {
	      // 메일 서버  인증 계정 설정
	      Authenticator auth = new Authenticator() {
	        protected PasswordAuthentication getPasswordAuthentication() {
	          return new PasswordAuthentication(authId, authPw);
	        }
	      };
	      
	      // 메일 세션 생성
	      Session mailSession = Session.getInstance(props, auth);
	      
	      // 메일 송/수신 옵션 설정
	      MimeMessage message = new MimeMessage(mailSession);
	      message.setFrom(new InternetAddress(sendMail));
	      message.setRecipients(RecipientType.TO, InternetAddress.parse(toEmail, false));
	      message.setSubject(subject);
	      message.setContent(html.toString(),"text/html;charset=UTF-8");
	      message.setSentDate(new Date());
	      
	      // 메일 발송
	    //  Transport.send( message );
	      
	      Transport trans = mailSession.getTransport("smtp");
	      trans.connect(authId, authPw);
	      trans.sendMessage(message, message.getAllRecipients()); 
	      trans.close();

	      result = "success";
	      System.out.print("success:::::"+result);
	    } catch ( Exception e ) {
	      e.printStackTrace();
	    }
		return result;
	}

		public String sendMailUtil(Map<String, Object> res) throws Exception {
			Properties props =  new Properties();
			props.put("mail.smtp.starttls.enable", "true");   
			props.put("mail.smtp.auth", "true");
		//	props.put("mail.smtp.host", "smtp.naver.com");
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");
			props.put("mail.smtp.ssl.protocols", "TLSv1.2");
			session = Session.getInstance(props, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(authId, authPw);
				}
			  });		

			Message message = new MimeMessage(session);
				String toAddr=res.get("email").toString();
				String subject = "[gonee] 문의 답변 입니다.";
			    StringBuffer sendText = new StringBuffer();
			    sendText.append("<h2>[gonne] 문의 메일 답변입니다.</h2>\n");
			    sendText.append("<h2>[E-mail] : "+res.get("email").toString()+"</h2>\n");
			    sendText.append("<hr/><hr/><h2>[내용] : </h2>\n<p>"+res.get("content").toString()+"</p>\n");
			    String html = sendText.toString();
			    
				message.setFrom(new InternetAddress(USERNAME,sendUser));
				message.addRecipients(Message.RecipientType.TO,InternetAddress.parse(toAddr));
				message.setSubject(subject);
				message.setContent(html, "text/html;charset=UTF-8");
				Transport.send(message);

			      result = "success";
			return result;
		}
}
