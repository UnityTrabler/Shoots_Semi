package net.user.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;
import net.user.db.UserDAO;

public class UserUpdateAction implements Action {

	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		System.out.println("idx : "+req.getSession().getAttribute("idx"));
		ActionForward forward = new ActionForward();
		UserDAO userDAO = new UserDAO();
		HttpSession session = req.getSession();
		String id = (String)session.getAttribute("id");
		
		req.setAttribute("userBean", userDAO.getUser(id));
		forward.setPath("/WEB-INF/views/user/update.jsp");
		forward.setRedirect(false);
		return forward;
		
	}

}
