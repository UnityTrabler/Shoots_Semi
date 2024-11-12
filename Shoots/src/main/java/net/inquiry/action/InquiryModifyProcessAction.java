package net.inquiry.action;

import java.io.IOException;
import java.io.PrintWriter;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.inquiry.db.InquiryBean;
import net.inquiry.db.InquiryDAO;

public class InquiryModifyProcessAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		InquiryDAO inquirydao = new InquiryDAO();
		InquiryBean inquirydata = new InquiryBean();
		ActionForward forward = new ActionForward();
		
		String saveFolder = "inquiryupload";
		
		int fileSize = 5* 1024 * 1024; //업로드 할 파일의 최대 사이즈입니다. 5MB;
		
		//실제 저장 경로를 지정합니다.
		ServletContext sc = req.getServletContext();
		String realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder = " + realFolder);
		
		try {
			MultipartRequest multi = new MultipartRequest(req, realFolder, fileSize, 
					"utf-8", new DefaultFileRenamePolicy());
		
// 		원래 저장된 비밀번호와 입력한 비밀번호를 검색하는 코드. 일단 임시 주석처리
//		현재 아래 코드는 비밀번호 유효성검사가 아닌 살짝 바뀐 코드이므로 첨부터 다시 ㄱ
		int listnum = Integer.parseInt(multi.getParameter("inquiry_id"));
//		int id = Integer.parseInt(multi.getParameter("inquiry_ref_idx"));
//		
//		//글쓴이 인지 확인하기 위해 저장된 문의자와 글번호를 비교함.
//		boolean usercheck = boarddao.isBoardWriter(listnum, id);
//		
//		//비밀번호가 다른 경우
//		if(!usercheck) {
//			resp.setContentType("text/html;charset=utf-8");
//			PrintWriter out = resp.getWriter();			
//			out.print("<script>");
//			out.print("alert('비밀번호가 다르다.');");
//			out.print("history.back();");
//			out.print("</script>");
//			out.close();
//			return null;
//		}
		
		//비밀번호가 일치하는 경우 수정 내용을 설정함.
		//BoardBean 객체에 글 등록 폼에서 입력받은 정보들을 저장함.
		inquirydata.setInquiry_id(listnum);
		inquirydata.setTitle(multi.getParameter("title"));
		inquirydata.setContent(multi.getParameter("content"));
		
		String check = multi.getParameter("check");
		System.out.println("check = " + check);
		if (check != null) { //파일첨부를 변경하지 않을시
			inquirydata.setInquiry_file(check);
		} else {
			//업로드 된 파일의 시스템 상에 업로드 된 실제 파일명을 얻어옴.
			String filename = multi.getFilesystemName("inquiry_file");
			inquirydata.setInquiry_file(filename);
		}
		
		//DAO에서 수정 메서드 호출하여 수정합니다.
		boolean result = inquirydao.inquiryModify(inquirydata);
		
		//수정에 실패한 경우
		if (!result) {
			System.out.println("문의글 수정에 실패했습니다.");
			forward.setRedirect(false);
			req.setAttribute("message", "문의글 수정 오류입니다.");
			forward.setPath("/WEB-INF/views/error/error.jsp");
		} else {
			//수정 성공의 경우
			System.out.println("문의글 수정이 완료되었습니다.");
			forward.setRedirect(true);
			//수정한 글 내용을 보여주기 위해 글 내용 보기 페이지로 이동하기 위해 경로를 설정함.
			forward.setPath("detail?inquiryid=" + inquirydata.getInquiry_id());
		}
	} catch (IOException e) {
		e.printStackTrace();
		forward.setPath("/WEB-INF/views/error/error.jsp");
		req.setAttribute("message", "게시판 업로드 중 실패했습니다.");
		forward.setRedirect(false);
	}
	return forward;
  }
}
