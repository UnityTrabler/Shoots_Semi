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

public class ForbiddenFilter implements Filter {

    // 필터 초기화
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("ForbiddenFilter 시작");
    }

    // 요청 필터링 처리
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {

        System.out.println("ForbiddenFilter - 모든 요청 차단");

        // HttpServletRequest와 HttpServletResponse로 캐스팅
        HttpServletRequest hpreq = (HttpServletRequest) req;
        HttpServletResponse hpresp = (HttpServletResponse) resp;

        // 차단 처리
        hpreq.getRequestDispatcher("/error/error403.jsp").forward(hpreq, hpresp);
        return;

    }

    // 필터 종료
    public void destroy() {
        System.out.println("ForbiddenFilter 끝. 필터 종료");
    }
}