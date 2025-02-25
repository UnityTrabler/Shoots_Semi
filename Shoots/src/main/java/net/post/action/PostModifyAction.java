package net.post.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.post.db.PostBean;
import net.post.db.PostDAO;

public class PostModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		ActionForward forward = new ActionForward();
		PostDAO postdao = new PostDAO();
		
		
		//파라미터로 전달받은 수정할 글 번호를 num변수에 저장합니다.
		int num = Integer.parseInt(request.getParameter("num"));
		// 글 내용을 불러와서 boarddata객체에 저장합니다.
		PostBean postdata = postdao.getDetail(num);
		
		
		
		
		// 글 내용 불러오기 실패한 경우입니다.
		if (postdata == null) {
			System.out.println("(수정)상세보기 실패");
			request.setAttribute("message", "게시판 수정 상세 보기 실패입니다.");
			forward.setPath("WEB-INF/views/error/error.jsp");
		} else {
			System.out.println("(수정)상세보기 성공");
			
			// 수정 폼 페이지로 이동할 때 원문 글 내용을 보여주기 때문에 boarddata 객체를
			//request 객체에 저장합니다.
			request.setAttribute("postdata", postdata);
			
			// 글 수정 폼 페이지로 이동하기위해 경로를 설정합니다.
			forward.setPath("/WEB-INF/views/post/postModify.jsp");
		}
		forward.setRedirect(false);
		return forward;
	}

}
