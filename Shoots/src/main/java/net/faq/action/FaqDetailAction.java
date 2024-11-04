package net.faq.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;

import net.faq.db.*;

public class FaqDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		FaqDAO dao = new FaqDAO();
		
		
		int id = Integer.parseInt(req.getParameter("id"));
		FaqBean fb = dao.getDetail(id);
		
		ActionForward forward = new ActionForward();
		
		if(fb == null) {
			System.out.println("상세보기 실패");
			req.setAttribute("message", "데이터를 읽지 못했습니다");
			forward.setPath("/WEB-INF/views/error/error.jsp");
		}else {
			System.out.println("상세보기 성공");
			//fb 객체를 request 객체에 저장합니다.
			req.setAttribute("fb", fb);
			forward.setPath("/WEB-INF/views/faq/faqDetail.jsp");	//글 내용 보기 페이지로 이동하기 위해 경로 설정
		}
		
		forward.setRedirect(false);
		return forward;
	}

}
