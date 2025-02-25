package net.inquiry.action;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;

@WebServlet("/inquiry/*")
public class InquiryFrontController extends jakarta.servlet.http.HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		/*
		 * 요청된 전체 URL중에서 포트 번호 다음 부터 마지막 문자열까지 반환됩니다. 예)
		 * http://localhost:8088/JSP_Template_JSTL/templatetest.net 인 경우
		 * "/JSP_Template_JSTL/templatetest.net" 반환됩니다.
		 */
		String RequestURI = req.getRequestURI();
		System.out.println("request uri : " + RequestURI);

		// getContextPath() : 컨텍스트 경로가 반환됨.
		// contextPath는 "/JspProject"가 반환됨.
		String contextPath = req.getContextPath();
		System.out.println("contextPath : " + contextPath);

		// command는 "/list" 반환됩니다.
		String command = RequestURI.substring(contextPath.length() + "/inquiry".length());
		System.out.println("command = " + command);
		
		//초기화
		ActionForward forward = null;
		Action action = null;

		switch (command) {
			case "/list":
				action = new InquiryListAction();
				break;
				
			case "/write":
				action = new InquiryWriteAction();
				break;
				
			case "/add":
				action = new InquiryAddAction();
				break;
				
			case "/detail":
				action = new InquiryDetailAction();
				break;
				
			case "/modify":
				action = new InquiryModifyAction();
				break;
				
			case "/modifyProcess":
				action = new InquiryModifyProcessAction();
				break;
				
			case "/delete":
				action = new InquiryDeleteAction();
				break;
				
			case "/down":
				action = new InquiryFileDownAction();
				break;
			
			default:
				RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/error/error.jsp");
				dispatcher.forward(req, resp);
				return;
		}//switch

		forward = action.execute(req, resp);

		if (forward != null) {
			if (forward.isRedirect()) {
				resp.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dispatcher = req.getRequestDispatcher(forward.getPath());
				dispatcher.forward(req, resp);
			}
		}
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

}
