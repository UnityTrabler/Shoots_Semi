package net.user.action;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.user.db.UserBean;
import net.user.db.UserDAO;

public class UserMatchPlayerAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		int match_id = Integer.parseInt(req.getParameter("match_id"));
		
		UserDAO dao = new UserDAO();
		List<UserBean> players = dao.getPlayerByMatchId(match_id);
		
		req.setAttribute("players", players);
	    req.getRequestDispatcher("/WEB-INF/views/user/UserMatchPlayer.jsp").forward(req, resp);
	        
	    return null;
		
	}

}
