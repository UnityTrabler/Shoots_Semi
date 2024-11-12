package net.pay.action;

import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.pay.db.PaymentBean;
import net.pay.db.PaymentDAO;
import net.pay.db.RefundDAO;

public class PayRefundServlet implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String paymentId = req.getParameter("paymentId");
        int buyerId = Integer.parseInt(req.getParameter("buyerId"));
        int matchId = Integer.parseInt(req.getParameter("matchId"));

        PaymentDAO dao = new PaymentDAO();
        PaymentBean payment = dao.getPaymentById(paymentId);

        if (payment != null && payment.getBuyer() == buyerId) {

            String impUid = payment.getImp_uid();
            String reason = "환불 요청";
            
            boolean refundSuccess = callAimpotRefundAPI(impUid, reason, paymentId, payment, dao);

            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("status", refundSuccess ? "SUCCESS" : "FAIL");
            jsonResponse.addProperty("message", refundSuccess ? "환불이 완료되었습니다." : "환불 처리에 실패했습니다.");

            resp.setContentType("application/json");
            resp.getWriter().write(jsonResponse.toString());
        } else {
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("status", "FAIL");
            errorResponse.addProperty("message", "잘못된 요청입니다.");

            resp.setContentType("application/json");
            resp.getWriter().write(errorResponse.toString());
        }

        return null;
    }
	
	 private boolean callAimpotRefundAPI(String impUid, String reason, String paymentId, PaymentBean payment, PaymentDAO dao) {
	       
	        String impKey = "4374671001417615";  
	        String impSecret = "ukuBMPxlLnuayHqeO6MTTUy82qMDLGHAzpQUsoLJyPsK8xUkqw5JzIewNqgI7BlCJ8NFNcRckg9YPpFE";  

	        try {
	            URL url = new URL("https://api.iamport.kr/users/getToken");

	            JsonObject authData = new JsonObject();
	            authData.addProperty("imp_key", impKey);
	            authData.addProperty("imp_secret", impSecret);

	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	            conn.setRequestMethod("POST");
	            conn.setDoOutput(true);
	            conn.setRequestProperty("Content-Type", "application/json");
	            conn.getOutputStream().write(authData.toString().getBytes());

	            InputStreamReader in = new InputStreamReader(conn.getInputStream());
	            
	            char[] buffer = new char[1024];
	            int length;
	            
	            StringBuilder response = new StringBuilder();
	            
	            while ((length = in.read(buffer)) != -1) {
	                response.append(buffer, 0, length);
	            }
	            
	            JsonObject responseJson = new com.google.gson.JsonParser().parse(response.toString()).getAsJsonObject();
	            String accessToken = responseJson.getAsJsonObject("response").get("access_token").getAsString();

	            URL refundUrl = new URL("https://api.iamport.kr/payments/cancel");

	            JsonObject refundData = new JsonObject();
	            refundData.addProperty("imp_uid", impUid);  
	            refundData.addProperty("reason", reason);   
	            refundData.addProperty("amount", payment.getAmount()); 

	            HttpURLConnection refundConn = (HttpURLConnection) refundUrl.openConnection();
	            refundConn.setRequestMethod("POST");
	            refundConn.setDoOutput(true);
	            refundConn.setRequestProperty("Authorization", "Bearer " + accessToken);
	            refundConn.setRequestProperty("Content-Type", "application/json");
	            refundConn.getOutputStream().write(refundData.toString().getBytes());

	            InputStreamReader refundIn = new InputStreamReader(refundConn.getInputStream());
	            
	            StringBuilder refundResponse = new StringBuilder();
	            
	            while ((length = refundIn.read(buffer)) != -1) {
	                refundResponse.append(buffer, 0, length);
	            }

	            JsonObject refundResponseJson = new com.google.gson.JsonParser().parse(refundResponse.toString()).getAsJsonObject();

	            if (refundResponseJson.get("code").getAsString().equals("0")) {
	            	
	            	String applyNum = refundResponseJson.getAsJsonObject("response").get("apply_num").getAsString();
	            	
	            	dao.updatePaymentStatus(paymentId, "REFUNDED");
	            	
	            	RefundDAO rdao = new RefundDAO();
	            	
	            	rdao.insertRefund(paymentId, payment.getBuyer(), payment.getSeller(), reason, payment.getAmount(), applyNum, impUid);
	            	
	                return true;
	            } else {
	            	System.out.println("환불 실패: " + refundResponseJson.get("message").getAsString());
	                return false;
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	            return false; 
	        }
	    }

}
