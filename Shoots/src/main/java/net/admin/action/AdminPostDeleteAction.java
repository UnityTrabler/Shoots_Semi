package net.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.post.db.*;

public class AdminPostDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		int id = Integer.parseInt(req.getParameter("id"));
		PostDAO dao = new PostDAO();
		
		int result = dao.listDelete(id);
		
		if(result == 0) {
			System.out.println("postlist 삭제 실패");
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			req.setAttribute("message", "post 데이터를 삭제하지 못했습니다");
			forward.setPath("/WEB-INF/views/error/error.jsp");
			return forward;
		}else {
			System.out.println("post 삭제 성공");
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>");
			out.print("alert('삭제되었습니다.');");
			out.print("location.href='../admin/mypage';");
			out.print("</script>");
			out.close();
			return null;
		}
		
	}

}
