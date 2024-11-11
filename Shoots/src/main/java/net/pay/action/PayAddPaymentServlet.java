package net.pay.action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.core.Action;
import net.core.ActionForward;
import net.pay.db.*;

public class PayAddPaymentServlet implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		ActionForward forward = new ActionForward();
		PaymentBean pay = new PaymentBean();
		PaymentDAO dao = new PaymentDAO();
		
		pay.setImp_uid(req.getParameter("impUid"));
		pay.setMatch_id(Integer.parseInt(req.getParameter("matchId")));
		pay.setBuyer(Integer.parseInt(req.getParameter("buyer")));
		pay.setSeller(Integer.parseInt(req.getParameter("seller")));
		pay.setPayment_method(req.getParameter("paymentMethod"));
		pay.setAmount(Integer.parseInt(req.getParameter("amount")));
		pay.setApply_num(req.getParameter("applyNum"));
		pay.setImp_uid(req.getParameter("impUid"));
		pay.setStatus(req.getParameter("status"));
		pay.setMerchant_uid(req.getParameter("merchantUid"));
		
		int result = dao.insertPayment(pay);
		resp.getWriter().print(result);
		
		return null;
	}

}
