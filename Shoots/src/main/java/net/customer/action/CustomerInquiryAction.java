package net.customer.action;

import java.io.IOException;
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
import net.inquiry.db.InquiryBean;
import net.inquiry.db.InquiryDAO;

public class CustomerInquiryAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		InquiryDAO inquirydao = new InquiryDAO();
		List<InquiryBean> inquirylist = new ArrayList<InquiryBean>();
		HttpSession session = req.getSession(); //세션 설정
		
		//세션에서 idx, usertype (개인/기업) 값 받아옴
		int idx = (int) session.getAttribute("idx");
		System.out.println("idx = " + idx);
		String usertype = (String) session.getAttribute("userClassification");
		System.out.println("usertype  = " + usertype );
		
		//세션에서 받아온 회원의 유형이 regular 면 A, business면 B로 파타미터를 바꿔서 전달해줌. Inquiry 테이블에선 유형이 A랑 B로만 구별하기 때문.
			if (usertype.equals("regular")) {
				usertype = "A";
				}
			if (usertype.equals("business")) {
				usertype = "B";
			}
		
		// /boards/list 에서 /boards/detail로 접속하는 경우에만 카운트 되도록 하기 위해 세션에 저장함.
		req.getSession().setAttribute("referer", "list");
		
		//로그인 성공시 파라미터 page가 없어서 초기값이 필요함.
		int page = 1; // 보여줄 page
		int limit = 10; //한 페이지에 보여줄 게시판 목록 수
		if (req.getParameter("page") != null) {
			page=Integer.parseInt(req.getParameter("page"));
		}
		System.out.println("넘어온 페이지 = " + page);
		
		//추가
		if (req.getParameter("limit") != null) {
			limit = Integer.parseInt(req.getParameter("limit"));
		}
		System.out.println("넘어온 limit = " + limit);
		
		//총 리스트 수를 받아옴
		int listcount = inquirydao.getListCount(usertype, idx);
		
		//리스트를 받아옴
		inquirylist = inquirydao.getInquiryList(page, limit, idx, usertype);
	
		
		int maxpage = (listcount + limit - 1) / limit;
		System.out.println("총페이지 수 = " + maxpage);
		
		

		int startpage = ((page - 1) / 10) * 10 + 1;
		System.out.println("현재 페이지에 보여줄 시작 페이지 수 : " + startpage);
		
		//endpage : 현재 페이지 그룹에서 보여줄 마지막 페이지 수 ([10], [20], [30] 등 ...)
		int endpage = startpage + 10 -1;
	
		
		if (endpage > maxpage)
			endpage = maxpage;
		
		System.out.println("현재 페이지에 보여줄 마지막 페이지 수 : " + endpage);
		String state = req.getParameter("state");
		
		if(state == null) {
			System.out.println("state ==null");
			req.setAttribute("page", page); // 현재 페이지 수
			req.setAttribute("maxpage", maxpage); // 최대 페이지 수
			
			//현재 페이지에 표시할 첫 페이지 수
			req.setAttribute("startpage", startpage); //
			
			//현재 페이지에 표시할 끝 페이지 수
			req.setAttribute("endpage", endpage); //
			
			req.setAttribute("listcount", listcount); // 총 글 
			
			//해당 페이지의 글 목록을 갖고있는 리스트
			req.setAttribute("inquirylist", inquirylist); // 총 글 
			req.setAttribute("limit", limit);
			req.setAttribute("usertype", usertype);
			
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			
			//글 목록 페이지로 이동하기 위해 경로를 설정함.
			forward.setPath("/WEB-INF/views/inquiry/inquiryList.jsp");
			return forward;
		} else {
			System.out.println("state=ajax");
			
			//위에서 request로 담았던 것을 JsonObject에 담는다
			JsonObject object = new JsonObject();
			object.addProperty("page",page ); //{"page": 변수 page의 값 저장} 형식으로 저장
			object.addProperty("maxpage", maxpage);
			object.addProperty("startpage", startpage);
			object.addProperty("endpage", endpage);
			object.addProperty("listcount", listcount);
			object.addProperty("limit",limit );
			object.addProperty("usertype", usertype);
			
			//JsonObject에 List 형식을 담을 수 있는 addProperty() 존재하지 않음.
			//void com.google.gson.JsonObject.add(String property, JsonElement value) 메서드를 통해
			//List 형식을 JsonElement로 바꿔줘야 object에 저장 가능.
			
			//List => JsonElement
			JsonElement je = new Gson().toJsonTree(inquirylist);
			System.out.println("inquirylist=" +je.toString());
			object.add("inquirylist", je);
			
			resp.setContentType("application/json;charset=utf-8");
			resp.getWriter().print(object);
			System.out.println(object.toString());
			return null;
		} //else 
		
	}//execute

}//class
