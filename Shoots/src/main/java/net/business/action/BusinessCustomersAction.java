package net.business.action;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;
import net.user.db.UserBean;
import net.user.db.UserDAO;

public class BusinessCustomersAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		UserDAO dao = new UserDAO();
		
		HttpSession session = req.getSession();
		int idx = (int) session.getAttribute("idx");
		System.out.println("로그인 = " + idx);
		
		List<UserBean> customers = dao.getCustomersById(idx);
		List<UserBean> acustomers = dao.getAllCustomersById(idx);

		ActionForward forward = new ActionForward();
		req.setAttribute("customers", customers);
		req.setAttribute("acustomers", acustomers);
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/business/BusinessCustomers.jsp");
		
		return forward;
	}

}
