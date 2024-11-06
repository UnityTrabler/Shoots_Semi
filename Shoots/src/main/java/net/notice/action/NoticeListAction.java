package net.notice.action;

import java.io.IOException;
import java.util.List;

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
		
		//리스트를 받아옵니다
		list = dao.getList();
		
		req.setAttribute("listcount", listcount);
		req.setAttribute("totallist", list);
		forward.setPath("/WEB-INF/views/notice/noticeList.jsp");
		forward.setRedirect(false);
		return forward;
		
	}
	
	

}
