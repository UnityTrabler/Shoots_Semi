package net.post.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class PostDAO {
	
private DataSource ds;
	
	public PostDAO() {
			try {
				Context init = new InitialContext();
				this.ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
			} catch (Exception ex) {
				System.out.println("DB 연결 실패 : " + ex);
			}
	}

	
	
	public int getListCount() {
		String sql = "select count(*) from post";
		int x = 0;
		
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);) {
			
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
	
	
	

	public List<PostBean> getPostList(int page, int limit) {
		// page : 페이지
		// limit : 페이지 당 목록의 수
			
		String post_list_sql = """
					select *
					from post
					where category = 'A'
					order by register_date desc
				""";
		
		List<PostBean> list = new ArrayList<PostBean>();
			
		try (Connection con = ds.getConnection();
				 PreparedStatement pstmt = con.prepareStatement(post_list_sql);) {
				
			
				try (ResultSet rs = pstmt.executeQuery()) {
					
					//DB에서 가져온 데이터를 PostBean에 담습니다.
					while(rs.next()) {
						PostBean post = new PostBean();
						post.setPost_id(rs.getInt("POST_ID"));
						post.setWriter(rs.getInt("WRITER"));
						 
						post.setTitle(rs.getString("TITLE"));
						
						post.setRegister_date(rs.getString("REGISTER_DATE"));
						post.setReadcount(rs.getInt("READCOUNT"));
						
						/*
						post.setCategory(rs.getString("CATEGORY"));
						post.setContent(rs.getString("CONTENT"));
						post.setPost_file(rs.getString("POST_FILE"));
						post.setPrice(rs.getInt("PRICE"));
						*/
						//if()
						list.add(post); // 값을 담은 객체를 리스트에 저장합니다.
					}
				}
				} catch (Exception ex) {
					ex.printStackTrace();
					System.out.println("getPostList() 에러: " + ex);
				}
			return list;
	}



	// 글쓰기
	public boolean postInsert(PostBean postdata) {
		int result = 0;
		
		String sql = """
				insert into post
				(post_id, writer, category, title,
				content, post_file, price, register_date, readcount)
				values(post_seq.nextval, ?, ?, ?, 
						?, ?, ?, current_timestamp, ?)
				""";
		
		/*
		 	post_id NUMBER(10) PRIMARY KEY, --게시글 식별 번호 (글번호)
		    writer NUMBER(10) NOT NULL, --작성자
		    category char(1) CHECK (category IN ('A', 'B')), --글 종류
		    title VARCHAR2(100) NOT NULL, --제목
		    content clob NOT NULL, --내용
		    post_file VARCHAR2(50), --첨부파일
		    price NUMBER(10), --가격 // 중고게시판에서만 사용할거라 뻄
		    register_date DATE DEFAULT SYSDATE --등록일
		    readcount number -- 조회수
		 */
		 
		
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			// 새로운 글을 등록하는 부분입니다.
			pstmt.setInt(1,  postdata.getWriter());
			pstmt.setString(2,  postdata.getCategory());
			pstmt.setString(3,  postdata.getTitle());
			pstmt.setString(4,  postdata.getContent());
			pstmt.setString(5,  postdata.getPost_file());
			pstmt.setInt(6, postdata.getPrice());
			pstmt.setInt(7, postdata.getReadcount());
			System.out.println("content 값은? " + postdata.getContent());
			result = pstmt.executeUpdate();
			if (result == 1) {
				System.out.println("데이터 삽입이 모두 완료되었습니다.");
				return true;
			}
		} catch (Exception ex) {
			System.out.println("postInsert() 에러 : " + ex);
			ex.printStackTrace();
		}
		return false;
	}




	
	
	
	
}
