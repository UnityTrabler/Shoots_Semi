package net.board.action;

import java.io.IOException;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.board.db.BoardDAO;
import net.comment.action.Action;
import net.comment.action.ActionForward;

public class BoardAddAction implements Action {

	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		BoardDAO boardDAO = new BoardDAO();
		BoardBean boardBean = new BoardBean();
		ActionForward forward = new ActionForward();
		
		String realFolder = "";
		String saveFolder = "boardupload";
		int fileSize = 5 * 1024 * 1024; //file upload maximum size 5MB
		
		//실제 저장 경로 지정
		ServletContext sc = req.getServletContext();
		realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder= "+ realFolder);
		try {
			MultipartRequest multi = new MultipartRequest(req, realFolder, fileSize, "utf-8", new DefaultFileRenamePolicy());
			boardBean.setBoard_name(multi.getParameter("board_name"));
			boardBean.setBoard_pass(multi.getParameter("board_pass"));
			boardBean.setBoard_subject(multi.getParameter("board_subject"));
			boardBean.setBoard_content(multi.getParameter("board_content"));
			
			//시스템 상에 업로드 된 실제 파일명 얻어 옴.
			 String filename = multi.getFilesystemName("board_file");
			 boardBean.setBoard_file(filename);
			 
			 //글 등록 처리 위해 boardInsert() 호출.
			 //글 등록 form에서 입력한 정보가 저장되어 있는 boardBean객체를 전달함.
			 boolean result = boardDAO.boardInsert(boardBean);
			 
			 //글 등록 실패할 경우 false
			 if(!result) {
				 System.out.println("게시판 등록 실패");
				 forward.setPath("/WEB-INF/views/error/error.jsp");
				 req.setAttribute("message", "게시판 등록 실패입니다.");
				 forward.setRedirect(false);
			 }
			 else {
				 System.out.println("게시판 등록 완료");
				 //글 등록이 완료되면 글 목록을 보여주기 위해 "boards/list"로 이동함.
				 forward.setRedirect(true);
				 forward.setPath("list"); //이동할 경로 지정.
			 }
			 return forward;
		} catch (Exception e) {
			e.printStackTrace();
			 forward.setPath("/WEB-INF/views/error/error.jsp");
			 req.setAttribute("message", "게시판 업로드 실패입니다.");
			 forward.setRedirect(false);
			 return forward;
		}
	}

}
