package net.user.action;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;

public class UserLogoutAction implements Action {

	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) {
		
		HttpSession session = req.getSession();
		session.removeAttribute("id");
		
		ActionForward forward = new ActionForward();
		forward.setPath("../user/login");
		forward.setRedirect(true);
		return forward;

	}

}
