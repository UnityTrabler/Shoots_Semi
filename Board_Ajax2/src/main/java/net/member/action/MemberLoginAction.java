package net.member.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.comment.action.Action;
import net.comment.action.ActionForward;

@WebServlet("/members")
public class MemberLoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String id = "";
		Cookie[] cookies = req.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("id"))
					id = cookies[i].getValue();
			}
		}

		req.setAttribute("cookieId", id);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false); //주소 변경없이 jsp 페이지 내용 보여줌
		forward.setPath("/WEB-INF/views/member/loginForm.jsp");
		return forward;
	}

}
