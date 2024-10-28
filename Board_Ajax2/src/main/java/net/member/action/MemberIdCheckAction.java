package net.member.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.comment.action.Action;
import net.comment.action.ActionForward;
import net.member.db.MemberDAO;

public class MemberIdCheckAction implements Action {

	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		MemberDAO dao = new MemberDAO();
		int result = dao.isId(req.getParameter("id"));
		resp.getWriter().print(result);
		System.out.println(result);
		return null;
	}

}
