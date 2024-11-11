package net.inquiryComment.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.inquiryComment.db.InquiryCommentBean;
import net.inquiryComment.db.InquiryCommentDAO;

public class InquiryCommentListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		ActionForward forward = new ActionForward ();
		InquiryCommentDAO dao = new InquiryCommentDAO();
		List<InquiryCommentBean> iqlist = new ArrayList<InquiryCommentBean>();
		
		int inquiry_id = Integer.parseInt(req.getParameter("inquiry_id"));
		iqlist = dao.getIqList(inquiry_id);
		
		
	    req.setAttribute("iqlist", iqlist);
	    
		forward.setRedirect(false);
		forward.setPath("../inquiry/detail?inquiryid=" + inquiry_id);
		return forward;
		
	}

}
