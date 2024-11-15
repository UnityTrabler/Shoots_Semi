package net.faq.action;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.faq.db.FaqBean;
import net.faq.db.FaqDAO;

public class FaqAdmin implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		FaqDAO dao = new FaqDAO();
		
		int listcount = 0;
		List<FaqBean> list = null;
		list = dao.getList();
		listcount = dao.getListCount();
		req.setAttribute("totallist", list);
		req.setAttribute("listcount", listcount);
		forward.setPath("/WEB-INF/views/faq/faqAdmin.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
