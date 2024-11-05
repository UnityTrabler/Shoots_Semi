package net.notice.action;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;

import net.notice.db.*;

public class NoticeListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		NoticeDAO dao = new NoticeDAO();
		
		List<NoticeBean> list = null;
		list = dao.getList();
		req.setAttribute("totallist", list);
		forward.setPath("/WEB-INF/views/notice/noticeList.jsp");
		forward.setRedirect(false);
		return forward;
		
	}
	
	

}
