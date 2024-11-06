package net.notice.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;

import net.notice.db.*;

public class NoticeUpdateAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		NoticeDAO dao = new NoticeDAO();
		
		//파라미터로 전달받은 값 id(=notice_id)를 변수 id에 저장
		int id = Integer.parseInt(req.getParameter("id")); 
		
		NoticeBean nb = dao.getDetail(id);
		
		//글 내용 불러오기 실패한 경우입니다.
		if(nb == null) {
			System.out.println("(수정)공지 상세보기 실패");
			req.setAttribute("message", "FAQ게시판 수정 상세 보기 실패입니다.");
			forward.setPath("/WEB-INF/views/error/error.jsp");
		} else {
			System.out.println("(수정)공지 상세보기 성공");
			
			//수정 폼 페이지로 이동할 때 원문 글 내용을 보여주기 때문에 fb객체를 
			//req 객체에 저장합니다.
			req.setAttribute("nb", nb);
					
			//글 수정 폼 페이지로 이동하기 위해 경로를 설정합니다.
			forward.setPath("/WEB-INF/views/notice/noticeUpdate.jsp");
		}
		forward.setRedirect(false);
		return forward;
		
	}

}
