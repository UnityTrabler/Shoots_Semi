package net.user.action;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.match.db.MatchBean;
import net.match.db.MatchDAO;
import net.user.db.UserBean;
import net.user.db.UserDAO;

public class UserMatchPlayerAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		int match_id = Integer.parseInt(req.getParameter("match_id"));
		
		UserDAO dao = new UserDAO();
		MatchDAO mdao = new MatchDAO();
		
		List<UserBean> players = dao.getPlayerByMatchId(match_id);
				
		MatchBean match = mdao.getMatchById(match_id);
				
		String a = match.getMatch_date().substring(0,10) + ' ' + match.getMatch_time();
	        
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        LocalDateTime matchDateTime = LocalDateTime.parse(a, formatter);
        
        LocalDateTime currentDateTime = LocalDateTime.now();
         
        LocalDateTime twoHoursAfterMatch = matchDateTime.plusHours(2);
        LocalDateTime threeDaysBeforeMatch = matchDateTime.plusDays(3);

        boolean isReportTime = currentDateTime.isAfter(twoHoursAfterMatch);
        boolean isReportDay = currentDateTime.isBefore(threeDaysBeforeMatch);
        
        boolean isReport = isReportTime && isReportDay;
		
		req.setAttribute("players", players);
		req.setAttribute("isReport", isReport);
	    req.getRequestDispatcher("/WEB-INF/views/user/UserMatchPlayer.jsp").forward(req, resp);
	        
	    return null;
		
	}

}
