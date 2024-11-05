package net.notice.db;

import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class NoticeDAO {
private DataSource ds;
	
	public NoticeDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		}catch (Exception ex) {
		    System.out.println("DB 연결 실패 : " + ex);
		}
	}

	public List<NoticeBean> getList() {
		List<NoticeBean> list = new ArrayList<NoticeBean>();
		String sql = """
				select * from notice order by notice_id
				""";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			try(ResultSet rs = pstmt.executeQuery()){
				while(rs.next()) {
					NoticeBean nb = new NoticeBean();
					nb.setNotice_id(rs.getInt(1));
					nb.setWriter(rs.getInt(2));
					nb.setTitle(rs.getString(3));
					nb.setContent(rs.getString(4));
					nb.setNotice_file(rs.getString(5));
					nb.setRegister_date(rs.getString(6).substring(0, 10));
					list.add(nb);
				}
			}
			
			
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getList() 오류: " + ex);
		}
		return list;
	}//getList() end

	public NoticeBean getDetail(int id) {
		NoticeBean nb = null;
		String sql = """
				select * from notice where notice_id = ?
				""";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, id);
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					nb = new NoticeBean();
					nb.setNotice_id(rs.getInt("notice_id"));
					nb.setWriter(rs.getInt("writer"));
					nb.setTitle(rs.getString("title"));
					nb.setContent(rs.getString(4));
					nb.setNotice_file(rs.getString(5));
					nb.setRegister_date(rs.getString(6));
				}
			}
			
		}catch(Exception ex) {
			System.out.println("getDetail() 에러: " + ex);
		}
		
		return nb;
	}
	
	
	

}
