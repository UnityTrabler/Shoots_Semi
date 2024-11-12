package net.post.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.post.db.PostBean;
import net.post.db.PostDAO;

public class PostListAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 카테고리 파라미터 받기 (기본값은 A)
		String category = request.getParameter("category");
		if (category == null || category.isEmpty()) 
			category = "A"; // 기본값 설정
		
		
		PostDAO postdao = new PostDAO();
		List<PostBean> postlist = new ArrayList<PostBean>();
		
		
		
		// boards/list 에서 boards/detail로 접속하는 경우에만 카운트 되도록하기 위해 세션에 저장합니다.
		// 새로고침으로 조회수 올리는거 방지
		request.getSession().setAttribute("referer", "list");
		request.getSession().setAttribute("postlist", "list");
		request.getSession().setAttribute("category", category);
		// 로그인 성공시 파라미터 page가 없어요. 그래서 초기값이 필요합니다.
		int page = 1; // 보여줄 page
		int limit = 10; // 한 페이지에 보여줄 게시판 목록의 수
		
		if (request.getParameter("page") != null) 
			page = Integer.parseInt(request.getParameter("page"));

		System.out.println("넘어온 페이지" + page);

		// 추가
		if (request.getParameter("limit") != null) 
			limit = Integer.parseInt(request.getParameter("limit"));
		
		System.out.println("넘어온 limit =" + limit);

		// 총 리스트 수를 받아옵니다.
		int listcount = postdao.getListCount(category);

		// 리스트를 받아옵니다.
		postlist = postdao.getPostList(category, page, limit);

		int maxpage = (listcount + limit - 1) / limit;

		int startpage = ((page - 1) / 10) * 10 + 1;

		int endpage = startpage + 10 - 1;

		System.out.println("현재 페이지에 보여줄 시작 페이지 수 :" + startpage);

		if (endpage > maxpage)
			endpage = maxpage;

		System.out.println("현재 페이지에 보여줄 마지막 페이지 수:" + endpage);

		String state = request.getParameter("state");
		System.out.println("state " + state);
		System.out.println("page " + request.getParameter("page"));
		if (state == null) { // 일반 요청 (페이지 전환)
			// JSP에 전달할 값들
			request.setAttribute("category", category);
			request.setAttribute("page", page); // 현재 페이지 수
			request.setAttribute("maxpage", maxpage); // 최대 페이지 수
			request.setAttribute("startpage", startpage); // 현재 페이지에 표시할 첫 페이지 수
			request.setAttribute("endpage", endpage); // 현재 페이지에 표시할 끝 페이지 수
			request.setAttribute("listcount", listcount); // 총 글의 수
			request.setAttribute("postlist", postlist); // 해당 페이지의 글 목록을 갖고 있는 리스트
			request.setAttribute("limit", limit);
			// ActionForward 객체 반환
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);

			// 글 목록 페이지로 이동하기 위해 경로를 설정합니다.
			forward.setPath("/WEB-INF/views/post/postList.jsp");
			return forward;
		} else { // AJAX 요청
			// JsonObject로 반환하기 위한 설정
			// 위에서 request로 담았던 것을 JsonObject에 담습니다.
			// JSON 응답을 위한 JsonObject 생성
			JsonObject object = new JsonObject();

			object.addProperty("category", category);
			object.addProperty("page", page); // {"page": 변수 page의 값} 형식으로 저장
			object.addProperty("maxpage", maxpage);
			object.addProperty("startpage", startpage);
			object.addProperty("endpage", endpage);
			object.addProperty("listcount", listcount);
			object.addProperty("limit", limit);
			// JsonObject에 List 형식을 담을 수 있는 addProperty() 존재하지 않습니다.
			// void com.google.gson.JsonObject.add(String property, JsonElement value) 메서드를
			// 통해서 저장합니다.
			// List형식을 JsonElement로 바꾸어 주어야 object에 저장할 수 있습니다.

			// List => JsonElement // List<PostBean>을 JSON으로 변환
			JsonElement je = new Gson().toJsonTree(postlist);
			System.out.println("postlist=" + je.toString());
			object.add("postlist", je);

			// JSON 응답 처리
			response.setContentType("application/json;charset=utf-8");
			response.getWriter().print(object);
			System.out.println(object.toString());
			return null;
		} // else end
	}// execute end
}
