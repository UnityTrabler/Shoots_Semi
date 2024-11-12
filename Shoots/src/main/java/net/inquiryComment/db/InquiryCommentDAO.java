package net.inquiryComment.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class InquiryCommentDAO {
	
	private DataSource ds;

	public InquiryCommentDAO() {
		try {
			Context init = new InitialContext();
			this.ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
		}
	}
	
	
	public int getCommentInsert(InquiryCommentBean ic, int inquiry_id) { //댓글을 등록하면 DB에 댓글 넣는 메서드
		int result = 0;
		
		String sql = """
				insert into inquiry_comment
				values (inquiry_comment_seq.nextval, ? , ? ,
						? , current_timestamp) 
				""";
		
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
				pstmt.setInt(1, inquiry_id);
				pstmt.setInt(2, ic.getWriter());
				pstmt.setString(3, ic.getContent());
				result = pstmt.executeUpdate();
				
				if(result == 1)
					System.out.println("문의글에 댓글이 등록되었습니다.");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("getCommentInsert() 에러입니다." + e);
		}
		
		return result;
	}


	public int getListCount(int inquiry_id) {
		
		int x = 0;
		
		String sql = """
				select count(*)
				from inquiry_comment
				where inquiry_id = ?
				""";
		
		try(Connection con = ds.getConnection(); 
			PreparedStatement pstmt = con.prepareStatement(sql);){
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					x = rs.getInt(1);
				}
			}
		} catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount() 에러" + ex);
		}
		
		
		return x;
	} //getListCount() 끝


	public List<InquiryCommentBean> getIqList(int inquiry_id) { //댓글들 리스트 쭉 뽑아내는 메서드
		List<InquiryCommentBean> list = new ArrayList<InquiryCommentBean>();
		
		String sql = """
				select * from (
						select ic.*, r.user_id
						from inquiry_comment ic
						join regular_user r
						on ic.writer = r.idx)
				where inquiry_id = ?
				order by i_comment_id asc
				""";

		try (Connection con = ds.getConnection(); 
			PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setInt(1, inquiry_id);
			
			try(ResultSet rs = pstmt.executeQuery()){
				while (rs.next()) {
					InquiryCommentBean ic = new InquiryCommentBean();
					ic.setI_comment_id(rs.getInt("i_comment_id"));
					ic.setInquiry_id(rs.getInt("inquiry_id"));
					ic.setWriter(rs.getInt("writer"));
					ic.setContent(rs.getString("content"));
					ic.setRegister_date(rs.getString("register_date"));
					ic.setUser_id(rs.getString("user_id"));
					list.add(ic);
				}
			}
		} catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getIqList() 에러" + ex);
		}
		
		return list;
	} //getIqList() 끝
	
	
	
	
}
