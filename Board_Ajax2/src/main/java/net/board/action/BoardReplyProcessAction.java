package net.board.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.board.db.BoardDAO;
import net.comment.action.Action;
import net.comment.action.ActionForward;

public class BoardReplyProcessAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		ActionForward forward = new ActionForward();
		BoardDAO boarddao = new BoardDAO();
		int result = 0;
		
		//파라미터로 넘어온 값들을 boarddata객체에 저장함
		BoardBean boarddata = new BoardBean();
		boarddata.setBoard_name(req.getParameter("board_name"));
		boarddata.setBoard_pass(req.getParameter("board_pass"));
		boarddata.setBoard_subject(req.getParameter("board_subject"));
		boarddata.setBoard_content(req.getParameter("board_content"));
		boarddata.setBoard_re_ref(Integer.parseInt(req.getParameter("board_re_ref")));
		boarddata.setBoard_re_lev(Integer.parseInt(req.getParameter("board_re_lev")));
		boarddata.setBoard_re_seq(Integer.parseInt(req.getParameter("board_re_seq")));
		
		
		//답변을  DB에 저장하기 위해 boarddata객체를 파라미터로 전달하고
		//DAO의 메서드 boardReply를 호출함.
		result = boarddao.boardReply(boarddata);
		
		//답변 저장에 실패한 경우
		if (result ==0) {
			System.out.println("답장 저장 실패");
			forward.setRedirect(false);
			req.setAttribute("message", "답장 저장 실패다.");
			forward.setPath("/WEB-INF/views/error/error.jsp");
		} else {
			//답변 저장 잘 됐을 경우
			System.out.println("답장 완료");
			forward.setRedirect(true);
			
			//답변 글 내용을 확인하기 위해 글 내용 보기 페이지를 경로로 설정함.
			forward.setPath("detail?num=" + result);
		}
		return forward;
	}

}
