package net.comment.action;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.comment.db.CommentDAO;
import net.core.Action;
import net.core.ActionForward;

public class CommentDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int comment_id = Integer.parseInt(request.getParameter("comment_id"));
		
		CommentDAO dao = new CommentDAO();
		
		int result = dao.commentDelete(comment_id);
		PrintWriter out = response.getWriter();
		out.print(result);
		return null;
	}

}
