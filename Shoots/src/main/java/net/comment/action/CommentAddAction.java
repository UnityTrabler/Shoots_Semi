package net.comment.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
		System.out.println("class : " + request.getParameter("comment_ref_id").getClass());
		System.out.println("is null1 :  " +  request.getParameter("comment_ref_id") == null);
		System.out.println("is null2 : " +  request.getParameter("comment_ref_id").toString().equals(""));
		System.out.println("is null3 : " +  request.getParameter("comment_ref_id").equals(""));
		co.setComment_ref_id(request.getParameter("comment_ref_id").equals("") ? -1 : Integer.parseInt(request.getParameter("comment_ref_id")));
//		co.setComment_ref_id(request.getParameter("comment_ref_id").equals("") ? null : 1);
		System.out.println("출려 해서" + request.getParameter("comment_ref_id"));
		HttpSession session = request.getSession();
		co.setWriter((int) session.getAttribute("idx"));
		co.setContent(request.getParameter("content"));
        
		
		
        // 댓글 추가 처리
		int ok = dao.commentsInsert(co);
		
		// 결과를 클라이언트에 반환
		response.getWriter().print(ok);
		return null;
	}

}
