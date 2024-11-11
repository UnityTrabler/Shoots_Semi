package net.inquiryComment.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.inquiryComment.db.InquiryCommentDAO;

public class InquiryCommentListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		InquiryCommentDAO dao = new InquiryCommentDAO();
		int inquiry_id = Integer.parseInt(req.getParameter("inquiry_id"));
		
		int listcount = dao.getListCount(inquiry_id);
		
		
		
		return null;
	}

}
