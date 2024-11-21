package net.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.user.db.BusinessUserDAO;

public class AdminRefuseAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String id = req.getParameter("id");
		BusinessUserDAO dao = new BusinessUserDAO();
		
		int result = dao.refuseBusiness(id);
		
		if(result == 0) {
			System.out.println("승인 거부 실패");
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			req.setAttribute("message", "승인 거부하지 못했습니다");
			forward.setPath("/WEB-INF/views/error/error.jsp");
			return forward;
		}else {
			System.out.println("거절");
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>");
			out.print("alert('승인 거부 되었습니다');");
			out.print("location.href='../admin/mypage';");
			out.print("</script>");
			out.close();
			return null;
			
		}
	}

}
