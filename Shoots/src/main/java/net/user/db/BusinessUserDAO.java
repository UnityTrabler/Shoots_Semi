package net.user.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BusinessUserDAO {

	private DataSource ds;

	public BusinessUserDAO() {
		try {
			Context init = new InitialContext();
			this.ds = (DataSource)init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception e) {
			System.out.println("DB 연결 실패 : " + e);
		}
	}

	public BusinessUserBean getUserInfoById(int business_idx) {
		String sql = """
				select * from business_user where business_idx = ?
				""";
		BusinessUserBean businessUser = null;
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			pstmt.setInt(1, business_idx);
			
			try (ResultSet rs = pstmt.executeQuery();) {
				if (rs.next()) {
					businessUser = new BusinessUserBean();
					businessUser.setBusiness_idx(rs.getInt("business_idx"));
					businessUser.setBusiness_id(rs.getString("business_id"));
					businessUser.setPassword(rs.getString("password"));
					businessUser.setBusiness_name(rs.getString("business_name"));
					businessUser.setBusiness_number(rs.getInt("business_number"));
					businessUser.setReq(rs.getInt("req"));
					businessUser.setEmail(rs.getString("email"));
					businessUser.setPost(rs.getInt("post"));
					businessUser.setAddress(rs.getString("address"));
					businessUser.setDescription(rs.getString("description"));
					businessUser.setBusiness_file(rs.getString("business_file"));
					businessUser.setRegister_date(rs.getString("register_date"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getUserInfoById() 에러 : " + e );
		}
		return businessUser;
	}
}
