package net.admin.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.report.db.*;

public class AdminReportDetail implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ReportDAO dao = new ReportDAO();
		
		int id = Integer.parseInt(req.getParameter("id"));
		ReportBean rb = dao.getDetail(id);
		
		ActionForward forward = new ActionForward();
		
		if(rb == null) {
			System.out.println("상세보기 실패");
			req.setAttribute("message", "데이터를 읽지 못했습니다");
			forward.setPath("/WEB-INF/views/error/error.jsp");
		}else {
			System.out.println("상세보기 성공");
			//rb 객체를 request 객체에 저장합니다.
			req.setAttribute("rb", rb);
			forward.setPath("/WEB-INF/views/admin/reportDetail.jsp");	//글 내용 보기 페이지로 이동하기 위해 경로 설정
		}
		
		forward.setRedirect(false);
		return forward;
	}

}
