package net.notice.action;
/*
 0. 공지사항 폼에서 입력받은 값을 notice 테이블에 저장합니다.
 1. 작성자를 idx(writer)가 아닌 regular_user 테이블의 user_id로 입력받았으므로 dao.getId()를 통해 idx값을 받아옵니다
 */
import java.io.IOException;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.notice.db.*;

public class NoticeAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		NoticeDAO dao = new NoticeDAO();
		NoticeBean nb = new NoticeBean();
		ActionForward forward = new ActionForward();
		
		String realFolder = "";
		
		//webapp 아래에 faq에서 업로드한 파일이 들어가는 폴더 faqupload
		String saveFolder = "noticeupload";
		
		int fileSize = 25 * 1024 * 1024;	//업로드할 파일의 최대 사이즈 : 25MB
		
		//실제 저장 경로를 지정합니다
		ServletContext sc = req.getServletContext();
		realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder= " + realFolder);
		
		try {
			MultipartRequest multi = 
			new MultipartRequest(req, realFolder, fileSize, "utf-8",
			new DefaultFileRenamePolicy());
			
			String user_id = multi.getParameter("regular_user_id");
			int writer = dao.getId(user_id);
			
			//FaqBean 객체에 글 등록 폼에서 입력 받은 정보들을 저장합니다.
			nb.setWriter(writer);
			nb.setTitle(multi.getParameter("title"));
			nb.setContent(multi.getParameter("content"));
			
			//시스템 상에 업로드된 실제 파일명을 얻어 옵니다.
			String filename = multi.getFilesystemName("notice_file");
			nb.setNotice_file(filename);
			
			int result = dao.noticeInsert(nb); //입력 폼에서 입력받은 사항을 insert하는 dao 메서드
			if(result == 0) {
				System.out.println("공지 등록 실패");
				forward.setPath("/WEB-INF/views/error/error/jsp");
				req.setAttribute("message","공지 등록 실패입니다.");
				forward.setRedirect(false);
			}else {
				System.out.println("공지사항 등록 완료");
				
				//글 등록이 완료되면 글 목록을 보여주기 위해 "notice/noticeList"로 이동합니다.
				//Redirect 여부를 true로 설정합니다.
				forward.setRedirect(true);
				forward.setPath("../admin/mypage");//notice가 추가되고 이동할 경로는 notice/noticeList입니다.
			}
			return forward;
			
		}catch(IOException ex) {
			ex.printStackTrace();
			forward.setPath("/WEB-INF/views/error/error.jsp");
			req.setAttribute("message","공지사항 업로드 실패입니다.");
			forward.setRedirect(false);
			return forward;
		}//catch end
	}

}
