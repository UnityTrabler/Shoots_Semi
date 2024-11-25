package net.business.action;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.user.action.UserInquiryAction;

@WebServlet("/business/*")
public class BusinessFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doProcess(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		

		String RequestURI = request.getRequestURI();
		System.out.println("RequestURI = " + RequestURI );
		
		String contextPath = request.getContextPath();
		System.out.println("contextPath = " + contextPath);
		
		String command = RequestURI.substring(contextPath.length() + "/business".length());
		System.out.println("command = " + command);
		
		ActionForward forward = null;
		Action action = null;
		
		switch (command) {
			case "/mypage" :
				action = new BusinessMypageAction();
				break;
			case "/info" :
				action = new BusinessInfoAction();
				break;
			case "/statistics" :
				action = new BusinessStatisticsAction();
				break;
			case "/sales" :
				action = new BusinessSalesAction();
				break;
			case "/myposts" :
				action = new BusinessMypostsAction();
				break;
			case "/customers" :
				action = new BusinessCustomersAction();
				break;
			case "/downloadExcel" :
				action = new ExcelDownloadAction();
				break;
			case "/updateDescription":
				action = new BusinessUpdateDescriptionAction();
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
