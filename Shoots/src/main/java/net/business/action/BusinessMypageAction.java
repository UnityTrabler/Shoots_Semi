package net.business.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.user.db.BusinessUserBean;
import net.user.db.BusinessUserDAO;

public class BusinessMypageAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		BusinessUserDAO dao = new BusinessUserDAO();
		
		int business_idx = 5; // 임시
		BusinessUserBean businessUser = dao.getUserInfoById(business_idx);
		
		ActionForward forward = new ActionForward();
		req.setAttribute("businessUser", businessUser);
		forward.setRedirect(false);
		forward.setPath("/WEB-INF/views/business/BusinessMypage.jsp");
		
		return forward;
	}

}
