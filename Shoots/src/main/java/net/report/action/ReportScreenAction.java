package net.report.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.report.db.ReportBean;
import net.report.db.ReportDAO;

public class ReportScreenAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ReportDAO inquirydao = new ReportDAO();
		List<ReportBean> inquirylist = new ArrayList<ReportBean>();
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
			//글 목록 페이지로 이동하기 위해 경로를 설정함.
			forward.setPath("/WEB-INF/views/report/postReport.jsp");
			return forward;
		}
}//class
