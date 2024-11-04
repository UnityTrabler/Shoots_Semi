package net.inquiry.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;

public class InquiryWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		ActionForward forward= new ActionForward();
		forward.setRedirect(false); //포워딩 방식으로 주소가 바뀌지 않음 : setRedirect(false)는 포워딩방식임
		forward.setPath("/WEB-INF/views/inquiry/inquiryWrite.jsp");
		return forward;
	}

}
