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
		System.out.println("state :    -    "+req.getParameter("state") + "//////"+id + pwd);
		
		if(req.getParameter("state").equals("regular")) {
			int result = userDAO.isId(id, pwd);
			System.out.println("result : " + result);
			
			if(result == 1) {
				System.out.println("id :" + id +"- login 일치");
						
				//session id
				HttpSession session = req.getSession();
				session.setAttribute("id", id);
				session.setAttribute("idx", userDAO.getUserIdx(id));
				session.setAttribute("role", new UserDAO().getUser(id).getRole());
				session.setAttribute("file", new UserDAO().getUser(id).getUserfile());
				session.setAttribute("userClassification", "regular");
				//store cookie
				Cookie cookie = new Cookie("id", id);
				cookie.setMaxAge(0);
				if(req.getParameter("remember") != null && req.getParameter("remember").equals("store"))
					cookie.setMaxAge(60 * 60 * 1); //1시간
				resp.addCookie(cookie);
				
				//forward
				resp.setContentType("application/json; charset=UTF-8");
				resp.setStatus(HttpServletResponse.SC_OK);
				resp.getWriter().println("{\"message\":\"login successed\"}");
				return null;
			}
			System.out.println("regular login 불일치");
			resp.setContentType("application/json; charset=UTF-8");
			resp.getWriter().print("""
					{'message' : 'regular login 불일치'}
				""");

		}//if regular
		else if(req.getParameter("state").equals("business")) {
			int result = userDAO.isIdBusiness(id, pwd);
			System.out.println("result : " + result);
			
			if(result == 1) {
				System.out.println("b - id :" + id +"- login 일치");
				System.out.println("userDAO.getBusinessUser(id).getLogin_status() : " + userDAO.getBusinessUser(id).getLogin_status());
				if(!userDAO.getBusinessUser(id).getLogin_status().equals("approved")) {
					resp.setContentType("application/json; charset=UTF-8");
					resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
					resp.getWriter().println("{\"message\":\"승인 대기중이거나 관리자가 승인하지 않은 ID 입니다.\"}");
					return null;
				}
						
				//session id
				HttpSession session = req.getSession();
				session.setAttribute("id", id);
				session.setAttribute("idx", userDAO.getBusinessUserIdx(id));
				session.setAttribute("userClassification", "business");
				
				//store cookie
				Cookie cookie = new Cookie("id", id);
				cookie.setMaxAge(0);
				if(req.getParameter("remember") != null && req.getParameter("remember").equals("store"))
					cookie.setMaxAge(60 * 60 * 1); //1시간
				resp.addCookie(cookie);
				
				//forward
				resp.setContentType("application/json; charset=UTF-8");
				resp.setStatus(HttpServletResponse.SC_OK);
				resp.getWriter().println("{\"message\":\"login successed\"}");
				return null;
			}
			System.out.println("business login 불일치");
			resp.setContentType("application/json; charset=UTF-8");
			resp.getWriter().print("""	
					{'message' : 'business login 불일치'}
				""");
		}
		
		return null;
	}
}