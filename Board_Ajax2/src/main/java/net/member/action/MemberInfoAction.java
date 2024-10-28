package net.member.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.comment.action.Action;
import net.comment.action.ActionForward;
import net.member.db.Member;
import net.member.db.MemberDAO;

public class MemberInfoAction implements Action {

	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		if ((String)req.getParameter("id") == null) return null;
		ActionForward forward = new ActionForward();
		Member member = new MemberDAO().getDetail((String)req.getParameter("id"));
		req.setAttribute("member", member);
		
		forward.setPath("/WEB-INF/views/member/memberInfo.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
