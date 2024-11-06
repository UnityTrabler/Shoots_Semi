package net.post.action;

import java.io.IOException;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;
import net.post.db.PostBean;
import net.post.db.PostDAO;

public class PostAddAction implements Action {
	
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		PostDAO postdao = new PostDAO();
		PostBean postdata = new PostBean();
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();  // 이거 지우면 글작성할때 login한 writer값 안들어가짐 
		//String idx = "idx";
		
		String realFolder = "";
		
		String saveFolder = "postupload";
		
		int fileSize = 20 * 1024 * 1024;	// 업로드할 파일의 최대 사이즈 입니다. 20MB
		
		//실제 저장 경로를 지정합니다.
		ServletContext sc = request.getServletContext();
		realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder= " + realFolder);
		try { // 파일 업로드 처리
			MultipartRequest multi =
					new MultipartRequest(request, realFolder, fileSize, "utf-8",
					new DefaultFileRenamePolicy());
			
			// 폼 데이터 처리
            String category = multi.getParameter("category");  // 카테고리 값(A 또는 B)
            postdata.setCategory(category);  // PostBean에 카테고리 값 설정
			
			//PostBean 객체에 글 등록 폼에서 입력 받은 정보들을 저장합니다.//
			postdata.setTitle(multi.getParameter("title"));
			postdata.setContent(multi.getParameter("content"));
			postdata.setWriter(Integer.parseInt(multi.getParameter("writer")));
			postdata.setPrice(Integer.parseInt(multi.getParameter("price")));
			// 시스템 상에 업로드된 실제 파일명을 얻어 옵니다.
						String filename = multi.getFilesystemName("post_file");
						postdata.setPost_file(filename);
			
			// 글 등록 처리를 위해 DAO의 postInsert()메서드를 호출합니다.
			// 글 등록 폼에서 입력한 정보가 저장되어 있는 postdata객체를 전달합니다.
			boolean result = postdao.postInsert(postdata);
			
			
			// 글 등록에 실패한 경우 false를 반환합니다.
			if (!result) {
				System.out.println("게시판 등록 실패");
				forward.setPath("/WEB-INF/views/error/error.jsp");
				request.setAttribute("message", "게시판 등록 실패입니다.");
				forward.setRedirect(false);
			} else {
				System.out.println("게시판 등록 완료");
//				forward.setRedirect(true);
//				// 등록 후 카테고리별 게시글 목록으로 리다이렉트
//                forward.setPath("list?category=" + postdata.getCategory()); 
				
				// 글 등록이 완료되면 글 목록을 보여주기 위해 "boards/list"로 이동합니다.
				// Redirect 여부를 true로 설정합니다.
				forward.setRedirect(true);
				forward.setPath("list"); // 이동할 경로를 지정합니다.
			}
			return forward;
		} catch (IOException ex) {
			ex.printStackTrace();
			forward.setPath("/WEB-INF/views/error/error.jsp");
			request.setAttribute("message", "게시판 업로드 실패입니다.");
			forward.setRedirect(false);
			return forward;
			
		} // catch end
	} // execute end
	
}
