package net.inquiryComment.action;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.comment.action.CommentAddAction;
import net.core.Action;
import net.core.ActionForward;

@WebServlet("/iqcomments/*")
public class InquiryCommentFrontController extends jakarta.servlet.http.HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String Request = req.getRemoteHost();
		System.out.println("접속 URI = " + Request);

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

		String command = RequestURI.substring(contextPath.length() + "/iqcomments".length());
		System.out.println("command = " + command);

		// 초기화
		ActionForward forward = null;
		Action action = null;

		switch (command) {
		case "/add":
			action = new InquiryCommentAddAction();
			break;
		

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
