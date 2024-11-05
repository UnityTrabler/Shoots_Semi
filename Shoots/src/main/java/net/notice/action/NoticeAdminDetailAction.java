package net.notice.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.notice.db.NoticeBean;
import net.notice.db.NoticeDAO;

public class NoticeAdminDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		NoticeDAO dao = new NoticeDAO();
		
		int id = Integer.parseInt(req.getParameter("id"));
		NoticeBean nb = dao.getDetail(id);
		
		ActionForward forward = new ActionForward();
		
		if(nb == null) {
			System.out.println("공지사항 상세보기 실패");
			req.setAttribute("message", "데이터를 읽지 못했습니다");
			forward.setPath("/WEB-INF/views/error/error.jsp");
		}else {
			System.out.println("상세보기 성공");
			//fb 객체를 request 객체에 저장합니다.
			req.setAttribute("nb", nb);
			forward.setPath("/WEB-INF/views/notice/noticeAdminDetail.jsp");	//글 내용 보기 페이지로 이동하기 위해 경로 설정
		}
		
		forward.setRedirect(false);
		return forward;
	}

}
