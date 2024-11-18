package net.comment.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.comment.db.CommentBean;
import net.comment.db.CommentDAO;
import net.core.Action;
import net.core.ActionForward;

public class CommentUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		CommentDAO dao = new CommentDAO();
		CommentBean co = new CommentBean();
		
		co.setContent(request.getParameter("content")); 
		System.out.println("content=" + co.getContent());
		
		co.setComment_id(Integer.parseInt(request.getParameter("comment_id")));

		int ok = dao.commentsUpdate(co);
		response.getWriter().print(ok);
		return null;
	}

}
