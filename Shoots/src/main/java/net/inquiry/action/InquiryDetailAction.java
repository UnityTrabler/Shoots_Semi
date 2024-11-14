package net.inquiry.action;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;
import net.inquiry.db.InquiryBean;
import net.inquiry.db.InquiryDAO;
import net.inquiryComment.db.InquiryCommentBean;
import net.inquiryComment.db.InquiryCommentDAO;

public class InquiryDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		InquiryDAO inquirydao = new InquiryDAO();
		InquiryCommentDAO ic = new InquiryCommentDAO();
		
		//글번호 파라미터값을 inquiryid 변수에 저장함
		int inquiryid = Integer.parseInt(req.getParameter("inquiryid"));
				
		// inquiry/list 에서 inquiry/detail로 이동 후 sessionREferer 값 확인
		HttpSession session = req.getSession();
		String sessionReferer = (String) session.getAttribute("referer");
		
		if(sessionReferer != null && sessionReferer.equals("list")) {
			//특정 주소로부터 이동을 확인하는데 사용할ㅇ 수 있는 정보는 request Header의 "referer"에 있다.
			String headerReferer = req.getHeader("referer");
			if(headerReferer != null && headerReferer.contains("inquiry/list")) {
				//내용을 확인할 글의 조회수를 증가시킴.
				inquirydao.setReadCountUpdate(inquiryid);
				System.out.println("조회수 증가");
			}
			session.removeAttribute("referer");
		}
		
				
		
		//글의 내용을 DAO에서 읽은 후 얻은 결과를 inquirydata 객체에 저장하고 iqlist에다가 댓글들의 정보를 가져와서 저장함.
		InquiryBean inquirydata = inquirydao.getDetail(inquiryid);
        List<InquiryCommentBean> iqlist = ic.getIqList(inquiryid);

        ActionForward forward = new ActionForward();
		
		
		//DAO에서 글 내용을 읽지 못하면 null로 반환
		if(inquirydata ==null) {
			System.out.println("상세보기 실패");
			req.setAttribute("message", "데이터를 읽지 못했음");
			forward.setPath("/WEB-INF/views/error/error.jsp");
		} else {
			System.out.println("상세보기 성공");
			//inquirydata 객체와 iqlist 객체를 req 객체에 저장함 = 특정 문의글 번호로 조회했을때 그 글의 번호화 일치하는 문의글 + 그 글에 달린 댓글들의 정보.
			req.setAttribute("inquirydata",inquirydata);
			req.setAttribute("iqlist", iqlist);
			forward.setPath("/WEB-INF/views/inquiry/inquiryView.jsp"); //글 내용 보기 페이지로 이동하기 위해 경로 설정
		}
		forward.setRedirect(false);
		return forward;
		
		}
		
	}


