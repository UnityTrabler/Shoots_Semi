package net.user.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;
import net.user.db.UserDAO;

public class UserLoginProcessAction implements Action {

	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String id = req.getParameter("id");
		String pwd = req.getParameter("pwd");
		UserDAO userDAO = new UserDAO();
		
		int result = userDAO.isId(id, pwd);
		
		if(result == 1) {
			System.out.println("id :" + id +"- login 일치");
					
			//session id
			HttpSession session = req.getSession();
			session.setAttribute("id", id);
			session.setAttribute("idx", userDAO.getUserIdx(id));
			
			//store cookie
			Cookie cookie = new Cookie("id", id);
			cookie.setMaxAge(0);
			if(req.getParameter("remember") != null && req.getParameter("remember").equals("store"))
				cookie.setMaxAge(60 * 60 * 1); //1시간
			resp.addCookie(cookie);
			
			//forward
			ActionForward forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("/Shoots/index.jsp");
			resp.setStatus(HttpServletResponse.SC_OK);
			resp.getWriter().println("{\"message\":\"sign up successed\"}");
			return forward;
		}
		
		System.out.println("login 불일치");
		return null;
	}

}