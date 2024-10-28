package net.board.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.board.db.BoardDAO;
import net.comment.action.Action;
import net.comment.action.ActionForward;

public class BoardModifyAction implements Action {

	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		BoardDAO boardDAO = new BoardDAO();
		
		//parameter로 전달받은 글 번호
		int num = Integer.parseInt(req.getParameter("num"));
		
		//글 내용 불러와서 BOARDDATA 객체에 저장.
		BoardBean boarddata = boardDAO.getDetail(num);
		
		//글 내용 불러오기 실패한 경우
		if(boarddata == null) {
			System.out.println("(수정)상세보기 실패");
			req.setAttribute("message","게시판 수정 상세보기 실패.");
			forward.setPath("/WEB-INF/views/error/error.jsp");
		} else {
			System.out.println("(수정) 상세보기 성공");
			//수정 form 페이지로 이동할 때 원문 글 내용 보여주기 때문에 boarddata 객체를
			//request 객체에 저장함.
			req.setAttribute("boarddata", boarddata);
			
			//글 수정 form 페이지로 이동하기 위해 path 설정.
			forward.setPath("/WEB-INF/views/board/boardModify.jsp");
		}
		forward.setRedirect(false);
		return forward;
	}

}
