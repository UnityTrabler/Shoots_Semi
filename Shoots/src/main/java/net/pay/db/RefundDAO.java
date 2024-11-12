package net.pay.db;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class RefundDAO {
private DataSource ds;
	
	public RefundDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception e) {
			System.out.println("DB 연결 실패 : " + e);
		}
	}

	public void insertRefund(String paymentId, int buyerId, int seller, String reason, int amount, String applyNum, String impUid) {
		String sql = """
				insert into refund (refund_id, payment_id, buyer, seller, reason, amount, status, apply_num, imp_uid)
                values (refund_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?)
				""";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			pstmt.setString(1, paymentId);
			pstmt.setInt(2, buyerId);
			pstmt.setInt(3, seller);
			pstmt.setString(4, reason);
			pstmt.setInt(5, amount);
			pstmt.setString(6, "PENDING");
			pstmt.setString(7, applyNum);
			pstmt.setString(8, impUid);
		
			int result = pstmt.executeUpdate();
			
			if (result > 0) {
	            System.out.println("refund insert 성공");
	        } else {
	            System.out.println("refund insert 실패");
	        }

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("insertRefund() 에러 : " + e);
		}
		
	}
}
