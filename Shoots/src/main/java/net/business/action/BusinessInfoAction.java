package net.business.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;
import net.user.db.BusinessUserBean;
import net.user.db.BusinessUserDAO;

public class BusinessInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		BusinessUserDAO dao = new BusinessUserDAO();
		
		HttpSession session = req.getSession();
		int idx = (int) session.getAttribute("idx");
		System.out.println("로그인 = " + idx);
		
		BusinessUserBean businessUser = dao.getUserInfoById(idx);
		
		ActionForward forward = new ActionForward();
		req.setAttribute("businessUser", businessUser);
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/business/BusinessInfo.jsp");
		
		return forward;
	}

}

