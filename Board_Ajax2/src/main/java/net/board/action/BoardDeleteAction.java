package net.board.action;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.board.db.BoardDAO;
import net.comment.action.Action;
import net.comment.action.ActionForward;

public class BoardDeleteAction implements Action {

	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		int num = Integer.parseInt(req.getParameter("num"));
		
		BoardDAO boarddao = new BoardDAO();
		
		//delete request한 user가 writer인가?
		//save pwd와 input pwd 비교
		boolean usercheck = boarddao.isBoardWriter(num, req.getParameter("board_pass"));
		
		//pwd 불일치
		if(!usercheck) {
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("""
					<script>
						alert('delete pwd 불일치');
						history.back();
					</script>
					""");
			out.close();
			return null;
		}
		
		boolean result = boarddao.boardDelete(num);
		
		//삭제 실패
		if(!result) {
			System.out.println("delete failed");
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			req.setAttribute("message", "데이터 삭제 못했음.");
			forward.setPath("/WEB-INF/views/error/error.jsp");
			return forward;
		}
		else {
			System.out.println("delete successed");
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("""
					<script>
						alert('삭제 되었습니다.');
						location.href = 'list';
					</script>
					""");
			out.close();
		}
		return null;
	}

}
