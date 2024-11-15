package net.pay.listner;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import com.google.gson.JsonObject;

import net.match.db.MatchBean;
import net.match.db.MatchDAO;
import net.pay.db.PaymentBean;
import net.pay.db.PaymentDAO;
import net.pay.db.RefundDAO;

public class AutoRefundScheduler {
	
	private Timer timer;
	
	public AutoRefundScheduler() {
        timer = new Timer();
    }

	public void startScheduler() {
        timer.schedule(new TimerTask() {
            @Override
            public void run() {
                try {
                    checkRefundCondition();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }, 0, 60 * 1000); 
    }

	private void checkRefundCondition() throws ParseException {
		MatchDAO matchDao = new MatchDAO();
		List<MatchBean> afterMatchList = matchDao.getAfterMatchList(); 

		long currentTime = System.currentTimeMillis();

		for (MatchBean match : afterMatchList) {
			
			String matchDateTimeString = match.getMatch_date().substring(0,10) + " " + match.getMatch_time();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			
            Date matchDateTime = sdf.parse(matchDateTimeString);
            
            long matchTime = matchDateTime.getTime();
			long timeBeforeMatch = matchTime - (2 * 60 * 60 * 1000);
			
			System.out.println("matchDateTimeString = " + matchDateTimeString);
			System.out.println("matchTime       = " + matchTime);
			System.out.println("currentTime     = " + currentTime);
			System.out.println("timeBeforeMatch = " + timeBeforeMatch);
			System.out.println("-------------------------------------------------");
			
			int playerCount = match.getPlayerCount();
			int playerMin = match.getPlayer_min();
			System.out.println("playerCount = " + playerCount);
			System.out.println("playerMin = " + playerMin);
			System.out.println("-------------------------------------------------");

			
			if (timeBeforeMatch < currentTime && currentTime < matchTime ) { 

				System.out.println("playerCount = " + playerCount);
				System.out.println("playerMin = " + playerMin);
				System.out.println("-------------------------------------------------");

				if (playerCount < playerMin) {
					PaymentDAO paymentDao = new PaymentDAO();
					List<PaymentBean> payments = paymentDao.getPaymentsByMatchId(match.getMatch_id());

					for (PaymentBean payment : payments) {
						
						String reason = "매칭 최소 인원 미달로 환불";
						String paymentId = String.valueOf(payment.getPayment_id());
						
						boolean refundSuccess = callAimpotRefundAPI(payment.getImp_uid(), reason, paymentId, payment, paymentDao);

                    }
                }
            }
        }
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
	 
	public void stopScheduler() {
		if (timer != null) {
            timer.cancel();
		}
	}

}
