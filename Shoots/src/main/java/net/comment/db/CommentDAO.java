package net.comment.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
	
	
	
	


	public int commentsInsert(CommentBean co) {
		int result = 0;
		String sql = """
					insert into post_comment
					values (comment_seq.nextval, ?, ?, ?, ?, current_timestamp)
					""";
		//(comment_id, post_id, comment_ref_id, writer, content, register_date)
		
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			// 파라미터 설정 - 새로운 글을 등록하는 부분
			pstmt.setInt(1, co.getPost_id());  
			if(co.getComment_ref_id() == -1)
				pstmt.setNull(2, java.sql.Types.INTEGER);
			else
				pstmt.setInt(2, co.getComment_ref_id()); // 부모 댓글 ID (답글인 경우)
			pstmt.setInt(3, co.getWriter()); // 작성자 ID
			pstmt.setString(4, co.getContent()); // 댓글 내용
			
			//sql 실행
			result=pstmt.executeUpdate();
			
			if (result == 1)
				System.out.println("댓글이 등록되었습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("commentsInsert() 에러입니다." + e);
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
				select co.*, r.user_id, user_file
			    from post_comment co join regular_user r 
			    on co.writer = r.idx
	            where post_id = ?
	            order by comment_id %s, comment_ref_id asc
	            """.formatted(state == 1 ? "asc" : "desc");
		//.formatted(state == 1 ? "asc" : "desc"); // 등록순, 최신순 정렬 조건
					
		/*
		
		SELECT co.*, r.user_id
		FROM post_comment co
		JOIN regular_user r ON co.writer = r.idx
		WHERE co.post_id = 65
		ORDER BY co.comment_id ASC;
		
		*/
		
		JsonArray array = new JsonArray();
		
		try (Connection con = ds.getConnection();
				 PreparedStatement pstmt = con.prepareStatement(sql);) {
				
				pstmt.setInt(1, post_id);
				
				try (ResultSet rs = pstmt.executeQuery()) {
					
					while(rs.next()) {
						
						JsonObject object = new JsonObject();
						object.addProperty("comment_id", rs.getInt(1));
						object.addProperty("post_id", rs.getInt(2));
						object.addProperty("comment_ref_id", rs.getInt(3));
						//System.err.println("get :  + + + + + + +"  + object.get("comment_ref_id"));
						object.addProperty("writer", rs.getInt(4));
						object.addProperty("content", rs.getString(5));
						object.addProperty("register_date", rs.getString(6));
						object.addProperty("user_id", rs.getString(7));
						object.addProperty("user_file", rs.getString(8));
						array.add(object);
						
						
//						CommentBean co = new CommentBean();
//						co.setComment_id(rs.getInt("comment_id"));
//						co.setPost_id(rs.getInt("post_id"));
//						co.setComment_ref_id(rs.getInt("comment_ref_id"));
//						co.setWriter(rs.getInt("writer"));
//						co.setContent(rs.getString("content"));
//						co.setRegister_date(rs.getString("register_date"));
//						co.setUser_id(rs.getString("user_id"));
//						//co.setUser_file(rs.getString("user_file"));
//						list.add(co);
						
					}
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				System.out.println("getCommentList() 에러: " + ex);
			}
			return array;
	}



	public int commentDelete(int comment_id) {
		
		int result = 0;
		String sql = """
				delete from post_comment
				where comment_id = ?
				""";
		try (Connection con = ds.getConnection();
				 PreparedStatement pstmt = con.prepareStatement(sql);) {
			
					pstmt.setInt(1, comment_id);
					result = pstmt.executeUpdate();
					if (result == 1) 
						System.out.println("데이터 삭제 되었습니다.");
			} catch (Exception e) {
				e.printStackTrace();
			} 
		return result;
		
	}
	
	
	
	public int commentsUpdate(CommentBean co) {
		int result = 0;
		String sql = """
				update post_comment
				set content=?
				where comment_id = ?
				""";
		try (Connection con = ds.getConnection();
				 PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, co.getContent());
			pstmt.setInt(2, co.getComment_id());
			
			result = pstmt.executeUpdate();
			if (result == 1) 
				System.out.println("데이터 수정 되었습니다.");
			} catch (Exception e) {
				e.printStackTrace();
			} 
		return result;
	} //commentsUpdate()메서드 end
	
	
	
	
	
	
	public CommentBean getDetail(int comment_id) { //댓글의 고유번호에 해당하는 데이터값을 뽑아오는 메서드
		CommentBean co = new CommentBean();
		
		String sql = """
				select * from post_comment
				where comment_id = ?
				""";
		
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
				pstmt.setInt(1, comment_id);
					
					try (ResultSet rs = pstmt.executeQuery()){
						if (rs.next()) {
							co.setComment_id(rs.getInt("comment_id"));
							co.setPost_id(rs.getInt("post_id"));
							co.setComment_ref_id(rs.getInt("comment_ref_id"));
							co.setWriter(rs.getInt("writer"));
							co.setContent(rs.getString("content"));
							co.setRegister_date(rs.getString("register_date"));
						}
					}
				}catch (Exception ex) {
						System.out.println("getDetail() 에러:" + ex);
				}
		
		return co;
	}



	public int getListCountById(int idx) {
		String sql = """
				select count(*) from post_comment
				where writer = ?
				""";
		int x = 0;
		
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, idx);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					x = rs.getInt(1);
					
				}
			}
			} catch (Exception ex) {
				ex.printStackTrace();
				System.out.println("getListCountById() 에러: " + ex);
			}
		return x;
	}



	public List<CommentBean> getCommentById(int idx, int page, int limit) {
		String sql = """
				select * from (select pc.*, rownum rnum  
				from (select pc.*, u.user_id, p.title, p.category from post_comment pc
				inner join regular_user u on pc.writer = u.idx 
				inner join post p on pc.post_id = p.post_id
				where pc.writer = ?
				order by pc.register_date desc
				) pc
				where ROWNUM <= ?
				) 
				where rnum >= ?
				""";
		List<CommentBean> list = new ArrayList();
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareCall(sql);) {
			int startrow = (page - 1) * limit + 1;
			int endrow = startrow + limit - 1;
					
			pstmt.setInt(1, idx);
			pstmt.setInt(2, endrow);
			pstmt.setInt(3, startrow);
			try(ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					CommentBean comment =  new CommentBean();
					comment.setComment_id(rs.getInt("comment_id"));
					comment.setPost_id(rs.getInt("post_id"));
					comment.setComment_ref_id(rs.getInt("comment_ref_id"));
					comment.setWriter(rs.getInt("writer"));
					comment.setContent(rs.getString("content"));
					comment.setRegister_date(rs.getString("register_date"));
					comment.setUser_id(rs.getString("user_id"));
					comment.setPost_title(rs.getString("title"));
					comment.setCategory(rs.getString("category"));
					
					list.add(comment);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getCommentById() 에러 : " + e);
		}
		return list;
	}
	
	
	
	
	

	
	
	
	
	
}
