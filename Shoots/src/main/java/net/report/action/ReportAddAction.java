package net.report.action;

import java.io.IOException;
import java.io.PrintWriter;

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
		ReportBean rb = new ReportBean();
		ActionForward forward = new ActionForward();
		
		
		try {
            // 파라미터를 HttpServletRequest에서 직접 가져오고 Multirequest 삭제 = 첨부파일 안받음
			
			System.out.println("report_ref_id: " + req.getParameter("report_ref_id"));
			System.out.println("reporter: " + req.getParameter("reporter"));
			System.out.println("target: " + req.getParameter("target"));
			System.out.println("title: " + req.getParameter("title"));
			System.out.println("content: " + req.getParameter("content"));
			
			//rb.setReport_ref_id(Integer.parseInt(req.getParameter("report_ref_id"))); //아직 못받아옴
			rb.setReport_ref_id(Integer.parseInt(req.getParameter("report_ref_id")));
			rb.setReporter(Integer.parseInt(req.getParameter("reporter")));
			rb.setTarget(Integer.parseInt(req.getParameter("target"))); //신고당할 사람, 글의 detail?num 에서 글의 작성자를 뽑아와야함
            rb.setTitle(req.getParameter("title"));
            rb.setContent(req.getParameter("content"));
            rb.setReport_type(req.getParameter("report_type"));
            // 글 등록 처리
            boolean result = reportdao.reportInsert(rb);
            if (!result) {
                System.out.println("신고를 하지 못했습니다. 다시 시도해주세요.");
                //forward.setPath("/WEB-INF/views/error/error.jsp");
                req.setAttribute("message", "신고 내용 등록에 실패했습니다.");
                
                //신고 실패시 alert창 + 뒤로가기
                PrintWriter out = resp.getWriter();
                out.print("<script>"
                		+ "alert('신고에 실패했습니다. 다시 시도해 주세요.')"
                		+ "histroy.back();"
                		+ "</script>");
                out.close();
                return null; 
 
            } else {
                System.out.println("신고가 완료되었습니다.");
                
    			resp.setContentType("text/html;charset=utf-8");
    			PrintWriter out = resp.getWriter();
    			out.print("<script>");
    			out.print("alert('신고가 완료되었습니다.');");
    			out.print("location.href = '/Shoots/index.jsp';");
    			out.print("</script>");
    			out.close();
    			
    			 return null;

            }
        } catch (Exception e) {
            e.printStackTrace();
            forward.setPath("/WEB-INF/views/error/error.jsp");
            req.setAttribute("message", "신고에 실패했습니다.");
            forward.setRedirect(false);
            return forward;
        }
    }
}