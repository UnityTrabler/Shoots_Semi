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

public class BusinessSalesAction implements Action {

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
		
		String state = req.getParameter("state");

		int total = 0;
		
		int listcount = dao.getListCount(idx, year, month);
		list = dao.getMatchListById(idx, year, month);
		
		for (MatchBean match : list) {
	        int playerCount = pdao.getPaymentCountById(match.getMatch_id());
	        match.setPlayerCount(playerCount);
	        
	        System.out.println(match);
	        
	        int price = match.getPrice();
	        
	        total = price * playerCount;
	        match.setTotal(total);
		}
		
		if (state == null) {
			System.out.println("state == null");

			req.setAttribute("listcount", listcount); 
			req.setAttribute("list", list);

			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/business/BusinessSales.jsp");
			return forward;
		} else {
			System.out.println("state = ajax");
			
			JsonObject object = new JsonObject();
			
			object.addProperty("listcount", listcount);
	        System.out.println("============================ " + list);

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
