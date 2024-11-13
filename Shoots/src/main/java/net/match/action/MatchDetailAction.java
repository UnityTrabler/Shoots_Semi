package net.match.action;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.match.db.MatchBean;
import net.match.db.MatchDAO;
import net.pay.db.PaymentBean;
import net.pay.db.PaymentDAO;

public class MatchDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		MatchDAO dao = new MatchDAO();
		PaymentDAO pdao = new PaymentDAO();
		PaymentBean payment = new PaymentBean();
		
		int matchId = Integer.parseInt(request.getParameter("match_id"));
		Integer idx = (Integer) request.getSession().getAttribute("idx"); 
		
		MatchBean match = dao.getDetail(matchId);
		
		boolean isLogIn = (idx != null);
		boolean isPaid = false;
		
		int playerCount = pdao.getPaymentCountById(match.getMatch_id());
	
		if (isLogIn) {
			isPaid = pdao.checkPayment(matchId, idx);
			payment = pdao.getPaymentInfoById(idx, matchId);
		}
		
		String matchTime = match.getMatch_date().substring(0,10) + ' ' + match.getMatch_time();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date currentTime = new Date();
   
        Date matchStartTime = new Date();
        
		try {
			matchStartTime = sdf.parse(matchTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
        long twoHoursBefore = matchStartTime.getTime() - (2 * 60 * 60 * 1000);
        
        boolean isMatchClosed = currentTime.getTime() >= twoHoursBefore;
        		
        
		ActionForward forward = new ActionForward();
		
		if (match == null) {
			System.out.println("상세보기 실패");
			request.setAttribute("message", "데이터를 읽지 못했습니다.");
			forward.setPath("/WEB-INF/views/error/error.jsp");
			return forward;
		} else {
			System.out.println("상세보기 성공");
			request.setAttribute("match", match);
			request.setAttribute("isPaid", isPaid);
			request.setAttribute("playerCount", playerCount);
			request.setAttribute("payment", payment);
	        request.setAttribute("isMatchClosed", isMatchClosed);
			forward.setPath("/WEB-INF/views/match/matchDetail.jsp");
		}
		forward.setRedirect(false);
		return forward;
	}

}
