package net.inquiryComment.action;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.inquiryComment.db.InquiryCommentBean;
import net.inquiryComment.db.InquiryCommentDAO;

public class InquiryCommentModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		ActionForward forward = new ActionForward();
		InquiryCommentDAO icdao = new InquiryCommentDAO();
		InquiryCommentBean ic = new InquiryCommentBean(); 
		
		//수정 후 다시 문의글로 돌아가기 위해 문의글 번호 받아둠
		int inquiryid = Integer.parseInt(req.getParameter("inquiryid"));
		
		//새 댓글의 내용과 해당 댓글의 번호를 값으로 받아옴
		ic.setContent(req.getParameter("new-iqcomment-content"));
		System.out.println("수정할 새 댓글의 내용은 : " + ic.getContent());
		ic.setI_comment_id(Integer.parseInt(req.getParameter("i_comment_id")));
		
		int complete = icdao.commentModify(ic);
		
		 if (complete == 1) {
		        System.out.println("문의댓글을 수정했습니다.");
		        resp.setStatus(HttpServletResponse.SC_OK); // 성공 상태 코드 설정
		    } else {
		        System.out.println("문의댓글 수정에 실패했습니다.");
		        resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "문의댓글을 수정하지 못했습니다.");
		    }

		    return null;
		}

}
