package net.report.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.report.db.ReportBean;
import net.report.db.ReportDAO;

public class ReportAddAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ReportDAO reportdao = new ReportDAO();
		ReportBean reportBean = new ReportBean();
		ActionForward forward = new ActionForward();
		
		try {
            // 파라미터를 HttpServletRequest에서 직접 가져오고 Multirequest 삭제 = 첨부파일 안받음
            reportBean.setReport_ref_id(Integer.parseInt(req.getParameter("inquiry_ref_idx")));
            reportBean.setTitle(req.getParameter("title"));
            reportBean.setContent(req.getParameter("content"));
            reportBean.setReport_type(req.getParameter("report_type"));

            // 글 등록 처리
            boolean result = reportdao.reportInsert(reportBean);
            if (!result) {
                System.out.println("신고를 하지 못했습니다. 다시 시도해주세요.");
                forward.setPath("/WEB-INF/views/error/error.jsp");
                req.setAttribute("message", "신고 내용 등록에 실패했습니다.");
                forward.setRedirect(false);
            } else {
                System.out.println("신고가 완료되었습니다.");
                forward.setRedirect(true);
                forward.setPath("/Shoots/index.jsp"); // 이동할 경로 지정
            }
            return forward;
        } catch (Exception e) {
            e.printStackTrace();
            forward.setPath("/WEB-INF/views/error/error.jsp");
            req.setAttribute("message", "신고에 실패했습니다.");
            forward.setRedirect(false);
            return forward;
        }
    }
}