package net.pay.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
}
