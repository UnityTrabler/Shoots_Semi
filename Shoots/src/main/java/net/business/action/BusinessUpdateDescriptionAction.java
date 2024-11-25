package net.business.action;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;
import net.user.db.BusinessUserBean;
import net.user.db.BusinessUserDAO;

public class BusinessUpdateDescriptionAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		BusinessUserBean user = new BusinessUserBean();
		BusinessUserDAO dao = new BusinessUserDAO();
		ActionForward forward = new ActionForward();
		
		HttpSession session = req.getSession();
		int idx = (int) session.getAttribute("idx");
		System.out.println("로그인 = " + idx);
		
		user.setDescription(req.getParameter("description"));
		
		int result = dao.updateDescription(idx, user);
		
		if (result != 1) {
			System.out.println("수정 실패");
			req.setAttribute("message", "수정 오류");
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/error/error.jsp");
		} else {
			System.out.println("수정 완료");
			forward.setRedirect(true);
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>");
			out.print("alert('수정 되었습니다.');");
			out.print("location.href = 'mypage';");
			out.print("</script>");
			out.close();
		}
		
		return null;
		
	}

}
