package net.core.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface Action {
	//특정 비즈니스 요청으로 수행하고 결과 값을 ActionForward 타입으로 변환하는 method
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
}
