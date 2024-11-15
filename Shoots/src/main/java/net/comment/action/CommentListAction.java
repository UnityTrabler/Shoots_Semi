package net.comment.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.comment.db.CommentBean;
import net.comment.db.CommentDAO;
import net.core.Action;
import net.core.ActionForward;

public class CommentListAction implements Action {
	
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		ActionForward forward = new ActionForward ();
		
		net.comment.db.CommentDAO dao = new net.comment.db.CommentDAO();
		
		//CommentDAO dao = new CommentDAO();
		
		int state = Integer.parseInt(request.getParameter("state")); 
		int post_id = Integer.parseInt(request.getParameter("post_id")); 
		//commentlist = dao.getCommentList(post_id);
		
		int listcount = dao.getListCount(post_id);
		
		
		JsonObject object = new JsonObject(); 
		object.addProperty("listcount", listcount);
		
		JsonArray jarray = dao.getCommentList(post_id, state); 
		JsonElement je = new Gson().toJsonTree (jarray);
		object.add("commentlist", je);
		
		
		//response.setContentType("application/json; charset=utf-8");
		//PrintWriter out = response.getWriter();
		//out.print(object.toString());
		//System.out.println(object.toString());
		//return null;
		
//		response.setContentType("application/json; charset=utf-8");
//		PrintWriter out = response.getWriter();
//		out.print(object.toString());
//		System.out.println(object.toString());
//		return null;
		
		forward.setRedirect(false);
		forward.setPath("../post/detail?postid=" + post_id);
		return forward;
	}
}
