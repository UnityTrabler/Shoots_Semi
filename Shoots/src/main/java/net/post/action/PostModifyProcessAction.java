package net.post.action;

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
		
		int fileSize = 20 * 1024 * 1024; // 업로드할 파일의 최대 사이즈 입니다. 5MB
		
		// 실제 저장 경로를 지정합니다.
		ServletContext sc = request.getServletContext();
		String realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder= " + realFolder);
		try {
			MultipartRequest multi =
					new MultipartRequest(request, realFolder, fileSize, "utf-8",
										 new DefaultFileRenamePolicy());
			
			int num = Integer.parseInt(multi.getParameter("num"));
			
			
//			// 글쓴이 인지 확인하기 위해 저장된 비밀번호와 입력한 비밀번호를 비교합니다.
//			boolean usercheck = postdao.isPostWriter(num, pass);
//			
//			// 비밀번호가 다른 경우
//			if (!usercheck) {
//				response.setContentType("text/html;charset=utf-8");
//				PrintWriter out = response.getWriter();
//				out.print("<script>");
//				out.print("alert('비밀번호가 다릅니다.');");
//				out.print("history.back();");
//				out.print("</script>");
//				out.close();
//				return null;
//			}
			
			// 비밀번호가 일치하는 경우 수정 내용을 설정합니다.
			// BoardBean 객체에 글 등록 폼에서 입력 받은 정보들을 저장합니다.
			postdata.setPost_id(num);
			postdata.setTitle(multi.getParameter("title"));
			//postdata.setWriter(Integer.parseInt(multi.getParameter("writer")));
			postdata.setContent(multi.getParameter("content"));
			postdata.setPrice(Integer.parseInt(multi.getParameter("price")));
			String check = multi.getParameter("check");
			System.out.println("check=" + check);
			if (check != null) {
				postdata.setPost_file(check);
			} else {
				// 업로드된 파일의 시스템 상에 업로드된 실제 파일명을 얻어 옵니다.
				String fillename = multi.getFilesystemName("post_file");
				postdata.setPost_file(fillename);
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
