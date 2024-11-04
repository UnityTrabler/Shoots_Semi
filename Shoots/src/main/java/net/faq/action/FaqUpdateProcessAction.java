package net.faq.action;

import java.io.IOException;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;

import net.faq.db.*;

public class FaqUpdateProcessAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		FaqDAO dao = new FaqDAO();
		FaqBean fb = new FaqBean();
		ActionForward forward = new ActionForward();
		
		String saveFolder = "faqupload";
		
		int fileSize = 5 * 1024 * 1024; //업로드할 파일의 최대 사이즈 입니다. 5MB
		
		//실제 저장 경로를 지정합니다.
		ServletContext sc = req.getServletContext();
		String realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder= " + realFolder);
		
		try {
			MultipartRequest multi = 
					new MultipartRequest(req, realFolder, fileSize, "utf-8",
										 new DefaultFileRenamePolicy());
			
			//writer도 부분도 수정 가능하가?
			fb.setFaq_id(Integer.parseInt(multi.getParameter("faq_id")));
			fb.setTitle(multi.getParameter("title"));
			fb.setContent(multi.getParameter("content"));
			
			String check = multi.getParameter("check");
			System.out.println("check=" + check);
			if(check != null) {//파일 첨부를 변경하지 않으면
				fb.setFaq_file(check);
			} else {
				//업로드 된 파일의 시스템 상에 업로드 된 실제 파일명을 얻어 옵니다.
				String filename = multi.getFilesystemName("faq_file");
				fb.setFaq_file(filename);
			}
			
			//DAO에서 수정 메서드를 호출하여 수정합니다.
			int result = dao.faqUpdate(fb);
			
			if(result == 0) {
				System.out.println("FAQ 수정 실패");
				forward.setRedirect(false);
				req.setAttribute("message", "FAQ게시판 수정 오류 입니다");
				forward.setPath("/WEB-INF/views/error/error.jsp");
			}else {
				//수정 성공의 경우
				System.out.println("FAQ 수정 완료");
				forward.setRedirect(true);
				//수정한 글 내용을 보여주기 위해 글 내용 보기 페이지로 이동하기 위해 경로를 설정합니다.
				forward.setPath("faqAdmin");
			}
			
			
			
		}catch(IOException ex) {
			ex.printStackTrace();
			forward.setPath("/WEB-INF/views/error/error.jsp");
			req.setAttribute("message","FAQ 업로드 중 실패입니다.");
			forward.setRedirect(false);
		}//catch end
		
		return forward;
	}

}
