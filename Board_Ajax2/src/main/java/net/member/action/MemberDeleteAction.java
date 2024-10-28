package net.member.action;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.comment.action.Action;
import net.comment.action.ActionForward;
import net.member.db.MemberDAO;

public class MemberDeleteAction implements Action {

	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		int result = new MemberDAO().delete(req.getParameter("id"));
		
		if(result == 1)
			out.print("""
						<script>
							alert('delete complete');
							location.href = 'list';
						</script>
					""");
		else
			out.print("""
						<script>
							alert('delete failed');
							history.back();
						</script>
					""");
		
		out.close();
		
		return null;
	}

}
