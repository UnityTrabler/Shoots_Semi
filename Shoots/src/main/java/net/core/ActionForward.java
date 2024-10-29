package net.core;
/*
Action 인터페이스를 구현한 클래스에서 명령 수행 후 다음 페이지로 이동하기 위한 정보를 담을 클래스입니다.
redirect는 redirect 여부, path에는 페이지 정보가 저장됩니다.
1. redirect가 true이면
	response.sendRedirect(forward.getPath()); 문장을 실행합니다.

2. redirect가 false이면
	RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
	dispatcher.forward(request, response); 문장을 실행합니다.
 */
public class ActionForward {
	private boolean redirect = false;
	private String path=null;
	
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public void setRedirect(boolean redirect) {
		this.redirect = redirect;
	}

	public boolean isRedirect() {
		return redirect;
	}
}

