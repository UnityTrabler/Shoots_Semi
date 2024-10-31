package net.faq.db;

import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class FaqDAO {

private DataSource ds;
	
	public FaqDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		}catch (Exception ex) {
		    System.out.println("DB 연결 실패 : " + ex);
		}
	}

	public List<FaqBean> getList() {
		List<FaqBean> list = new ArrayList<FaqBean>();
		String sql = """
				select * 
				from faq
				""";
		
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			try(ResultSet rs = pstmt.executeQuery()){
				while(rs.next()) {
					FaqBean fb = new FaqBean();
					fb.setFaq_id(rs.getInt(1));
					fb.setWriter(rs.getInt(2));
					fb.setTitle(rs.getString(3));
					fb.setContent(rs.getString(4));
					fb.setFaq_file(rs.getString(5));
					fb.setRegister_date(rs.getString(6));
				}
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getList() 오류: " + ex);
		}
		
		return list;
	}

	public int faqDelete(int id) {
		int result = 0;
		String sql = """
				delete from faq where faq_id = ?
				""";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setInt(1, id);
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("faqDelete() 에러: " + e);
		}
		return result;
	}
	
	
}
