package net.notice.db;

import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

	//notice 테이블에 저장된 모든 값을 가져옵니다
	public List<NoticeBean> getList() {
		List<NoticeBean> list = new ArrayList<NoticeBean>();
		String sql = """
				select n.*, u.name 
				from notice n join regular_user u 
				on n.writer = u.idx
				order by n.notice_id
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
					nb.setReadcount(rs.getInt(7));
					nb.setName(rs.getString("name"));
					list.add(nb);
				}
			}
			
			
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getList() 오류: " + ex);
		}
		return list;
	}//getList() end
	
	//페이징을 위한 getNoticeList
	public List<NoticeBean> getNoticeList(int page, int limit){
		List<NoticeBean> list = new ArrayList<NoticeBean>();
		String sql = """
				select * from (
					select rownum rnum, n.notice_id, n.title, n.register_date,n.readcount, u.name
					from notice n 
					join regular_user u 
					on n.writer = u.idx order by n.register_date
				) p where p.rnum >= ? and p.rnum <= ?
				""";
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			
			try (ResultSet rs = pstmt.executeQuery()){
				while(rs.next()) {
					NoticeBean nb = new NoticeBean();
					nb.setNotice_id(rs.getInt("notice_id"));
					nb.setTitle(rs.getString("title"));
					nb.setRegister_date(rs.getString("register_date"));
					nb.setReadcount(rs.getInt("readcount"));
					nb.setName(rs.getString("name"));
					
					list.add(nb);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getNoticeList() 에러 : " + e);
		}
		
		return list;
	}//getNoticeList() end

	//notice 자세히 보기
	public NoticeBean getDetail(int id) {
		NoticeBean nb = null;
		String sql = """
				select n.*, u.name 
				from notice n join regular_user u 
				on n.writer = u.idx 
				where notice_id = ?
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
					nb.setContent(rs.getString("content"));
					nb.setNotice_file(rs.getString("notice_file"));
					nb.setRegister_date(rs.getString("register_date"));
					nb.setReadcount(rs.getInt("readcount"));
					nb.setName(rs.getString("name"));
				}
			}
			
		}catch(Exception ex) {
			System.out.println("getDetail() 에러: " + ex);
		}
		
		return nb;
	}//getDetail() end
	
	public int noticeInsert(NoticeBean nb) {
		int result = 0;
		String sql = """
				insert into notice values(notice_seq.nextval, ?, ?, ?,?,sysdate, ?)
				""";
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setInt(1, nb.getWriter());
			pstmt.setString(2, nb.getTitle());
			pstmt.setString(3, nb.getContent());
			pstmt.setString(4, nb.getNotice_file());
			pstmt.setInt(5, 0);
			result = pstmt.executeUpdate();
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("noticeInsert() 에러: " + ex);
		}
		return result;
	}//noticeInsert() end

	public int noticeUpdate(NoticeBean nb) {
		int result = 0;
		String sql = """
				update notice set title=?, content=?, notice_file=? 
				where notice_id=?
				""";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, nb.getTitle());
			pstmt.setString(2, nb.getContent());
			pstmt.setString(3, nb.getNotice_file());
			pstmt.setInt(4, nb.getNotice_id());
			
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("noticeUpdate() 에러: " + e);
		}
		return result;
	}//noticeUpdate() end

	public int noticeDelete(int id) {
		int result = 0;
		String sql = """
				delete from notice where notice_id=?
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
	}//noticeDelete() end
	
	//조회수 업데이트
	public void setReadCountUpdate(int id) {
		String sql = """
				update notice
				set readcount = readcount + 1 
				where notice_id = ?
				""";
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
		}catch(SQLException ex) {
			System.out.println("setReadCountUpdate() 에러: " + ex);
		}
		
	}//setReadCountUpdate() end

	public int getListCount() {
		String sql = "select count(*) from notice";
		int x = 0;
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					x = rs.getInt(1);
				}
			}
				}catch(Exception ex) {
					ex.printStackTrace();
					System.out.println("getListCount() 에러: " + ex);
				}
				return x;
	}
	
	//로그인을 받은 regular_id로 regular_user테이블에서 idx 받아오기
	public int getId(String user_id) {
		int x = 0;
		String sql = """
				select idx from regular_user where user_id = ?
				""";
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, user_id);
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					x = rs.getInt(1);
				}
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getId() 에러: " + ex);
		}
		return x;
	}//getId() end

	public int getListCount(String search_word) {
		int x = 0;
		String sql = """
				select count(*) 
				from notice 
				where title like ?
				""";
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, "%" + search_word + "%");
			
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					x = rs.getInt(1);
				}
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount(search_word) 에러: " + ex);
		}
		return x;
	}//getListCount(search_word) end

	public List<NoticeBean> getNoticeList(int page, int limit, String search_word) {
		List<NoticeBean> list = new ArrayList<NoticeBean>();
		String sql = """
				select * from (
					select rownum rnum, n.notice_id, n.title, n.register_date,n.readcount, u.name
					from notice n 
					join regular_user u 
					on n.writer = u.idx where title like ? 
					order by n.register_date
				) p where p.rnum >= ? and p.rnum <= ?
				""";
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, "%" + search_word + "%");
			pstmt.setInt(2, startrow);
			pstmt.setInt(3, endrow);
			
			try (ResultSet rs = pstmt.executeQuery()){
				while(rs.next()) {
					NoticeBean nb = new NoticeBean();
					nb.setNotice_id(rs.getInt("notice_id"));
					nb.setTitle(rs.getString("title"));
					nb.setRegister_date(rs.getString("register_date"));
					nb.setReadcount(rs.getInt("readcount"));
					nb.setName(rs.getString("name"));
					
					list.add(nb);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getNoticeList(search_word) 에러 : " + e);
		}
		
		return list;
	}
	
}
