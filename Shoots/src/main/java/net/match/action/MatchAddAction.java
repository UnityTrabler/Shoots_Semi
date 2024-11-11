package net.match.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.match.db.*;

public class MatchAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		MatchDAO dao = new MatchDAO();
		MatchBean match = new MatchBean();
		ActionForward forward = new ActionForward();
		
		match.setWriter(Integer.parseInt(request.getParameter("writer")));
		match.setMatch_date(request.getParameter("match_date"));
		match.setMatch_time(request.getParameter("match_time"));
		match.setPlayer_max(Integer.parseInt(request.getParameter("player_max")));
		match.setPlayer_min(Integer.parseInt(request.getParameter("player_min")));
		match.setPlayer_gender(request.getParameter("player_gender"));
		match.setPrice(Integer.parseInt(request.getParameter("price")));
		
		int result = dao.matchInsert(match);
		response.getWriter().print(result);
		
		if (result == 1) {
			forward.setRedirect(true);
			forward.setPath("list");
			return forward;
		} else {
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/error/error.jsp");
			request.setAttribute("message", "결제 실패");
			return forward;
		}
	}

}

