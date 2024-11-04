package net.match.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.match.db.MatchBean;
import net.match.db.MatchDAO;

public class MatchDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		MatchDAO dao = new MatchDAO();
		
		int matchId = Integer.parseInt(request.getParameter("match_id"));
		
		MatchBean match = dao.getDetail(matchId);
		
		ActionForward forward = new ActionForward();
		
		if (match == null) {
			System.out.println("상세보기 실패");
			
			request.setAttribute("message", "데이터를 읽지 못했습니다.");
			forward.setPath("/WEB-INF/views/error/error.jsp");
			return forward;
		} else {
			System.out.println("상세보기 성공");
			request.setAttribute("match", match);
			forward.setPath("/WEB-INF/views/match/matchDetail.jsp");
		}
		forward.setRedirect(false);
		return forward;
	}

}
