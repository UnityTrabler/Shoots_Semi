package net.comment.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.comment.db.CommentBean;
import net.comment.db.CommentDAO;
import net.core.Action;
import net.core.ActionForward;

public class CommentReplyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		CommentDAO dao = new CommentDAO();
		
		CommentBean co = new CommentBean();
		co.setWriter(Integer.parseInt(request.getParameter("writer")));
		co.setContent(request.getParameter("content"));
		co.setComment_ref_id (Integer.parseInt(request.getParameter("comment_ref_id"))); 
		co.setPost_id (Integer.parseInt(request.getParameter("post_id")));
		
		int ok = dao.commentsReply(co);
		response.getWriter().print(ok);
		return null;
	}

}
