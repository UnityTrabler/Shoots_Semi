package net.customer.action;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.faq.db.FaqBean;
import net.faq.db.FaqDAO;

public class CustomerFaqAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		FaqDAO dao = new FaqDAO();
		
		List<FaqBean> list = null;
		list = dao.getList();
		req.setAttribute("totallist", list);
		forward.setPath("/WEB-INF/views/faq/faqList.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
