package net.match.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.match.db.*;

public class MatchUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		ActionForward forward = new ActionForward();
		MatchDAO dao = new MatchDAO();
		
		int matchId = Integer.parseInt(req.getParameter("match_id"));
		MatchBean match = dao.getDetail(matchId);
				
		if (match == null) {
			System.out.println("수정 상세보기 실패");
			req.setAttribute("message", "수정 상세보기 실패");
			forward.setPath("/WEB-INF/views/error/error.jsp");
		} else {
			System.out.println("상세보기 성공");
			req.setAttribute("match", match);
			forward.setPath("/WEB-INF/views/match/matchUpdateForm.jsp");
		}
		forward.setRedirect(false);
		return forward;
	}

}
