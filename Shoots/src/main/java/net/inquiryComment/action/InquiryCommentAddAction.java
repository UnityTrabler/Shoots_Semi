package net.inquiryComment.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.inquiryComment.db.InquiryCommentBean;
import net.inquiryComment.db.InquiryCommentDAO;

public class InquiryCommentAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		ActionForward forward = new ActionForward();
		InquiryCommentDAO icdao = new InquiryCommentDAO();
		InquiryCommentBean ic = new InquiryCommentBean();
		
		ic.setWriter(Integer.parseInt(req.getParameter("writer")));
		ic.setContent(req.getParameter("content"));
		System.out.println("댓글의 작성자와 내용은 : " + ic.getWriter() + ", "+ ic.getContent());
		
		int ok = icdao.getCommentInsert(ic, Integer.parseInt(req.getParameter("inquiry_id")));
		resp.getWriter().print(ok);
		
		forward.setRedirect(true);
		forward.setPath("../inquiry/detail?inquiryid=" + Integer.parseInt(req.getParameter("inquiry_id")));
		return forward;
	}

}
