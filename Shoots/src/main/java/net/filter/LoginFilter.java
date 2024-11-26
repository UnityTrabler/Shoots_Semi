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

public class LoginFilter implements Filter {

	////filter가 생성될 때 초기화 시 사용
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("LoginFilter");
	}

	//<url-pattern>/list.net</url-pattern>에서 작성된 요청 마다 필터가 실행할 method
	//HttpServletRequest의 부모가 ServletRequest. HttpServletRequest로 사용하려면 캐스팅 해야함.
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		
		System.out.println("LoginFilter 확인 시작 - 1");
		//ServletRequest를 HttpServletRequest로 casting하여 getSession method를 사용하여
		//HttpSession을 가져옵니다.
		HttpServletRequest hpreq =(HttpServletRequest) req;
		HttpSession session = hpreq.getSession();
		String id = (String) session.getAttribute("id");
		HttpServletResponse hpresp = (HttpServletResponse) resp;
		
		
		  // 현재 요청 URL 가져오기
	    String requestURI = hpreq.getRequestURI();
	    System.out.println("현재 요청 URI: " + requestURI);

	    // 로그인 페이지와 관련된 요청은 필터링 제외
	    String contextPath = hpreq.getContextPath();
	    if (requestURI.startsWith(contextPath + "/user/login")) {
	        chain.doFilter(req, resp);
	        return;
	    }
		
		if(id==null) {
			hpresp.setContentType("text/html; charset=UTF-8"); // HTML 응답으로 설정
		    PrintWriter out = hpresp.getWriter();
		    
		    out.println("<script>");
		    out.println("alert('로그인이 필요합니다.');");
		    out.println("location.href='" + hpreq.getContextPath() + "/user/login';");
		    out.println("</script>");
		    out.close();
			return; //다른 filter로 요청이 전달되지 않고 login으로 이동함.
		}
		
		
		//요청 전 처리 코드
		
		//요청 필터링 결과를 다음 filter에 전달.
		//if 현재가 마지막 필터면 servlet container에 의해 요청된 servlet으로 전달.
		chain.doFilter(req, resp);
		
		//응답 후 처리 코드
		System.out.println("LoginFilter 끝 - 2");
	}

}
