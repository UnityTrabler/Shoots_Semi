package net.faq.action;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;

//webservlet 경로명
@WebServlet("/faq/*")
public class FaqFrontController extends jakarta.servlet.http.HttpServlet{

	private static final long serialVersionUID = 1L;
	private void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String RequestURI = request.getRequestURI();
		System.out.println("RequestURI = " + RequestURI);
		
	
		String contextPath=request.getContextPath();
		System.out.println("contextPath = "  + contextPath);
		
		
		String command = RequestURI.substring(contextPath.length() + "/faq".length());
		System.out.println("command = " + command);
		
		//초기화
		ActionForward forward = null;
		Action action = null;
		
		
		switch(command) {
		case "/faqPay":
			action = new FaqListAction();
			break;
		case "/write":
			action = new FaqWriteAction();
			break;
		case "/add":
			action = new FaqAddAction();
			break;
		case "/update":
			action = new FaqUpdateAction();
			break;
		case "/updateProcess":
			action = new FaqUpdateProcessAction();
			break;
		case "/delete":
			action = new FaqDeleteAction();
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
