package net.inquiry.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.inquiry.db.InquiryBean;
import net.inquiry.db.InquiryDAO;

public class InquiryModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		ActionForward forward = new ActionForward();
		InquiryDAO inquirydao = new InquiryDAO();
		
		//파라미터로 전달받은 수정할 글 번호를 num변수에 저장함.
		int inquiryid = Integer.parseInt(req.getParameter("inquiryid"));
		
		//글 내용을 불러와서 boarddata 객체에 저장함.
		InquiryBean inquirydata = inquirydao.getDetail(inquiryid);
		
		//글 내용 불러오기 실패한 경우.
		if (inquirydata == null) {
			System.out.println("(수정)상세보기 실패");
			req.setAttribute("message", "게시판 수정 상세 보기 실패임.");
			forward.setPath("/WEB=INF/views/error/error.jsp");
		} else {
			System.out.println("(수정) 상세보기 성공");
			
			//수정 폼 페이지로 이동할 때 원문 글 내용을 보여주기 때문에 boarddata 객체를 request 객체에 저장함.
			req.setAttribute("inquirydata", inquirydata);
			
			//글 수정 폼 페이지로 이동하기 위해 경로를 설정함.
			forward.setPath("/WEB-INF/views/inquiry/inquiryModify.jsp");
		}
		forward.setRedirect(false);
		return forward;
	}

}
