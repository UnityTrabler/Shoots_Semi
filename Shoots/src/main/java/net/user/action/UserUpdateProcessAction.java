package net.user.action;

import java.io.IOException;

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
			MultipartRequest multi = new MultipartRequest(req, realFolder, fileSize, "UTF-8", new DefaultFileRenamePolicy());
			String userFile = multi.getFilesystemName("userFile");
			System.out.println("userFile : " + userFile);

			UserBean userBean = new UserBean();
			
			userBean.setId(req.getSession().getAttribute("id").toString());
			userBean.setPassword(multi.getParameter("pwd"));
			userBean.setName(multi.getParameter("name"));
			userBean.setRRN(Integer.parseInt(multi.getParameter("RRN")));
			userBean.setGender(Integer.parseInt(multi.getParameter("gender")));
			userBean.setTel(multi.getParameter("tel"));
			userBean.setEmail(multi.getParameter("email"));
			userBean.setNickname(multi.getParameter("nickname"));
			userBean.setUserfile(userFile != null ? userFile : multi.getParameter("check"));
			userBean.setRole(req.getSession().getAttribute("role").toString());
			
			UserDAO userDAO = new UserDAO();
			int result = userDAO.update(userBean); //db update
			if(result == 1) {
				System.out.println("update 성공");
				resp.setContentType("text/html;charset=utf-8");
				resp.setStatus(HttpServletResponse.SC_OK);
				resp.getWriter().println("{\"message\":\"수정 완료\"}");
				return null;
			}
			else {
				System.out.println("update 실패");
				resp.setContentType("text/html;charset=utf-8");
				resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				resp.getWriter().println("{\"message\":\"수정 실패\"}");
				return null;
			}
		}
		catch (IOException e) {e.printStackTrace();}
		return null;
	}

}
