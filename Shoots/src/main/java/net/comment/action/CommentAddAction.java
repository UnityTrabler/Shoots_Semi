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
		
		ActionForward forward = new ActionForward();
		
		
		int post_id = Integer.parseInt(request.getParameter("postid")); // request에서 post_id 가져오기
//		int writer = Integer.parseInt(request.getParameter("writer")); // 작성자 ID
//        String content = request.getParameter("content"); // 댓글 내용 가져오기
//        int comment_ref_id = Integer.parseInt(request.getParameter("comment_ref_id")); // 부모 댓글 ID (답글일 경우)
//        String user_id = request.getParameter("loginid");
//     // comment_ref_id는 답글인 경우에만 사용되므로, 값이 null 또는 빈 값이면 0으로 설정
//        int comment_ref_id = 0; // 기본값 0 설정
//        String refIdParam = request.getParameter("comment_ref_id");
//        if (refIdParam != null && !refIdParam.isEmpty()) {
//            try {
//                comment_ref_id = Integer.parseInt(refIdParam);  // 값을 숫자로 변환
//            } catch (NumberFormatException e) {
//                // 만약 값이 잘못된 형식이면 0으로 처리 (예외 처리)
//                comment_ref_id = 0;
//            }
//        }
        CommentDAO dao = new CommentDAO();
		CommentBean co = new CommentBean();
        
		co.setComment_id(Integer.parseInt(request.getParameter("comment_id")));;
		co.setPost_id(Integer.parseInt(request.getParameter("post_id")));
		co.setComment_ref_id(Integer.parseInt(request.getParameter("comment_ref_id")));
		co.setWriter(Integer.parseInt(request.getParameter("writer")));
		co.setContent(request.getParameter("content"));
		co.setRegister_date(request.getParameter("register_date"));
		
     // CommentBean 객체에 값 설정
//        co.setWriter(writer);
//        co.setContent(content);
//        co.setComment_ref_id(comment_ref_id); // 답글인 경우 부모 댓글 ID를 설정
//        co.setUser_id(user_id);

		//int result = dao.commentsInsert(co, post_id);
		int result = dao.commentsInsert(co, Integer.parseInt(request.getParameter("post_id")));
		response.getWriter().print(result);
		
		
		// 댓글 추가 후 결과 반환
        response.setContentType("application/json");
		
		forward.setRedirect(true);
		forward.setPath("../post/detail?postid=" + post_id);
		return forward;
		
		
//        // 댓글 추가 처리
//		int ok = dao.commentsInsert(co);
//		
//		// 결과를 클라이언트에 반환
//		response.getWriter().print(ok);
//		return null;
	}

}
