package net.faq.action;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.faq.db.*;

public class FaqDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		int id = Integer.parseInt(req.getParameter("id"));
		FaqDAO dao = new FaqDAO();
		
		//faqDelete()메서드를 사용해 내용 삭제
		int result = dao.faqDelete(id);
		if(result == 0) {
			System.out.println("faq 삭제 실패");
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			req.setAttribute("message", "데이터를 삭제하지 못했습니다");
			forward.setPath("/WEB-INF/views/error/error.jsp");
			return forward;
		}else {
			System.out.println("faq 삭제 성공");
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>");
			out.print("alert('삭제되었습니다.');");
			out.print("location.href='faqPay';");
			out.print("</script>");
			out.close();
			return null;
		}

	}

}
