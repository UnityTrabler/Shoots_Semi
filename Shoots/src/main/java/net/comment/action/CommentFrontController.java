package net.comment.action;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;

@WebServlet("/comments/*")
public class CommentFrontController extends jakarta.servlet.http.HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		
		String Request = request.getRemoteHost();
		System.out.println("접속 URI = " + Request);
		/*
		* 요청된 전체 URL중에서 포트 번호 다음 부터 마지막 문자열까지 반환됩니다.
		예) contextPath가 "/JspProject" 인 경우
			http://localhost:8088/JspProject/comments/list 인 경우
			"/JspProject/comments/list" 반환됩니다.
		*/
		String RequestURI = request.getRequestURI(); 
		System.out.println("RequestURI = " + RequestURI);

		// getContextPath(): 컨텍스트 경로가 반환됩니다.
		// contextPath는 "/JspProject"가 반환됩니다.
		String contextPath = request.getContextPath(); 
		System.out.println("contextPath = " + contextPath);

			// RequestURI에서 컨텍스트 경로 길이 값의 인덱스 위치의 문자부터
			// 마지막 위치의 문자까지 추출합니다.
		
			// command는 "/list" 반환됩니다.
			String command = RequestURI.substring(contextPath.length() + "/comments".length()); 
			System.out.println("command = " + command);
			
			// 초기화
			ActionForward forward = null;
			Action action = null;
			
			switch (command) {
			
			case "/add":
				action = new CommentAddAction();
				break;
			
			case "/list":
				action = new CommentListAction();
				break;
				
			case "/delete":
				action = new CommentDeleteAction();
				break;
				
			case "/update":
				action = new CommentUpdateAction();
				break;
				
			case "/reply":
				action = new CommentReplyAction();
				break;
				
			
			default:
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/error/error404.jsp");
				dispatcher.forward(request, response);
				return;
			}
			
			forward = action.execute(request, response);
			
			if (forward != null) {
				if (forward.isRedirect()) { // 리다이렉트 됩니다.
					response.sendRedirect(forward.getPath());
				} else { // 포워딩됩니다.
					RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
					dispatcher.forward(request, response);
				}
			} //if (forward != null)
	} //doProcess
	
	// doProcess (request, response) 메서드를 구현하여 요청이 GET방식이든
	// POST방식으로 전송되어 오든 같은 메서드에서 요청을 처리할 수 있도록 하였습니다.
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		doProcess(request, response);
	}
}
