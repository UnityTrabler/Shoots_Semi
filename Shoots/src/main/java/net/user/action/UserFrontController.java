package net.user.action;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
@WebServlet("/user/*")
public class UserFrontController extends jakarta.servlet.http.HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		/*
		 * 요청된 전체 URL중에서 포트 번호 다음 부터 마지막 문자열까지 반환됩니다. 예)
		 * http://localhost:8088/JSP_Template_JSTL/templatetest.net 인 경우
		 * "/JSP_Template_JSTL/templatetest.net" 반환됩니다.
		 */
		String RequestURI = req.getRequestURI();
		System.out.println("request uri : " + RequestURI);

		// getContextPath() - 영어 그대로
		// contextPath는 "/JSP_Template_JSTL"가 반환됨.
		String contextPath = req.getContextPath();
		System.out.println("contextPath : " + contextPath);

		// RequestURI에서 컨텍스트 경로 길이 + "/members".length()의 인덱스 위치의 문자부터 마지막 위치 문자까지 추출합니다.
		// command는 "/login" 반환됩니다.
		String command = RequestURI.substring(contextPath.length() + "/user".length());
		System.out.println("command = " + command);
		
		//초기화
		ActionForward forward = null;
		Action action = null;

		switch (command) {
			case "/login":
				action = new UserLoginAction();
				break;

			default:
				RequestDispatcher dispatcher = req.getRequestDispatcher("/error/error404.jsp");
				dispatcher.forward(req, resp);
				return;
		}//switch

		forward = action.execute(req, resp);

		if (forward != null) {
			if (forward.isRedirect()) 
				resp.sendRedirect(forward.getPath());
			 else {
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
