package net.pay.action;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.match.action.MatchAddAction;
import net.match.action.MatchDeleteAction;
import net.match.action.MatchDetailAction;
import net.match.action.MatchListAction;
import net.match.action.MatchUpdateAction;
import net.match.action.MatchUpdateProcessAction;
import net.match.action.MatchWriteAction;

@WebServlet("/payments/*")
public class PayFrontController extends HttpServlet {
private static final long serialVersionUID = 1L;
	
	protected void doProcess(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		

		String RequestURI = request.getRequestURI();
		System.out.println("RequestURI = " + RequestURI );
		
		String contextPath = request.getContextPath();
		System.out.println("contextPath = " + contextPath);
		
		String command = RequestURI.substring(contextPath.length() + "/payments".length());
		System.out.println("command = " + command);
		
		ActionForward forward = null;
		Action action = null;
		
		switch (command) {
			case "/pay" :
				action = new PayServlet();
				break;
			case "/addPayment" :
				action = new PayAddPaymentServlet();
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

