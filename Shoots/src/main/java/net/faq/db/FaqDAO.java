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
				select f.*, u.name 
				from faq f join regular_user u
				on f.writer = u.idx  
				order by faq_id
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
					fb.setRegister_date(rs.getString(6).substring(0, 10));
					fb.setName(rs.getString("name"));
					list.add(fb);
				}
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getList() 오류: " + ex);
		}
		
		return list;
	}//getList() faqselectall end

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
	}//faqDelete end

	public int faqInsert(FaqBean fb) {
		int result = 0;
		String sql = """
				insert into faq values(faq_seq.nextval, ?, ?, ?, ?, sysdate)
				""";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setInt(1, fb.getWriter());
			pstmt.setString(2, fb.getTitle());
			pstmt.setString(3, fb.getContent());
			pstmt.setString(4, fb.getFaq_file());
			result = pstmt.executeUpdate();
		}
		catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("faqInsert() 에러: " + ex);
		}
		return result;
	}//faqInsert end

	public FaqBean getDetail(int id) {
		FaqBean fb = null;
		String sql = """
				select f.*, u.name  
				from faq f join regular_user u 
				on f.writer = u.idx  
				where faq_id = ?
				""";
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setInt(1, id);
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					fb = new FaqBean();
					fb.setFaq_id(rs.getInt("faq_id"));
					fb.setWriter(rs.getInt("writer"));
					fb.setTitle(rs.getString("title"));
					fb.setContent(rs.getString("content"));
					fb.setFaq_file(rs.getString("faq_file"));
					fb.setRegister_date(rs.getString("register_date"));
					fb.setName(rs.getString("name"));
				}
			}
			
		}catch(Exception ex) {
			System.out.println("getDetail() 에러: " + ex);
		}
		return fb;
	}//getDetail() end

	public int faqUpdate(FaqBean fb) {
		int result = 0;
		String sql = """
				update faq set title=?, content=?, faq_file=?
				where faq_id=?
				""";
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, fb.getTitle());
			pstmt.setString(2, fb.getContent());
			pstmt.setString(3, fb.getFaq_file());
			pstmt.setInt(4, fb.getFaq_id());
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("faqUpdate() 에러: " + e);
		}
		
		return result;
	}//faqUpdate() end
	
	
}
