package net.business.action;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;
import net.match.db.MatchBean;
import net.match.db.MatchDAO;
import net.pay.db.PaymentDAO;

public class BusinessMypostsAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		MatchDAO dao = new MatchDAO();
		
		PaymentDAO pdao = new PaymentDAO();

		HttpSession session = req.getSession();
		int idx = (int) session.getAttribute("idx");
		System.out.println("로그인 = " + idx);
		
		LocalDate now = LocalDate.now();
	    int year = now.getYear(); 
	    int month = now.getMonthValue();
	    
	    int selectedYear = now.getYear();
	    req.setAttribute("selectedYear", selectedYear);
	    
	    int selectedMonth = now.getMonthValue();
	    req.setAttribute("selectedMonth", selectedMonth);
	    
	    if (req.getParameter("year") != null) {
	        try {
	            year = Integer.parseInt(req.getParameter("year"));
	        } catch (NumberFormatException e) {
	            year = now.getYear();
	        }
	    }

	    if (req.getParameter("month") != null) {
	        try {
	            month = Integer.parseInt(req.getParameter("month"));
	        } catch (NumberFormatException e) {
	            month = now.getMonthValue();
	        }
	    }
	    
		List<MatchBean> list = new ArrayList<MatchBean>();
		
		req.getSession().setAttribute("referer", "list"); 
		
		int page = 1;
		int limit = 10;
		if (req.getParameter("page") != null) {
			page = Integer.parseInt(req.getParameter("page"));
		}
		System.out.println("넘어온 페이지 = " + page);
		
		if (req.getParameter("limit") != null) {
			limit = Integer.parseInt(req.getParameter("limit"));
		}
		System.out.println("넘어온 limit = " + limit);
		
		int listcount = dao.getListCount(idx, year, month);
		
		list = dao.getMatchListById(page, limit, idx, year, month);
		
		for (MatchBean match : list) {
	        int playerCount = pdao.getPaymentCountById(match.getMatch_id());
	        match.setPlayerCount(playerCount);
	    }
		
		int maxpage = (listcount + limit - 1) / limit;
		System.out.println("총 페이지수 = " + maxpage);
		
		int startpage = ((page - 1) / 10) * 10 + 1;
		System.out.println("현제 페이지에 보여줄 시작 페이지 수 : " + startpage);
		
		int endpage = startpage + 10 - 1;
		
		if (endpage > maxpage)
			endpage = maxpage;
		
		System.out.println("현재 페이지에 보여줄 마지막 페이지 수 : " + endpage);
		String state = req.getParameter("state");
		
		if (state == null) {
			System.out.println("state == null");
			
			req.setAttribute("page", page);
			req.setAttribute("maxpage", maxpage);
			req.setAttribute("startpage", startpage); 
			req.setAttribute("endpage", endpage);
			req.setAttribute("listcount", listcount); 
			req.setAttribute("list", list); 
			req.setAttribute("limit", limit);
			
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/business/BusinessMyposts.jsp");
			return forward;
		} else {
			System.out.println("state = ajax");
			
			JsonObject object = new JsonObject();
			
			object.addProperty("page", page);
			object.addProperty("maxpage", maxpage);
			object.addProperty("startpage", startpage);
			object.addProperty("endpage", endpage);
			object.addProperty("listcount", listcount);
			object.addProperty("limit", limit);
			
			// JsonObject에 List 형식을 담을 수 있는 addProperty() 는 존재하지 않음
			/* void com.google.gson.JsonObject.add(String property, JsonElement value) 메서드
			   를 통해 저장, List 형식을 JsonElement로 바꾸어 주어야 object에 저장 할 수 있음 */
			
			// List -> JsonElement
			JsonElement je = new Gson().toJsonTree(list);
			System.out.println("list = " + je.toString());
			object.add("list", je);
			
			resp.setContentType("application/json;charset=utf-8");
			resp.getWriter().print(object);
			System.out.println(object.toString());
			return null;
		}
	}
}