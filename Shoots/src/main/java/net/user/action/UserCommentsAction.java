package net.user.action;

import java.io.IOException;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.comment.db.CommentBean;
import net.comment.db.CommentDAO;
import net.core.Action;
import net.core.ActionForward;

public class UserCommentsAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		CommentDAO dao = new CommentDAO();
		
		HttpSession session = req.getSession();
		int idx = (int) session.getAttribute("idx");
		System.out.println("로그인 = " + idx);
		
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
		
		int listcount = dao.getListCountById(idx);
		
		List<CommentBean> list = dao.getCommentById(idx, page, limit);
		
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
			forward.setPath("/WEB-INF/views/user/UserComments.jsp");
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

