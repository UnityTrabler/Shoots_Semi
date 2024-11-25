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

		ActionForward forward = new ActionForward();
		UserDAO userDAO = new UserDAO();
		HttpSession session = req.getSession();
		String id = (String)session.getAttribute("id");
		
		if(session.getAttribute("userClassification").equals("regular")) {
			req.setAttribute("userBean", userDAO.getUser(id));
			forward.setPath("/WEB-INF/views/user/update.jsp");
			forward.setRedirect(false);
			return forward;
		}
		else if(session.getAttribute("userClassification").equals("business")) {
			req.setAttribute("BusinessBean", userDAO.getBusinessUser(id));
			forward.setPath("/WEB-INF/views/user/updateBusiness.jsp");
			forward.setRedirect(false);
			return forward;
		}
		
		System.out.println("no received state!");
		return null;
		
	}

}
