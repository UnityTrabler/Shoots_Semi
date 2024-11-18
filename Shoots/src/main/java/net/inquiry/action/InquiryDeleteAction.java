package net.inquiry.action;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;
import net.inquiry.db.InquiryDAO;

public class InquiryDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		int num = Integer.parseInt(req.getParameter("num"));
		InquiryDAO inquirydao = new InquiryDAO();
		
		//관리자인지 확인하기 위해 세션값 받아두려고 객체 생성
		HttpSession session = req.getSession();
		String role = (String) session.getAttribute("role");
		
		//삭제 처리
		boolean result = inquirydao.inquiryDelete(num);
		
		//삭제 처리 실패한 경우
		if (!result) {
			System.out.println("문의글 삭제에 실패했습니다.");
			ActionForward forward= new ActionForward();
			forward.setRedirect(false);
			req.setAttribute("message", "데이터를 삭제하지 못했습니다.");
			forward.setPath("WEB-INF/views/error/error.jsp");
			return forward;
		}else {//삭제 처리 성공한 경우 - 글 목록 보기 요청을 전송하는 부분임.
			
			//관리자 페이지에서 문의글을 삭제 했을 경우 다시 관리자페이지의 문의 리스트 경로로 이동
			if ("admin".equals(role)) {
			System.out.println("문의글을 삭제했습니다.");
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>");
			out.print("alert('관리자 페이지에서 문의글을 성공적으로 삭제했습니다.');");
			out.print("location.href='../admin/mypage';");
			out.print("</script>");
			out.close();
			return null;
			}
			else {
				//일반 회원의 본인 글을 삭제 했을 경우 다시 본인의 문의글 리스트가 뜨게 일반 문의리스트 경로로 이동
				System.out.println("문의글을 삭제했습니다.");
				resp.setContentType("text/html;charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.print("<script>");
				out.print("alert('문의글을 성공적으로 삭제했습니다.');");
				out.print("location.href='list';");
				out.print("</script>");
				out.close();
				return null;
				
			}
		}
	
		
	} //if(!result)

}
