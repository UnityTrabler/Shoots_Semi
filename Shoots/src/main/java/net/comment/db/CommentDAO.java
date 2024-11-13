package net.comment.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class CommentDAO {
	
	private DataSource ds;
	
	public CommentDAO() {
			try {
				Context init = new InitialContext();
				this.ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
			} catch (Exception ex) {
				System.out.println("DB 연결 실패 : " + ex);
			}
	}
	
	
	
	/*
	
	comment_id NUMBER(10) PRIMARY KEY, --댓글 식별 번호
    post_id NUMBER(10) references post(post_id) on delete cascade, --게시글 아이디
    comment_ref_id NUMBER(10), --부모 댓글 아이디
    writer NUMBER(10) references regular_user(idx) on delete cascade, --작성자
    content clob NOT NULL, --내용
    register_date DATE DEFAULT SYSDATE --등록일 
	
	*/
	
	
	
	


	public int commentsInsert(Comment co) {
		int result = 0;
		String sql = """
					insert into post_comment
					values (comment_seq.nextval, ?, ?, ?, ?, current_timestamp)
					""";
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			// 파라미터 설정 - 새로운 글을 등록하는 부분입니다.
			pstmt.setInt(1, co.getPost_id());
			pstmt.setInt(2, co.getComment_ref_id());
			pstmt.setInt(3, co.getWriter());
			pstmt.setString(4, co.getContent());
			
			//sql 실행
			result=pstmt.executeUpdate();
			if (result == 1)
				System.out.println("데이터 삽입 완료되었습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	
	public int getListCount(int post_id) {
		int x = 0;
		String sql = """
					select count(*) 
					from post_comment
					where post_id = ?
					""";
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			pstmt.setInt(1, post_id);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					x = rs.getInt(1);
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount() 에러: " + ex);
		}
		return x;
	}
	
	
	
	public JsonArray getCommentList(int post_id, int state) {
		String sql = """
				select co.*, r.user_id
            from post_comment co
            join regular_user r on co.writer = r.idx
            where post_id = ?
            order by comment_id 
            """ + (state == 1 ? "asc" : "desc"); // 등록순, 최신순 정렬 조건
					
		
		JsonArray array = new JsonArray();
		
		try (Connection con = ds.getConnection();
				 PreparedStatement pstmt = con.prepareStatement(sql);) {
				
				pstmt.setInt(1, post_id);
				
				try (ResultSet rs = pstmt.executeQuery()) {
					
					while(rs.next()) {
						JsonObject object = new JsonObject();
						object.addProperty("comment_id ", rs.getInt("comment_id"));
						object.addProperty("post_id ", rs.getInt("post_id"));
						object.addProperty("comment_ref_id ", rs.getInt("comment_ref_id"));
						object.addProperty("writer ", rs.getInt("writer"));
						object.addProperty("content ", rs.getString("content"));
						object.addProperty("register_date ", rs.getString("register_date"));
						object.addProperty("user_id", rs.getString("user_id"));
						//object.addProperty("user_file", rs.getString("user_file"));
						array.add(object);
					}
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				System.out.println("getCommentList() 에러: " + ex);
			}
			return array;
	}

	
	
	
	
	
	
}
