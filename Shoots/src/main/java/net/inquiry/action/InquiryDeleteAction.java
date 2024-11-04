package net.inquiry.action;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.inquiry.db.InquiryDAO;

public class InquiryDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		int num = Integer.parseInt(req.getParameter("num"));
		
		InquiryDAO inquirydao = new InquiryDAO();
		//글 삭제 명령을 요청한 사용자가을 작성한 사용자인지 판단하기 위해 입력한 비밀번호와 저장된 비밀번호를 비교한 뒤 일치하면 삭제
		//아직 로그인 처리 없어서 잠시 주석처리
//		boolean usercheck = boarddao.isBoardWriter(num, req.getParameter("board_pass"));
//		
//		//비밀번호 일치하지 않을 시
//		if (!usercheck) {
//			resp.setContentType("text/html;charset=utf-8");
//			PrintWriter out = resp.getWriter();
//			out.print("<script>");
//			out.print("alert('비밀번호가 다름.');");
//			out.print("history.back();");
//			out.print("</script>");
//			out.close();
//			return null;
//		}
		
		
		//비밀번호 일치 시 삭제 처리함.
		boolean result = inquirydao.boardDelete(num);
		
		//삭제 처리 실패한 경우
		if (!result) {
			System.out.println("문의글 삭제에 실패했습니다.");
			ActionForward forward= new ActionForward();
			forward.setRedirect(false);
			req.setAttribute("message", "데이터를 삭제하지 못했습니다.");
			forward.setPath("WEB-INF/views/error/error.jsp");
			return forward;
		}else {
			//삭제 처리 성공한 경우 - 글 목록 보기 요청을 전송하는 부분임.
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

}
