package net.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.user.db.UserBean;
import net.user.db.UserDAO;

public class UserUpdateProcessAction implements Action {

	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		int fileSize = 5 * 1024 * 1024; // upload할 파일의 maximum size 5MB
		ServletContext sc = req.getServletContext();
		String realFolder = sc.getRealPath("userupload");
		System.out.println("realFolder : " + realFolder);
		
		try {
			MultipartRequest multi = new MultipartRequest(req, realFolder, fileSize, "utf-8", new DefaultFileRenamePolicy());
			String userFile = multi.getFilesystemName("userfile");
			System.out.println("userFile : " + userFile);

			UserBean userBean = new UserBean();
			userBean.setUserfile(userFile != null ? userFile : multi.getParameter("check"));
			userBean.setId(multi.getParameter("id"));
			
			UserDAO userDAO = new UserDAO();
			int result = userDAO.update(userBean); //update
			
			printJSP(resp, result);
		}
		catch (IOException e) {e.printStackTrace();}
		return null;
	}

	private void printJSP(HttpServletResponse resp, int result) throws IOException {
		PrintWriter out = resp.getWriter();
		resp.setContentType("text/html;charset=utf-8");
		out.print("<script>");
		
		if (result == 1) 
			out.print("""
					alert('수정되었습니다');
					location.href='../boards/list';
					""");
		else 
			out.print("""
					alert('수정 실패');
					history.back();
					""");
		
		out.print("</script>");
		out.close();
	}

}
