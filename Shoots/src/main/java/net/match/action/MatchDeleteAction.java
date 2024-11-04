package net.match.action;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.match.db.MatchDAO;

public class MatchDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		ActionForward forward = new ActionForward();
		MatchDAO dao = new MatchDAO();
		int matchId = Integer.parseInt(req.getParameter("match_id"));
		
		int result = dao.matchDelete(matchId);
		
		if (result != 1) {
			System.out.println("매칭 삭제 실패");
			forward.setRedirect(false);
			req.setAttribute("message", "매칭 삭제 실패");
			forward.setPath("/WEB-INF/views/error/error.jsp");
			return forward;
		}else {
			System.out.println("게시판 삭제 성공");
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>");
			out.print("alert('삭제 되었습니다.');");
			out.print("location.href = 'list';");
			out.print("</script>");
			out.close();
			
			return null;
		}
	}

}
