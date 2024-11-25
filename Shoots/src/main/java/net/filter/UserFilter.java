package net.filter;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class UserFilter implements Filter {

	////filter가 생성될 때 초기화 시 사용
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("UserFilter");
	}

	//<url-pattern>/list.net</url-pattern>에서 작성된 요청 마다 필터가 실행할 method
	//HttpServletRequest의 부모가 ServletRequest. HttpServletRequest로 사용하려면 캐스팅 해야함.
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		
		System.out.println("UserFilter 확인 시작 - 3");
		//ServletRequest를 HttpServletRequest로 casting하여 getSession method를 사용하여
		//HttpSession을 가져옵니다.
		HttpServletRequest hpreq =(HttpServletRequest) req;
		HttpSession session = hpreq.getSession();
		String userClassification = (String) session.getAttribute("userClassification");
		System.out.println("userClassfication 값은 : " + userClassification);
		
		HttpServletResponse hpresp = (HttpServletResponse) resp;
		
		//로그인, 로그인처리 페이지는 필터에서 제외
		String requestURI = hpreq.getRequestURI();
		if (requestURI.contains("/user/loginProcess") || requestURI.contains("/user/login")) {
	        System.out.println("로그인 처리 요청 - 필터 예외 처리");
	        chain.doFilter(req, resp);
	        return;
	    }
		
		
		if(userClassification == null || !userClassification.equals("regular")) {
			hpresp.setContentType("text/html; charset=UTF-8"); // HTML 응답으로 설정
		    PrintWriter out = hpresp.getWriter();
		    
		    out.println("<script>");
		    out.println("alert('개인회원으로 로그인 해주세요');");
		    out.println("location.href='" + hpreq.getContextPath() + "/index.jsp';");
		    out.println("</script>");
		    out.close();
			return; 
		}
		chain.doFilter(req, resp);
		System.out.println("UserFilter 끝 - 4");
	}

}
