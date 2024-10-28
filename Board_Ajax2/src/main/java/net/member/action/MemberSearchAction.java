
package net.member.action;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.comment.action.Action;
import net.comment.action.ActionForward;
import net.member.db.Member;
import net.member.db.MemberDAO;

public class MemberSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		ActionForward forward = new ActionForward();
		MemberDAO mdao = new MemberDAO();
		
		int page = 1;
		int limit = 3;
		int listcount =0;
		int index = -1; //serach_field에 존재하지 않를 값으로 초기화
		String search_word = "";
		List<Member> list = null;
		
		if (req.getParameter("page") != null) 
			page = Integer.parseInt(req.getParameter("page"));
		System.out.println("넘어온 페이지 = " + page);
		
		//메뉴 - 관리자 - 회원정보 클릭한 후 (list)
		//또는 메뉴 - 관리자 - 회원정보 클리 후 페이지 클릭한 경우 (list?page=2&search_field=-1 &search_Word=)
		
		if(req.getParameter("search_word") == null || req.getParameter("search_word").equals("")) { //총 리스트 수를 받아옴
			listcount = mdao.getListCount();
			list = mdao.getList(page, limit);
		}
		
		else {//검색을 클릭한 경우
			index = Integer.parseInt(req.getParameter("search_field"));
			String[] search_field = new String[] {"id", "name", "age", "gender"};
			
			search_word = req.getParameter("search_word");
			listcount = mdao.getListCount(search_field[index], search_word);
			list = mdao.getList(search_field[index], search_word, page, limit);
		}
		
		int maxpage = (listcount + limit - 1) / limit;
		System.out.println("총 페이지수 = " + maxpage);
		
		int startpage = ((page-1) / 10) * 10 + 1;
		int endpage = startpage + 10 - 1;
		System.out.println("현재 페이지에 보여줄 마지막 페이지 수 = " + endpage);
		System.out.println("현재 페이지에 보여줄 시작 페이지 수 = " + startpage);
		
		if (endpage > maxpage) 
			endpage = maxpage;
		
		req.setAttribute("page", page); //현재 페이지 수
		req.setAttribute("maxpage", maxpage); //최대 페이지 수
		req.setAttribute("startpage", startpage); //현재 페이지에 표시할 첫 페이지 수
		req.setAttribute("endpage", endpage); //현재 페이지에 표시할 끝 페이지 수
		req.setAttribute("listcount", listcount); // 총 글의 수
		req.setAttribute("totallist", list);
		req.setAttribute("search_field", index);
		req.setAttribute("search_word", search_word);
		
		forward.setPath("/WEB-INF/views/member/memberList.jsp");
		forward.setRedirect(false);
		return forward;

	}

}
