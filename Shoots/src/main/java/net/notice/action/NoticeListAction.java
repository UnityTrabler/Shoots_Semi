package net.notice.action;

import java.io.IOException;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import java.util.ArrayList;

import net.notice.db.*;

public class NoticeListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		NoticeDAO dao = new NoticeDAO();
		
		List<NoticeBean> list = new ArrayList<NoticeBean>();
		req.getSession().setAttribute("referer", "noticelist");
		
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
		
		//총 리스트 수를 받아옵니다.
		int listcount = dao.getListCount();
		
		//리스트를 받아옵니다 - 여기서부터 수정 list = dao.getList();
		list = dao.getNoticeList(page, limit);
		
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
			
			req.setAttribute("page", page); // 현재 페이지 수
			req.setAttribute("maxpage", maxpage); // 최대 페이지 수
			req.setAttribute("startpage", startpage); // 현재 페이지에 표시할 첫 페이지 수
			req.setAttribute("endpage", endpage); // 현재 페이지에 표시할 끝 페이지 수
			req.setAttribute("listcount", listcount); // 총 글의 수
			req.setAttribute("totallist", list); // 해당 페이지의 글 목록을 갖는 리스트
			req.setAttribute("limit", limit);
			
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/notice/noticeList.jsp");
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
			System.out.println("noticeList = " + je.toString());
			object.add("noticeList", je);
			
			resp.setContentType("application/json;charset=utf-8");
			resp.getWriter().print(object);
			System.out.println(object.toString());
			return null;
		}
		
		/*
		req.setAttribute("listcount", listcount);
		req.setAttribute("totallist", list);
		forward.setPath("/WEB-INF/views/notice/noticeList.jsp");
		forward.setRedirect(false);
		return forward;
		*/
		
	}
	
	

}
