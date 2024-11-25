package net.match.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;
import net.user.db.BusinessUserBean;
import net.user.db.BusinessUserDAO;

public class MatchWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		ActionForward forward = new ActionForward();
		
		HttpSession session = req.getSession();
		int idx = (int) session.getAttribute("idx");
		System.out.println("로그인 = " + idx);
		
		BusinessUserDAO dao = new BusinessUserDAO();
		BusinessUserBean user = new BusinessUserBean();
		
		user = dao.getDescription(idx);
		
		forward.setRedirect(false);
		req.setAttribute("user", user);
		forward.setPath("/WEB-INF/views/match/matchForm.jsp");
		return forward;
	}

}
