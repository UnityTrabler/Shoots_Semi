package net.inquiry.action;

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

public class InquiryListAction implements Action {

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
		
		/*
		 총 페이지 수 = (DB에 저장된총 리스트 수 + 한 페이지에서 보여주는 리스트의 수 - 1) / 한 페이지에서 보여주는 리스트의 수
		 
		 예를 들어 한 페이지에서 보여주는 리스트의 수가 10개인 경우
		 ex1) DB에 저장된 총 리스트의 수가 0이면 총 페이지수는 0페이지 
		 ex1) DB에 저장된 총 리스트의 수가 (1~10)이면 총 페이지수는 1페이지
		 ex1) DB에 저장된 총 리스트의 수가 (11~20)이면 총 페이지수는 2페이지
		 ex1) DB에 저장된 총 리스트의 수가 (21~30)이면 총 페이지수는 3페이지
		 */
		
		int maxpage = (listcount + limit - 1) / limit;
		System.out.println("총페이지 수 = " + maxpage);
		
		/*
		 startpage : 현재 페이지 그룹에서 맨 처음에 표시될 페이지 수를 의미함.
		 ([1], [11], [21] 등...) 보여줄 페이지가 30개일 경우
		 [1][2][3]...[30] 까지 다 표시하기에는 너무 많기 때문에 보통 한 페이지에는
		 10페이지 정도까지 이동할 수 있게 표시함.
		 예) 페이지 그룹이 아래와 같은 경우
		 [1][2][3][4][5][6][7][8][9][10]
		 페이지 그룹의 시작페이지는 startpage에 마지막 페잊디는 endpage에 구함.
		 
		 예로 1~10페이지는 내용을 나타날땐 페이지 그룹은 [1][2][3]...[10]으로 표시하고
		 11~20페이지 내용을 나타날떄 페이지 그룹은 [11][12][13]...[20]까지 표시됨
		 */

		int startpage = ((page - 1) / 10) * 10 + 1;
		System.out.println("현재 페이지에 보여줄 시작 페이지 수 : " + startpage);
		
		//endpage : 현재 페이지 그룹에서 보여줄 마지막 페이지 수 ([10], [20], [30] 등 ...)
		int endpage = startpage + 10 -1;
		
		/*
		 마지막 그룹의 마지막 페이지 값은 최대 페이지값임.
		 예로 마지막 페이지 그룹이 [21]~[30]인 경우
		 시작 페이지는 21(startpage=21)과 마지막 페이지는 30(endpage=30)이지만
		 최대페이지 (maxpage)가 25라면 [21]~[25]까지만 표시되도록 함. 
		 */
		
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
