package net.notice.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;
import net.notice.db.*;

public class NoticeDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		NoticeDAO dao = new NoticeDAO();
		
		int id = Integer.parseInt(req.getParameter("id"));
		
		// notice/noticeList에서 notice/detail로 이동 후 sessionReferer값 확인
		HttpSession session = req.getSession();
		session.setAttribute("referer", "noticeList");
		String sessionReferer = (String) session.getAttribute("referer");
				
		if(sessionReferer != null && sessionReferer.equals("noticeList")) {
			//특정 주소로부터의 이동을 확인하는 데 사용할 수 있는 정보는 request Header의 "refer"에 있습니다.
			String headerReferer = req.getHeader("referer");
			if(headerReferer != null && headerReferer.contains("notice/noticeList")) {
				//내용을 확인할 글의 조회수를 증가시킵니다.
				dao.setReadCountUpdate(id);
				System.out.println("count 증가");
			}
			session.removeAttribute("referer");
		}
				
		NoticeBean nb = dao.getDetail(id);
		
		ActionForward forward = new ActionForward();
		
		if(nb == null) {
			System.out.println("상세보기 실패");
			req.setAttribute("message", "데이터를 읽지 못했습니다");
			forward.setPath("/WEB-INF/views/error/error.jsp");
		}else {
			System.out.println("상세보기 성공");
			//nb 객체를 request 객체에 저장합니다.
			req.setAttribute("nb", nb);
			forward.setPath("/WEB-INF/views/notice/noticeDetail.jsp");	//글 내용 보기 페이지로 이동하기 위해 경로 설정
		}
		
		forward.setRedirect(false);
		return forward;
	}

}
