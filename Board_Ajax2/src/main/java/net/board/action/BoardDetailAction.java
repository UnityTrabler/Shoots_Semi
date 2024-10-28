package net.board.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.board.db.BoardDAO;
import net.comment.action.Action;
import net.comment.action.ActionForward;

public class BoardDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		BoardDAO boarddao = new BoardDAO();
		
		//글번호 파라미터값을 num 변수에 저장함
		int num = Integer.parseInt(req.getParameter("num"));
				
		// boards/list 에서 boards/detail로 이동 후 sessionREferer 값 확인
		HttpSession session = req.getSession();
		String sessionReferer = (String) session.getAttribute("referer");
		
		if(sessionReferer != null && sessionReferer.equals("list")) {
			//특정 주소로부터 이동을 확인하는데 사용할ㅇ 수 있는 정보는 request Header의 "referer"에 있다.
			String headerReferer = req.getHeader("referer");
			if(headerReferer != null && headerReferer.contains("boards/list")) {
				//내용을 확인할 글의 조회수를 증가시킴.
				boarddao.setReadCountUpdate(num);
				System.out.println("count 증가");
			}
			session.removeAttribute("referer");
		}
				
		//글의 내용을 DAO에서 읽은 후 얻은 결과를 boarddata 객체에 저장함.
		BoardBean boarddata = boarddao.getDetail(num);
		
		ActionForward forward = new ActionForward();
		//boarddatra=null; //error 테스트를 위한 값 설정
		//DAO에서 글 내용을 읽지 못하면 null로 반환
		if(boarddata ==null) {
			System.out.println("상세보기 실패");
			req.setAttribute("message", "데이터를 읽지 못했음");
			forward.setPath("/WEB-INF/views/error/error.jsp");
		} else {
			System.out.println("상세보기 성공");
			//boarddata 객체를 req 객체에 저장함
			req.setAttribute("boarddata",boarddata);
			forward.setPath("/WEB-INF/views/board/boardView.jsp"); //글 내용 보기 페이지로 이동하기 위해 경로 설정
		}
		forward.setRedirect(false);
		return forward;
		
		}
		
		
	}


