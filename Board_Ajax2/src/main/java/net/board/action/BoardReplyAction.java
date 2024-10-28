package net.board.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.board.db.BoardDAO;
import net.comment.action.Action;
import net.comment.action.ActionForward;

public class BoardReplyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		ActionForward forward = new ActionForward();
		BoardDAO boarddao = new BoardDAO();
		
		//파라미터로 전달받은 수정할 글 번호를 num변수에 저장합니다.
		int num = Integer.parseInt(request.getParameter("num"));
		
		//글 번호 num에 해당하는 내용을 가져와서 boarddata객체에 저장합니다.
		BoardBean boarddata = boarddao.getDetail(num);
		
		//글 내용이 없는 경우
		if(boarddata == null) {
			System.out.println("원본글이 존재하지 않습니다.");
			request.setAttribute("message", "원본글이 존재하지 않습니다.");
			forward.setPath("/WEB-INF/views/error/error.jsp");
		}else {
			
			System.out.println("답변 페이지 이동 완료");
			//답변 폼 페이지로 이동할 때 원문 글 내용을 보여주기 위해 
			//boarddata 객체를 request 객체에 저장합니다.
			request.setAttribute("boarddata", boarddata);
			
			//글 답변 페이지 경로 지정합니다.
			forward.setPath("/WEB-INF/views/board/boardReply.jsp");
		}
		forward.setRedirect(false);
		return forward;
	}// execute end

}//class end
