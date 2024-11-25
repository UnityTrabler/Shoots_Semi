package net.filter;

import java.io.IOException;

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
		if(id==null) {
			System.out.println("filter:null입니다.");
			hpresp.sendRedirect(hpreq.getContextPath() + "/user/login");
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
