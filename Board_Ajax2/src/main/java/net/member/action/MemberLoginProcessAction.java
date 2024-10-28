package net.member.action;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.comment.action.Action;
import net.comment.action.ActionForward;
import net.member.db.MemberDAO;

public class MemberLoginProcessAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		
		MemberDAO mdao = new MemberDAO();
		int result = mdao.isId(id,pass);
		System.out.println("result is "+result);
		
		//login success
		if(result == 1) {
			HttpSession session = req.getSession();
			session.setAttribute("id", id);
			
			String IDStore = req.getParameter("remember");
			Cookie cookie = new Cookie("id",id);
			
			//remember id 체크한 경우
			if(IDStore != null && IDStore.equals("store")) {
				// 	cookie.setMaxAge(60 * 60 * 24); //쿠키 유효시간 24hour
				cookie.setMaxAge(2 * 60);
				//client로 cookie 값 전송.
				System.out.println("cookie 확인");
			}//if
			else 
				cookie.setMaxAge(0);
			resp.addCookie(cookie);
			forward.setRedirect(true);
			forward.setPath("../boards/list");
			return forward;
		}//if 
		else {
			String message = "비밀번호 일치 x";
			if(result == -1)
				message = "not exist id";
			
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>");
			out.print("alert('"+message+"');");
			//out.print("location.href='" + req.getContextPath() + "/members/login';");
			out.print("history.back();");
			out.print("</script>");
			out.close();
			return null;
		}//else
		
	}

}
