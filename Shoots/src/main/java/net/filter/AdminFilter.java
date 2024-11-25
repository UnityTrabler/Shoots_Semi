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

public class AdminFilter implements Filter {

	////filter가 생성될 때 초기화 시 사용
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("AdminFilter");
	}

	//<url-pattern>/list.net</url-pattern>에서 작성된 요청 마다 필터가 실행할 method
	//HttpServletRequest의 부모가 ServletRequest. HttpServletRequest로 사용하려면 캐스팅 해야함.
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		
		System.out.println("AdminFilter 확인 시작 - 7");
		//ServletRequest를 HttpServletRequest로 casting하여 getSession method를 사용하여
		//HttpSession을 가져옵니다.
		HttpServletRequest hpreq =(HttpServletRequest) req;
		HttpSession session = hpreq.getSession();
		String role = (String) session.getAttribute("role");
		System.out.println("role 값은 : " + role);
		
		HttpServletResponse hpresp = (HttpServletResponse) resp;
		if(role == null || !role.equals("admin")) {
			hpresp.setContentType("text/html; charset=UTF-8"); // HTML 응답으로 설정
		    PrintWriter out = hpresp.getWriter();
		    
		    out.println("<script>");
		    out.println("alert('비정상적인 접근입니다.');");
		    out.println("location.href='" + hpreq.getContextPath() + "/index.jsp';");
		    out.println("</script>");
		    out.close();
			return; 
		}
		chain.doFilter(req, resp);
		System.out.println("AdminFilter 끝 - 8");
	}

}
