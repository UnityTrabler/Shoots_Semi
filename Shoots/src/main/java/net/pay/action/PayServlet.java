package net.pay.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;

public class PayServlet implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String matchId = req.getParameter("match_id");
		String price = req.getParameter("price");
		String seller  = req.getParameter("seller");
		
		HttpSession session = req.getSession();
		String userName = (String) session.getAttribute("name");
		String userEmail = (String) session.getAttribute("email");
		String userTel = (String) session.getAttribute("tel");
		
		System.out.println(userName + userEmail + userTel);
		
	    req.setAttribute("matchId", matchId);
	    req.setAttribute("price", price);
	    req.setAttribute("seller", seller);
	    req.setAttribute("userName", userName);
	    req.setAttribute("userEmail", userEmail);
	    req.setAttribute("userTel", userTel);
	    
	    ActionForward forward = new ActionForward();
	    forward.setPath("/WEB-INF/views/pay/payment.jsp");
	    forward.setRedirect(false);

	    return forward;
	}

}
