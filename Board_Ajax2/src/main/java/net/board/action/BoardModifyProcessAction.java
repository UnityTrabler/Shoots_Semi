package net.board.action;

import java.io.IOException;
import java.io.PrintWriter;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.board.db.BoardDAO;
import net.comment.action.Action;
import net.comment.action.ActionForward;

public class BoardModifyProcessAction implements Action {

	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		BoardDAO boarddao = new BoardDAO();
		BoardBean boarddata = new BoardBean();
		ActionForward forward = new ActionForward();
		String saveFolder = "boardupload";
		int fileSize = 5 * 1024 * 1024; // Maximum size of the file to upload. 5MB
		
		// Specify the actual save path.
		ServletContext sc = req.getServletContext();
		String realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder=" + realFolder);
		try {
			MultipartRequest multi = new MultipartRequest(req, realFolder, fileSize, "utf-8", new DefaultFileRenamePolicy());
			
			//글쓴이 인지 확인. saved pwd와 input pwd 비교
			int num = Integer.parseInt(multi.getParameter("board_num"));
			String pass = multi.getParameter("board_pass");
			boolean usercheck = boarddao.isBoardWriter(num,pass);
			
			//pwd 불일치
			if(!usercheck) {
				resp.setContentType("text/html;charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.print("<script>");
					out.print("alert('pwd 불일치');");
					out.print("history.back();");
				out.print("</script>");
				out.close();
				return null;
			}
			//pwd 일치
			//수정 내용 설정. form 입력정보들 저장.
			boarddata.setBoard_num(num);
			boarddata.setBoard_subject(multi.getParameter("board_subject"));
			boarddata.setBoard_content(multi.getParameter("board_content"));
			
			String check = multi.getParameter("check");
			System.out.println("check : " + check);
			if(check!=null) // file 첨부 not changed
				boarddata.setBoard_file(check);
			else {
				//upload file의 realname get
				String filename = multi.getFilesystemName("board_file");
				boarddata.setBoard_file(filename);
			}
			
			//DAO 에서 수정 메서드 호출하여 수정
			boolean result = boarddao.boardModify(boarddata);
			
			//수정 실패
			if(!result) {
				System.out.println("게시판 수정 실패");
				forward.setRedirect(false);
				req.setAttribute("message", "게시판 수정 error");
				forward.setPath("/WEB-INF/views/error/error.jsp");
			}
			//수정 성공
			else {
				System.out.println("게시판 수정 완료");
				forward.setRedirect(true);
				//글 내용 보기 page의 path
				forward.setPath("detail?num=" + boarddata.getBoard_num());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			forward.setPath("/WEB-INF/views/error/error.jsp");
			req.setAttribute("message", "게시판 upload 중 실패입니다.");
			forward.setRedirect(false);
		}
		return forward;

	}
}
