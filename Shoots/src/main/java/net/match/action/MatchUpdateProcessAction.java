package net.match.action;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.match.db.MatchBean;
import net.match.db.MatchDAO;

public class MatchUpdateProcessAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		MatchBean match = new MatchBean();
		MatchDAO dao = new MatchDAO();
		ActionForward forward = new ActionForward();
		
		
		
		match.setMatch_id(Integer.parseInt(req.getParameter("match_id")));
		match.setMatch_date(req.getParameter("match_date"));
		match.setMatch_time(req.getParameter("match_time"));
		match.setPlayer_min(Integer.parseInt(req.getParameter("player_min")));
		match.setPlayer_max(Integer.parseInt(req.getParameter("player_max")));
		match.setPlayer_gender(req.getParameter("player_gender"));
		match.setPrice(Integer.parseInt(req.getParameter("price")));
		
		int result = dao.matchUpdate(match);
		
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
			out.print("location.href = 'detail?match_id=" + match.getMatch_id() + "';");
			out.print("</script>");
			out.close();
		}
		
		return null;
	}

}
