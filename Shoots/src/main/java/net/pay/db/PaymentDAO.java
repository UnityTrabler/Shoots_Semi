package net.pay.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class PaymentDAO {
	private DataSource ds;
	
	public PaymentDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception e) {
			System.out.println("DB 연결 실패 : " + e);
		}
	}

	public int insertPayment(PaymentBean pay) {
		int result = 0;
		String sql = """
				insert into payment (payment_id, match_id, buyer, seller, 
							payment_method, amount, status, apply_num, imp_uid, merchant_uid ) 
					values (payment_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?)
				""";
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, pay.getMatch_id());
			pstmt.setInt(2, pay.getBuyer());
			pstmt.setInt(3, pay.getSeller());
			pstmt.setString(4, pay.getPayment_method());
			pstmt.setInt(5, pay.getAmount());
			pstmt.setString(6, pay.getStatus());
			pstmt.setString(7, pay.getApply_num());
			pstmt.setString(8, pay.getImp_uid());
			pstmt.setString(9, pay.getMerchant_uid());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("insertPayment() 에러 : " + e);
		}
		return result;
	}

	public boolean checkPayment(int matchId, Integer idx) {
	    boolean isPaid = false;
	    try {
	        String sql = "SELECT COUNT(*) FROM payment where match_id = ? AND buyer = ? AND status = 'SUCCESS'";
	        Connection con = ds.getConnection();
	        PreparedStatement stmt = con.prepareStatement(sql);
	        stmt.setInt(1, matchId);
	        stmt.setInt(2, idx);
	        
	        ResultSet rs = stmt.executeQuery();
	        if (rs.next() && rs.getInt(1) > 0) {
	            isPaid = true; 
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return isPaid;
	}
	
	public int getPaymentCountById(int match_id) {
		String sql = """
				select count(*) from payment 
				where match_id = ?
				and status = 'SUCCESS'
				""";
		int x = 0;
		
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			pstmt.setInt(1, match_id);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					x = rs.getInt(1);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getPaymentCountById() 에러 : " + e);
		}
		return x;
	}

	public PaymentBean getPaymentInfoById(Integer idx, int matchId) {
		String sql = """
				select * from payment where buyer = ? and match_id = ?
				""";
		PaymentBean payment = null;
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, idx);
			pstmt.setInt(2, matchId);
			try(ResultSet rs = pstmt.executeQuery();) {
				if (rs.next()) {
					payment = new PaymentBean();
					
					payment.setPayment_id(rs.getInt("payment_id"));
					payment.setMatch_id(rs.getInt("match_id"));
					payment.setBuyer(rs.getInt("buyer"));
					payment.setSeller(rs.getInt("seller"));
					payment.setPayment_method(rs.getString("payment_method"));
					payment.setAmount(rs.getInt("amount"));
					payment.setPayment_date(rs.getString("payment_date"));
					payment.setStatus(rs.getString("status"));
					payment.setApply_num(rs.getString("apply_num"));
					payment.setImp_uid(rs.getString("imp_uid"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getPaymentInfoById() 에러 : " + e);
		}
		return payment;
	}

	public PaymentBean getPaymentById(String paymentId) {
		String sql = """
				select * from payment where payment_id = ?
				""";
		PaymentBean payment = null;
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, paymentId);
			try(ResultSet rs = pstmt.executeQuery();) {
				if (rs.next()) {
					payment = new PaymentBean();
					
					payment.setPayment_id(rs.getInt("payment_id"));
					payment.setMatch_id(rs.getInt("match_id"));
					payment.setBuyer(rs.getInt("buyer"));
					payment.setSeller(rs.getInt("seller"));
					payment.setPayment_method(rs.getString("payment_method"));
					payment.setAmount(rs.getInt("amount"));
					payment.setPayment_date(rs.getString("payment_date"));
					payment.setStatus(rs.getString("status"));
					payment.setApply_num(rs.getString("apply_num"));
					payment.setImp_uid(rs.getString("imp_uid"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getPaymentInfoById() 에러 : " + e);
		}
		return payment;
	}

	public void updatePaymentStatus(String paymentId, String string) {
		String sql = """
				update payment set status = ? where payment_id = ?
				""";
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, string);
			pstmt.setString(2, paymentId);
			
			int result = pstmt.executeUpdate();
			
			if (result > 0) {
	            System.out.println("payment.status 수정 성공");
	        } else {
	            System.out.println("payment.status 수정 실패");
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	        System.out.println("updatePaymentStatus() 에러 : " + e);
	    }
	}

	public List<PaymentBean> getPaymentsByMatchId(int match_id) {
		String sql = """
				select * from payment where match_id = ? and status != 'REFUNDED'
				""";
		List<PaymentBean> list = new ArrayList<>();
		
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			pstmt.setInt(1, match_id);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					
					PaymentBean payment = new PaymentBean();
					
					payment.setPayment_id(rs.getInt("payment_id"));
					payment.setMatch_id(rs.getInt("match_id"));
					payment.setBuyer(rs.getInt("buyer"));
					payment.setSeller(rs.getInt("seller"));
					payment.setPayment_method(rs.getString("payment_method"));
					payment.setAmount(rs.getInt("amount"));
					payment.setPayment_date(rs.getString("payment_date"));
					payment.setStatus(rs.getString("status"));
					payment.setApply_num(rs.getString("apply_num"));
					payment.setImp_uid(rs.getString("imp_uid"));
					
					list.add(payment);
					
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getPaymentsByMatchId() 에러 : " + e);
		}
		return list;
	}

	
	public void updatePaymentStatusByMatchId(int match_id, String string) {
		String sql = """
				update payment set status = ? where payment_id = ?
				""";
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, string);
			pstmt.setInt(2, match_id);
			
			int result = pstmt.executeUpdate();
			
			if (result > 0) {
	            System.out.println("자동환불 payment.status 수정 성공");
	        } else {
	            System.out.println("자동환불 payment.status 수정 실패");
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	        System.out.println("updatePaymentStatusByMatchId() 에러 : " + e);
	    }
		
	}
}
