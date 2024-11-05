package net.user.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
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

//	public UserBean getDetail(String id) { //=getMemberById()
//		String sql = """
//				select *
//				from member
//				where id = ?
//				""";
//		UserBean member = new UserBean();
//		try(Connection con = ds.getConnection(); 
//				PreparedStatement pstmt = con.prepareStatement(sql);) {
//				pstmt.setString(1, id);
//			try(ResultSet rs = pstmt.executeQuery();){
//				if(rs.next()) {
//					member.setId(id);
//					member.setPassword(rs.getString(2));
//					member.setName(rs.getString(3));
//					member.setAge(rs.getInt(4));
//					member.setGender(rs.getString(5));
//					member.setEmail(rs.getString(6));
//					member.setMemberfile(rs.getString(7));
//				}
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		
//		return member;
//	}

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
				pstmt.setString(4, userBean.getRRN());
				pstmt.setString(5, userBean.getGender());
				pstmt.setString(6, userBean.getTel());
				pstmt.setString(7, userBean.getEmail());
				result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
