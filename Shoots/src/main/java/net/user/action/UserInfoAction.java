package net.user.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;
import net.user.db.UserBean;
import net.user.db.UserDAO;

public class UserInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		UserDAO dao = new UserDAO();
		
		HttpSession session = req.getSession();
		int idx = (int) session.getAttribute("idx");
		System.out.println("로그인 = " + idx);
		
		UserBean user = dao.getUserInfoById(idx);
		
		ActionForward forward = new ActionForward();
		req.setAttribute("user", user);
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/user/UserInfo.jsp");
		
		return forward;
	}

}
