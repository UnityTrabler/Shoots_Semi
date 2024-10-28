package net.member.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.comment.action.Action;
import net.comment.action.ActionForward;
import net.member.db.MemberDAO;

public class MemberUpdateAction implements Action {

	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		ActionForward forward = new ActionForward();
		MemberDAO memberDAO = new MemberDAO();
		HttpSession session = req.getSession();
		String id = (String)session.getAttribute("id");
	
		req.setAttribute("member", memberDAO.getDetail(id));
		forward.setPath("/WEB-INF/views/member/memberUpdate.jsp");
		forward.setRedirect(false);
		req.setAttribute("memberinfo", memberDAO.getDetail(id));
		return forward;
		
	}

}
