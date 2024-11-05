package net.notice.action;

import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.notice.db.*;

public class NoticeAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		NoticeDAO dao = new NoticeDAO();
		NoticeBean nb = new NoticeBean();
		ActionForward forward = new ActionForward();
		
		String realFolder = "";
		
		//webapp 아래에 faq에서 업로드한 파일이 들어가는 폴더 faqupload
		String saveFolder = "noticeupload";
		
		int fileSize = 25 * 1024 * 1024;	//업로드할 파일의 최대 사이즈 : 25MB
		
		//실제 저장 경로를 지정합니다
		ServletContext sc = req.getServletContext();
		realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder= " + realFolder);
		
		return null;
	}

}
