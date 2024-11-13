package net.inquiryComment.action;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.inquiryComment.db.InquiryCommentDAO;

public class InquiryCommentDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		int i_comment_id = Integer.parseInt(req.getParameter("i_comment_id"));
		int inquiryid = Integer.parseInt(req.getParameter("inquiryid"));
		
		InquiryCommentDAO ic = new InquiryCommentDAO();

		
		//댓글 삭제 후 다시 해당 문의글로 돌아가기 위해 문의글 번호의 값을 받아서 저장해둠
		
		boolean result = ic.inquiryCommentDelete(i_comment_id);
		
		//삭제 처리 실패한 경우
		if (!result) {
			System.out.println("문의댓글 삭제에 실패했습니다.");
			ActionForward forward= new ActionForward();
			forward.setRedirect(false);
			req.setAttribute("message", "데이터를 삭제하지 못했습니다.");
			forward.setPath("WEB-INF/views/error/error.jsp");
			return forward;
		}else {
			//삭제 처리 성공한 경우 - 글 목록 보기 요청을 전송하는 부분임.
			System.out.println("문의글을 삭제했습니다.");
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>");
			out.print("alert('문의댓글을 성공적으로 삭제했습니다.');");
			out.print("location.href='../inquiry/detail?inquiryid=" +inquiryid+ "';");
			out.print("</script>");
			out.close();
			return null;
		}
		
	}

}
