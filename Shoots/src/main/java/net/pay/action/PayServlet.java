package net.pay.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;

public class PayServlet implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String matchId = req.getParameter("match_id");
		String price = req.getParameter("price");

	    req.setAttribute("matchId", matchId);
	    req.setAttribute("price", price);

	    ActionForward forward = new ActionForward();
	    forward.setPath("/WEB-INF/views/pay/payment.jsp");
	    forward.setRedirect(false);

	    return forward;
	}

}
