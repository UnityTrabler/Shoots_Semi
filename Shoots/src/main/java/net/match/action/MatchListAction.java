package net.match.action;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.match.db.MatchBean;
import net.match.db.MatchDAO;
import net.pay.db.PaymentDAO;

public class MatchListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		MatchDAO dao = new MatchDAO();
		
		PaymentDAO pdao = new PaymentDAO();
			
		LocalDate now = LocalDate.now();
	    int year = now.getYear(); 
	    int month = now.getMonthValue();
	    
	    int selectedYear = now.getYear();
	    request.setAttribute("selectedYear", selectedYear);
	    
	    int selectedMonth = now.getMonthValue();
	    request.setAttribute("selectedMonth", selectedMonth);
	    
	    if (request.getParameter("year") != null) {
	        try {
	            year = Integer.parseInt(request.getParameter("year"));
	        } catch (NumberFormatException e) {
	            year = now.getYear();
	        }
	    }

	    if (request.getParameter("month") != null) {
	        try {
	            month = Integer.parseInt(request.getParameter("month"));
	        } catch (NumberFormatException e) {
	            month = now.getMonthValue();
	        }
	    }
	    
		List<MatchBean> list = new ArrayList<MatchBean>();
		
		request.getSession().setAttribute("referer", "list");
		
		int page = 1;
		int limit = 10;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		System.out.println("넘어온 페이지 = " + page);
		
		if (request.getParameter("limit") != null) {
			limit = Integer.parseInt(request.getParameter("limit"));
		}
		System.out.println("넘어온 limit = " + limit);
		
		int listcount = dao.getListCount(year, month);
		System.out.println("글 갯수 = " + listcount);
		
		list = dao.getMatchList(page, limit, year, month);
		
		for (MatchBean match : list) {
	        int playerCount = pdao.getPaymentCountById(match.getMatch_id());
	        match.setPlayerCount(playerCount);
	        
	        String a = match.getMatch_date().substring(0,10) + ' ' + match.getMatch_time();
	        
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
	        LocalDateTime matchDateTime = LocalDateTime.parse(a, formatter);
	        
	        LocalDateTime currentDateTime = LocalDateTime.now();
	         
	        LocalDateTime twoHoursBeforeMatch = matchDateTime.minusHours(2);
	        
	        boolean isMatchPast = twoHoursBeforeMatch.isBefore(currentDateTime);
	        match.setMatchPast(isMatchPast);
	        
	        System.out.println("isMatchPast ============= " + match.isMatchPast()); 
	    }
		
		int maxpage = (listcount + limit - 1) / limit;
		System.out.println("총 페이지수 = " + maxpage);
		
		int startpage = ((page - 1) / 10) * 10 + 1;
		System.out.println("현제 페이지에 보여줄 시작 페이지 수 : " + startpage);
		
		int endpage = startpage + 10 - 1;
		
		if (endpage > maxpage)
			endpage = maxpage;
		
		System.out.println("현재 페이지에 보여줄 마지막 페이지 수 : " + endpage);
		String state = request.getParameter("state");
		
		if (state == null) {
			System.out.println("state == null");
			
			request.setAttribute("page", page); // 현재 페이지 수
			request.setAttribute("maxpage", maxpage); // 최대 페이지 수
			request.setAttribute("startpage", startpage); // 현재 페이지에 표시할 첫 페이지 수
			request.setAttribute("endpage", endpage); // 현재 페이지에 표시할 끝 페이지 수
			request.setAttribute("listcount", listcount); // 총 글의 수
			request.setAttribute("list", list); // 해당 페이지의 글 목록을 갖는 리스트
			request.setAttribute("limit", limit);
			
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/match/matchList.jsp");
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
			
			response.setContentType("application/json;charset=utf-8");
			response.getWriter().print(object);
			System.out.println(object.toString());
			return null;
		}
	}
}

