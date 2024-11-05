package net.user.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserDAO {

	private DataSource ds;

	public UserDAO() {
		try {
			Context init = new InitialContext();
			this.ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception e) {
			System.out.println("DB 연결 실패 : " + e);
		}
	}
	
	//login 할 때 입력한 id,pwd 검증
	public int isId(String id, String pwd) { //=getMemberById()
		String sql = """
				select user_id, password
				from regular_user
				where id = ?
				""";
		int result = 0;
		
		try(Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
				pstmt.setString(1, id);
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()) 
					result = pwd.equals(rs.getString("password")) ? 1 : 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}

	public int insertUser(UserBean userBean) {
		//nickname, user_file
		String sql = """
				INSERT INTO regular_user
				(idx, user_id, password, name, jumin, gender, tel, email)
				VALUES (user_seq.nextval,?,?,?, ?,?,?, ?)
				""";
		int result = 0;
		
		try(Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
				pstmt.setString(1, userBean.getId());
				pstmt.setString(2, userBean.getPassword());
				pstmt.setString(3, userBean.getName());
				pstmt.setInt(4, userBean.getRRN());
				pstmt.setInt(5, userBean.getGender());
				pstmt.setString(6, userBean.getTel());
				pstmt.setString(7, userBean.getEmail());
				result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
