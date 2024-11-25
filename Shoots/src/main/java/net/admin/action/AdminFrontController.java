package net.admin.action;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;

@WebServlet("/admin/*")
public class AdminFrontController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		

		String RequestURI = request.getRequestURI();
		System.out.println("RequestURI = " + RequestURI );
		
		String contextPath = request.getContextPath();
		System.out.println("contextPath = " + contextPath);
		
		String command = RequestURI.substring(contextPath.length() + "/admin".length());
		System.out.println("command = " + command);
		
		ActionForward forward = null;
		Action action = null;
		
		switch (command) {
			case "/mypage" :
				action = new AdminMypageAction();
				break;
			case "/notice" :
				action = new AdminNoticeAction();
				break;
			case "/inquirylist" :
				action = new AdminInquiryListAction();
				break;
			case "/inquirydetail" :
				action = new AdminInquiryDetailAction();
				break;
			case "/userlist" :
				action = new AdminUserListAction();
				break;
			case "/grant":
				action = new AdmingrantAction();
				break;
			case "/revoke":
				action = new AdminRevokeAction();
				break;
			case "/businesslist":
				action = new AdminBusinessListAction();
				break;
			case "/businessapprove":
				action = new AdminBusinessApprovalAction();
				break;
			case "/postlist":
				action = new AdminPostListAction();
				break;
			case "/reportList":
				action = new AdminReportAction();
				break;
			case "/report":
				action = new AdminReportDetail();
				break;
			case "/postDelete":
				action = new AdminPostDeleteAction();
				break;
			case "/approve":
				action = new AdminApproveAction();
				break;
			case "/refuse":
				action = new AdminRefuseAction();
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
