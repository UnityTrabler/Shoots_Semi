package net.member.action;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.comment.action.Action;
import net.comment.action.ActionForward;
import net.member.db.Member;
import net.member.db.MemberDAO;

public class MemberJoinProcessAction implements Action {

	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		String name = req.getParameter("name");
		int age = Integer.parseInt(req.getParameter("age"));
		String gender = req.getParameter("gender");
		String email = req.getParameter("email");
		
		Member m = new Member();
		m.setAge(age);m.setEmail(email);m.setGender(gender);m.setId(id); m.setName(name); m.setPassword(pass);
		
		MemberDAO mdao = new MemberDAO();
		int result = mdao.insert(m);
		
		//result=0; //회원 가입 실패 확인
		if(result == 0) {
			System.out.println("sign up failed");
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			req.setAttribute("message", "sign up failed");
			forward.setPath("/error/error.jsp");
			return forward;
		}
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print("<script>");
		out.print("alert('sign up 축하.');");
		out.print("location.href='../members/login';");
		out.print("</script>");
		out.close();
		return null;
	}

}
