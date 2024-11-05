package net.notice.action;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;


//webservlet 경로명
@WebServlet("/notice/*")
public class NoticeFrontController extends jakarta.servlet.http.HttpServlet{

	private static final long serialVersionUID = 1L;
	private void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		
		String RequestURI = request.getRequestURI();
		System.out.println("RequestURI = " + RequestURI);
		
	
		String contextPath=request.getContextPath();
		System.out.println("contextPath = "  + contextPath);
		
		
		String command = RequestURI.substring(contextPath.length() + "/notice".length());
		System.out.println("command = " + command);
		
		//초기화
		ActionForward forward = null;
		Action action = null;
		
		
		switch(command) {
			case "/noticeList":
				action = new NoticeListAction();
				break;
			case "/detail":
				action = new NoticeDetailAction();
				break;
			case "/write":
				action = new NoticeWriteAction();
				break;
			case "/add":
				action = new NoticeAddAction();
				break;
			case "/update":
				action = new NoticeUpdateAction();
				break;
			case "/delete":
				action = new NoticeDeleteAction();
				break;
			case "/noticeAdmin":
				action = new NoticeAdminAction();
				break;
			case "/adminDetail":
				action = new NoticeAdminDetailAction();
				break;
			case "/down":
				action = new NoticeDownAction();
				break;
		default:
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/error/error404.jsp");
			dispatcher.forward(request, response);
			return;
		}//switch end
		
		forward = action.execute(request, response);
		if(forward != null) {
			if(forward.isRedirect()) {	// 리다이렉트 됩니다.
				response.sendRedirect(forward.getPath());
			} else {	//포워딩됩니다.
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}//if(forward != null)
		
	}//doProcess end
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) 
			throws ServletException, IOException{
		doProcess(request, response);
		
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) 
			throws ServletException, IOException{
		doProcess(request, response);
		
	}

}
