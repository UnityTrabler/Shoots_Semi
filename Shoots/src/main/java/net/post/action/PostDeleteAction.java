package net.post.action;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.post.db.PostDAO;

public class PostDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
int num = Integer.parseInt(request.getParameter("num"));
		
		PostDAO postdao = new PostDAO();
		
//		// 글 삭제 명령을 요청한 사용자가 글을 작성한 사용자인지 판단하기 위해
//		// 입력한 비밀번호와 저장된 비밀번호를 비교하여 일치하여 삭제합니다.
//		boolean usercheck = postdao.isPostWriter(num, request.getParameter("post_id"));
//		
//		// 비밀번호 일치하지 않는 경우
//		if (!usercheck) {
//			response.setContentType("text/html;charset=utf-8");
//			PrintWriter out = response.getWriter();
//			out.print("<script>");
//			out.print("alert('비밀번호가 다릅니다.');");
//			out.print("history.back();");
//			out.print("</script>");
//			out.close();
//			return null;
//		}
		
		// 비밀번호 일치하는 경우 삭제 처리 합니다.
		boolean result = postdao.postDelete(num);
		
		// 삭제 처리 실패한 경우
		if (!result) {
			System.out.println("게시판 삭제 실패");
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			request.setAttribute("message", "데이터를 삭제하지 못했습니다.");
			forward.setPath("/WEB-INF/views/error/error.jsp");
			return forward;
		} else {
			// 삭제 처리 성공한 경우 - 글 목록 보기 요청을 전송하는 부분입니다.
			System.out.println("게시판 삭제 성공");
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script>");
			out.print("alert('삭제 되었습니다.');");
			out.print("location.href='list';");
			out.print("</script>");
			out.close();
			return null;
		}
	}

}
