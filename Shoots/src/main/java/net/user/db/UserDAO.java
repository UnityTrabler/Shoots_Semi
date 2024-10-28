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

	public int isId(String id, String pass) {
		int result = -1; // DB에 해당 id가 없음.
		String sql = """
				select id, password
				from member
				where id =?
				""";

		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, id);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) 
					result = rs.getString(2).equals(pass) ? 1 : 0;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	} // isID

	public int isId(String id) {
		int result = -1; // DB에 해당 id가 없음.
		String sql = """
				select id
				from member
				where id =?
				""";

		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, id);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) 
					result = 0; // DB에 해당 id가 있습니다.
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int insert(UserBean m) {
		int result = 0;
		String sql = """
				INSERT INTO member
				(id, password, name, age, gender, email)
				VALUES (?,?,?,?,?,?)
				""";
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, m.getId());
			pstmt.setString(2, m.getPassword());
			pstmt.setString(3, m.getName());
			pstmt.setInt(4, m.getAge());
			pstmt.setString(5, m.getGender());
			pstmt.setString(6, m.getEmail());
			result = pstmt.executeUpdate(); //성공시 1
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}//insert

	public UserBean getDetail(String id) { //=getMemberById()
		String sql = """
				select *
				from member
				where id = ?
				""";
		UserBean member = new UserBean();
		try(Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
				pstmt.setString(1, id);
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()) {
					member.setId(id);
					member.setPassword(rs.getString(2));
					member.setName(rs.getString(3));
					member.setAge(rs.getInt(4));
					member.setGender(rs.getString(5));
					member.setEmail(rs.getString(6));
					member.setMemberfile(rs.getString(7));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return member;
	}

}
