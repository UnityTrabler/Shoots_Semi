package net.user.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;

public class UserSignupProcessAction extends HttpServlet implements Action {
	private static final long serialVersionUID = 1L;

	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String receiver = req.getParameter("receiver");
		SecureRandom random = new SecureRandom();
		String verifyNum = String.valueOf(100000 + random.nextInt(900000));//인증용 난수
		String subject = "shoots email verification : " + verifyNum;
		String imgPath =  req.getServletContext().getRealPath("/img/logo.png");
		// SMTP 서버 정보 설정
		String domain = "naver.com";
		String host = "smtp."+domain;
		final String username = "kdhmm0325@"+domain; // 실제 아이디
		final String password = "won08980898A"; // 실제 비밀번호
		String sender = username;
		sendEmail(resp, host, username, password, sender, receiver, subject, imgPath, verifyNum);
		HttpSession session = req.getSession();
		session.setAttribute("verifyNum", verifyNum);
		
		System.out.println("signupProcess action");
		return null;
	}
	
	private void sendEmail(HttpServletResponse resp, String host, String username, String password, String sender, String receiver, String subject, String imgPath, String verifyNum) {
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true"); // TLS 활성화
		props.put("mail.smtp.ssl.protocols", "TLSv1.2"); // TLS 버전 지정

		// 세션 생성
		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		try {
			 // 이미지 파일을 Base64로 인코딩
	        String base64Image = encodeFileToBase64(imgPath);
	        // HTML 내용 설정
	        String htmlContent = "<h3>This is your verification code</h3>" 
	        					+"<h1>"+verifyNum+"</h1>"
	        					+"<img src = 'data:image/jpeg;base64,"+base64Image+"'/><hr>";
			// 메일 메시지 생성
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(sender)); // 보내는 사람 이름 설정
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(receiver));
			message.setSubject(subject, "UTF-8"); // 제목 설정
			message.setContent(htmlContent, "text/html; charset=UTF-8"); // 본문 내용 설정
			resp.setContentType("text/html; charset=UTF-8");
			
			// 메일 전송
			Transport.send(message);
			resp.setContentType("application/json; charset=UTF-8");
			resp.setStatus(HttpServletResponse.SC_OK);
			resp.getWriter().println("{\"message\":\"메일이 성공적으로 발송되었습니다!\"}");

		} catch (MessagingException e) {
			e.printStackTrace();
			try {
				resp.setContentType("application/json; charset=UTF-8");
				resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				resp.getWriter().println("{\"message\":\"메일 발송 중 오류가 발생했습니다: " + e.getMessage() + "\"}");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}	
	}
	
    // 파일을 Base64로 인코딩하는 메소드
    private static String encodeFileToBase64(String filePath) throws IOException {
        File file = new File(filePath);
        byte[] fileContent = new byte[(int) file.length()];
        try (FileInputStream inputStream = new FileInputStream(file)) {
            inputStream.read(fileContent);
        }
        return Base64.getEncoder().encodeToString(fileContent);
    }


}
