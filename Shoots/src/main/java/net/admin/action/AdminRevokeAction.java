package net.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.user.db.UserDAO;

public class AdminRevokeAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String id = req.getParameter("id");
		UserDAO dao = new UserDAO();
		
		int result = dao.revokeAdmin(id);
		
		if(result == 0) {
			System.out.println("일반 사용자로 전환 실패");
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			req.setAttribute("message", "데이터를 삭제하지 못했습니다");
			forward.setPath("/WEB-INF/views/error/error.jsp");
			return forward;
		}else {
			System.out.println("일반 사용자로 전환");
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>");
			out.print("alert('일반 사용자로 전환되었습니다');");
			out.print("location.href='../admin/mypage';");
			out.print("</script>");
			out.close();
			return null;
			
		}
	}

}
