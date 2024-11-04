package net.post.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;
import net.post.db.PostBean;
import net.post.db.PostDAO;

public class PostDetailAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		PostDAO postdao = new PostDAO();
		
		// 글번호 파라미터 값을 num변수에 저장합니다.
		int num = Integer.parseInt(request.getParameter("num"));
		
		// boards/list 에서 boards/detail로 이동 후 sessionReferer 값 확인
		HttpSession session = request.getSession();
		String sessionReferer = (String) session.getAttribute("referer");
		
		if (sessionReferer != null && sessionReferer.equals("list")) {
			//특정 주소로부터의 이동을 확인하는 데 사용할 수 있는 정보는 request Header의 "referer" 에 있습니다.
			String headerReferer = request.getHeader("referer");
			if (headerReferer != null && headerReferer.contains("post/list")) {
				//내용을 확인할 글의 조회수를 증가시킵니다.
				postdao.setReadCountUpdate(num);
				System.out.println("count 증가");
			}
			session.removeAttribute("referer");
		}
		
		//글의 내용을 DAO에서 읽은 후 얻은 결과를 boarddata 객체에 저장합니다.
		PostBean postdata = postdao.getDetail(num);
		
		ActionForward forward = new ActionForward();
		// boarddata=null; //error테스트를 위한 값 설정
		// DAO에서 글의 내용을 읽지 못했을 경우 null을 반환합니다.
		if (postdata == null) {
			System.out.println("상세보기 실패");
			request.setAttribute("message", "데이터를 읽지 못했습니다.");
			forward.setPath("/WEB-INF/views/error/error.jsp");
		} else {
			System.out.println("상세보기 성공");
			//boarddata 객체를 request 객체에 저장합니다.
			request.setAttribute("postdata", postdata);
			//글 내용 보기 페이지로 이동하기 위해 경로
			forward.setPath("/WEB-INF/views/post/postView.jsp"); 
		}
		forward.setRedirect(false);
		return forward;
	}
}
