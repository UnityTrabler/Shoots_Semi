package net.match.action;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;

@WebServlet("/matchs/*")
public class MatchFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doProcess(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		

		String RequestURI = request.getRequestURI();
		System.out.println("RequestURI = " + RequestURI );
		
		String contextPath = request.getContextPath();
		System.out.println("contextPath = " + contextPath);
		
		String command = RequestURI.substring(contextPath.length() + "/matchs".length());
		System.out.println("command = " + command);
		
		ActionForward forward = null;
		Action action = null;
		
		switch (command) {
			case "/list" :
				action = new MatchListAction();
				break;
			case "/write" :
				action = new MatchWriteAction();
				break;
			case "/add" :
				action = new MatchAddAction();
				break;
			case "/detail" :
				action = new MatchDetailAction();
				break;
			case "/update" :
				action = new MatchUpdateAction();
				break;
			case "/updateProcess" :
				action = new MatchUpdateProcessAction();
				break;
			case "/delete" :
				action = new MatchDeleteAction();
				break;
			
			default:
					RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB_INF/views/error/error404.jsp");
					dispatcher.forward(request, response);
					return;
		}
		
		forward = action.execute(request, response);
		
		if (forward != null) {
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
		}
		
		protected void doGet(HttpServletRequest request,
				HttpServletResponse response) throws ServletException, IOException {
			doProcess(request, response);
		}
		
		protected void doPost(HttpServletRequest request, 
		HttpServletResponse response) throws ServletException, IOException  {
			doProcess(request, response);
		
		}
}
