package net.user.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;
import net.user.db.UserDAO;

public class BusinessUserUpdateAction implements Action {

	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		ActionForward forward = new ActionForward();
		UserDAO userDAO = new UserDAO();
		HttpSession session = req.getSession();
		String id = (String)session.getAttribute("id");

		req.setAttribute("BusinessBean", userDAO.getBusinessUser(id));
		forward.setPath("/WEB-INF/views/user/updateBusiness.jsp");
		forward.setRedirect(false);
		return forward;
		
	}

}
