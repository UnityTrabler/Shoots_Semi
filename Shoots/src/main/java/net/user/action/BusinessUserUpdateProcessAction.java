package net.user.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.user.db.BusinessUserBean;
import net.user.db.UserDAO;

public class BusinessUserUpdateProcessAction implements Action {

	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
			BusinessUserBean businessUserBean = new BusinessUserBean();
			UserDAO userDAO = new UserDAO();
			businessUserBean.setBusiness_id(req.getParameter("id"));
			businessUserBean.setPassword(req.getParameter("pwd"));
			businessUserBean.setBusiness_name(req.getParameter("business-name"));
			businessUserBean.setBusiness_number(Long.parseLong(req.getParameter("business-number")));
			businessUserBean.setTel(Integer.parseInt(req.getParameter("tel")));
			System.out.println("sadadsad-a-sad-as-");
			System.out.println(Integer.parseInt(req.getParameter("tel")));
			System.out.println(businessUserBean.getTel());
			businessUserBean.setEmail(req.getParameter("email"));
			businessUserBean.setPost(Integer.parseInt(req.getParameter("postcode")));
			businessUserBean.setAddress(req.getParameter("address") + " " + req.getParameter("addressDetail"));
			
			int result = userDAO.update(businessUserBean); //db update
			
			if(result == 1) {
				System.out.println("update 성공");
				resp.setContentType("text/html;charset=utf-8");
				resp.setStatus(HttpServletResponse.SC_OK);
				resp.getWriter().println("{\"message\":\"수정 완료\"}");
				return null;
			}
			
			else {
				System.out.println("update 실패");
				resp.setContentType("text/html;charset=utf-8");
				resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				resp.getWriter().println("{\"message\":\"수정 실패\"}");
				return null;
			}
	}

}
