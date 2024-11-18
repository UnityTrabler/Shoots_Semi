package net.comment.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.comment.db.CommentBean;
import net.comment.db.CommentDAO;
import net.core.Action;
import net.core.ActionForward;

public class CommentAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
        CommentDAO dao = new CommentDAO();
		CommentBean co = new CommentBean();
		
		
		co.setPost_id(Integer.parseInt(request.getParameter("post_id")));
		co.setComment_ref_id(Integer.parseInt(request.getParameter("comment_ref_id")));
		co.setWriter(Integer.parseInt(request.getParameter("writer")));
		co.setContent(request.getParameter("content"));
        
		
		
        // 댓글 추가 처리
		int ok = dao.commentsInsert(co);
		
		// 결과를 클라이언트에 반환
		response.getWriter().print(ok);
		return null;
	}

}
