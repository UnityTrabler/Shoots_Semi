package net.user.action;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;
import net.match.db.MatchBean;
import net.match.db.MatchDAO;
import net.pay.db.PaymentDAO;
import net.user.db.UserDAO;

public class UserMatchsAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		MatchDAO dao = new MatchDAO();
		PaymentDAO pdao = new PaymentDAO();
		UserDAO udao = new UserDAO();
		
		HttpSession session = req.getSession();
		int idx = (int) session.getAttribute("idx");
		System.out.println("로그인 = " + idx);
		
		List<MatchBean> list = dao.getMatchsByPlayerId(idx);
		
		for (MatchBean match : list) {
	        int playerCount = pdao.getPaymentCountById(match.getMatch_id());
	        match.setPlayerCount(playerCount);
	        
	        String a = match.getMatch_date().substring(0,10) + ' ' + match.getMatch_time();
	        
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
	        LocalDateTime matchDateTime = LocalDateTime.parse(a, formatter);
	        
	        LocalDateTime currentDateTime = LocalDateTime.now();
	         
	        LocalDateTime twoHoursBeforeMatch = matchDateTime.minusHours(2);
	        
	        boolean isMatchPast = twoHoursBeforeMatch.isBefore(currentDateTime);
	        match.setMatchPast(isMatchPast);
	        
	    }
		
		ActionForward forward = new ActionForward();
		req.setAttribute("list", list);
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/user/UserMatchs.jsp");
		
        return forward;
	}
}