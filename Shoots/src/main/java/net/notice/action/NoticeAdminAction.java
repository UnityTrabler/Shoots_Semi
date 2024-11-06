package net.notice.action;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.notice.db.*;

public class NoticeAdminAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		NoticeDAO dao = new NoticeDAO();
		
		List<NoticeBean> list = null;
		
		//총 리스트 수를 받아옵니다.
		int listcount = dao.getListCount();
				
		//리스트를 받아옵니다
		list = dao.getList();
		
		req.setAttribute("listcount", listcount);
		req.setAttribute("totallist", list);
		forward.setPath("/WEB-INF/views/notice/noticeAdmin.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
