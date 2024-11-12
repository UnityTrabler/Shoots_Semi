package net.post.action;

import java.io.IOException;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.post.db.PostBean;
import net.post.db.PostDAO;

public class PostModifyProcessAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PostDAO postdao = new PostDAO();
		PostBean postdata = new PostBean();
		ActionForward forward = new ActionForward();
		
		String saveFolder = "postupload";
		
		int fileSize = 20 * 1024 * 1024; // 업로드할 파일의 최대 사이즈 입니다. 20MB
		
		// 실제 저장 경로를 지정합니다.
		ServletContext sc = request.getServletContext();
		String realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder= " + realFolder);
		try {
			MultipartRequest multi =
					new MultipartRequest(request, realFolder, fileSize, "utf-8",
										 new DefaultFileRenamePolicy());
			
			int num = Integer.parseInt(multi.getParameter("post_id"));
			
			// 폼 데이터 처리
			// BoardBean 객체에 글 등록 폼에서 입력 받은 정보들을 저장합니다.
			postdata.setPost_id(num);
            String category = multi.getParameter("category");  // 카테고리 값(A 또는 B)
        	//postdata.setCategory(category);
            postdata.setCategory(multi.getParameter("category"));
			postdata.setTitle(multi.getParameter("title"));
			postdata.setWriter(Integer.parseInt(multi.getParameter("writer")));
			postdata.setContent(multi.getParameter("content"));
			
			 // 중고게시판(B)인 경우 가격 받기
            String priceParam = multi.getParameter("price");
            if (priceParam != null && !priceParam.trim().isEmpty()) {
                postdata.setPrice(Integer.parseInt(priceParam));
            } else {
                postdata.setPrice(0); // 가격이 없으면 0으로 처리
            }
			 
			 
            // 기존 첨부파일 처리: 새 파일이 업로드되지 않으면 기존 파일을 유지
            String newFileName = multi.getFilesystemName("post_file");  // 새로 업로드된 파일명
            if (newFileName != null) {
                postdata.setPost_file(newFileName);  // 새 파일이 있으면 새 파일명을 설정
            } else {
                String existingFile = multi.getParameter("existing_file");  // 기존 파일명
                if (existingFile != null && !existingFile.isEmpty()) {
                    postdata.setPost_file(existingFile);  // 기존 파일이 있으면 그대로 사용
                }
            }
         			
         			
			//DAO에서 수정 메서드 호출하여 수정합니다.
			boolean result = postdao.postModify(postdata);
			
			// 수정에 실패한 경우
			if (!result) {
				System.out.println("게시판 수정 실패");
				forward.setRedirect(false);
				request.setAttribute("message", "게시판 수정 오류 입니다");
				forward.setPath("/WEB-INF/views/error/error.jsp");
			} else {
				// 수정 성공의 경우
				System.out.println("게시판 수정 완료");
				forward.setRedirect(true);
				// 수정한 글 내용을 보여주기 위해 글 내용 보기 페이지로 이동하기위해 경로를 설정합니다.
				forward.setPath("detail?num=" + postdata.getPost_id());
			}
		} catch (IOException e) {
			e.printStackTrace();
			forward.setPath("/WEB-INF/views/error/error.jsp");
			request.setAttribute("message", "게시판 업로드 중 실패입니다");
			forward.setRedirect(false);
		}
		return forward;
	} 

}
