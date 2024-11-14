package net.inquiry.action;

import java.io.IOException;

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

public class InquiryAddAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		InquiryDAO inquirydao = new InquiryDAO();
		InquiryBean inquiryBean = new InquiryBean();
		ActionForward forward = new ActionForward();
		
		String realFolder = "";
		String saveFolder = "inquiryupload";
		int fileSize = 10 * 1024 * 1024; //파일 업로드 최대 사이즈는 10mb
		
		//실제 저장 경로 지정
		ServletContext sc = req.getServletContext();
		realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder= "+ realFolder);
		try {
			MultipartRequest multi = new MultipartRequest(req, realFolder, fileSize, "utf-8", new DefaultFileRenamePolicy());
			inquiryBean.setInquiry_ref_idx(Integer.parseInt(multi.getParameter("inquiry_ref_idx")));
			inquiryBean.setTitle(multi.getParameter("title"));
			inquiryBean.setContent(multi.getParameter("content"));
			inquiryBean.setInquiry_type(multi.getParameter("inquiry_type"));
			
			//시스템 상에 업로드 된 실제 파일명 얻어 옴.
			 String filename = multi.getFilesystemName("inquiry_file");
			 inquiryBean.setInquiry_file(filename);
			 
			 //글 등록 처리 위해 boardInsert() 호출.
			 //글 등록 form에서 입력한 정보가 저장되어 있는 boardBean객체를 전달함.
			 boolean result = inquirydao.inquiryInsert(inquiryBean);
			 //글 등록 실패할 경우 false
			 if(!result) {
				 System.out.println("문의글이 등록되지 않았습니다.");
				 forward.setPath("/WEB-INF/views/error/error.jsp");
				 req.setAttribute("message", "문의글 등록에 실패했습니다.");
				 forward.setRedirect(false);
			 }
			 else {
				 System.out.println("문의글이 게시되었습니다.");
				 //글 등록이 완료되면 글 목록을 보여주기 위해 "boards/list"로 이동함.
				 forward.setRedirect(true);
				 forward.setPath("list"); //이동할 경로 지정.
			 }
			 return forward;
		} catch (Exception e) {
			e.printStackTrace();
			 forward.setPath("/WEB-INF/views/error/error.jsp");
			 req.setAttribute("message", "문의글 업로드에 실패했습니다.");
			 forward.setRedirect(false);
			 return forward;
		}
	}

}
