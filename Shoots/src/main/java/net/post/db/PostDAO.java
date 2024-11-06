package net.post.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import net.inquiry.db.InquiryBean;

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

	
	
	public int getListCount(String category) {
		String sql = "select count(*) from post where category = ?";
		int x = 0;
		
		try (Connection con = ds.getConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, category);
			
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
	
	
	

	public List<PostBean> getPostList(String category, int page, int limit) {
		// page : 페이지
		// limit : 페이지 당 목록의 수
			
		String post_list_sql = """
				select *
				from post
				where category = ?
				order by register_date desc
			""";
//		 자유(A), 중고(B) << 카테고리 나누는거 해결하기
//		 동휘씨가 자꾸 한줄만 추가하면 된다는데
//		 한줄은 좀 오바같고 진짜 모르겠음
		
		List<PostBean> list = new ArrayList<PostBean>();
			
		try (Connection con = ds.getConnection();
				 PreparedStatement pstmt = con.prepareStatement(post_list_sql);) {
				
			
//	        int startRow = (page - 1) * limit; // 시작 행 계산
	        pstmt.setString(1, category); // 카테고리와 페이지, 한 페이지에 보여줄 게시글 수를 세팅
//	        pstmt.setInt(2, startRow);  // 시작 위치
//	        pstmt.setInt(3, limit);     // 페이지 당 보여줄 게시글 수
	        
			/*
			 int startRow = (page - 1) * limit; // 시작 행 계산
		        pstmt.setString(1, category);
		        pstmt.setInt(2, page * limit);
		        pstmt.setInt(3, startRow);
			 */
			
				try (ResultSet rs = pstmt.executeQuery()) {
					
					//DB에서 가져온 데이터를 PostBean에 담습니다.
					while(rs.next()) {
						PostBean post = new PostBean();
						post.setPost_id(rs.getInt("POST_ID"));
						post.setWriter(rs.getInt("WRITER"));
						post.setTitle(rs.getString("TITLE"));
						post.setContent(rs.getString("content"));
		                post.setPrice(rs.getInt("price"));
		                post.setPost_file(rs.getString("post_file"));
		                post.setCategory(rs.getString("category"));
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
	
	
	
	
	
	public void setReadCountUpdate(int num) {
		String sql = """
				update post
				set READCOUNT = READCOUNT + 1
				where POST_ID = ?
				""";
		try (Connection con = ds.getConnection();
				 PreparedStatement pstmt = con.prepareStatement(sql);) {
				
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				
			} catch (Exception ex) {
				ex.printStackTrace();
				System.out.println("getReadCountUpdate() 에러: " + ex);
			} 
	}
	
	
	
	
	public PostBean getDetail(int num) {
		PostBean post = null;
		
		String post_getDetail_sql = """
				select *
				from post
				where post_id = ?
				""";
			
			try (Connection con = ds.getConnection();
					 PreparedStatement pstmt = con.prepareStatement(post_getDetail_sql);) {
					
					pstmt.setInt(1, num);
				
					try (ResultSet rs = pstmt.executeQuery()) {
						if(rs.next()) {
							post = new PostBean();
							post.setPost_id(rs.getInt("POST_ID"));
							post.setWriter(rs.getInt("WRITER"));
							post.setCategory(rs.getString("CATEGORY"));
							post.setTitle(rs.getString("TITLE"));
							post.setContent(rs.getString("CONTENT"));
							post.setPost_file(rs.getString("POST_FILE"));
							post.setPrice(rs.getInt("PRICE"));
							post.setRegister_date(rs.getString("REGISTER_DATE"));
							post.setReadcount(rs.getInt("READCOUNT"));
						}
					}
					} catch (Exception ex) {
						ex.printStackTrace();
						System.out.println("getDetail() 에러: " + ex);
					}
				return post;
	}


	
	

//	public boolean isPostWriter(int num, int writer) {
//		boolean result = false;
//		String post_sql = """
//				select writer
//				from post
//				where post_id=?
//				""";
//		
//		try (Connection con = ds.getConnection();
//			 PreparedStatement pstmt = con.prepareStatement(post_sql);) {
//			 pstmt.setInt(1,  num);
//			 
//			 try (ResultSet rs = pstmt.executeQuery()) {
//				 if (rs.next()) {
//					 if (writer == rs.getInt("writer")) {
//						 result = true;
//					 }
//				 }
//			 }
//		} catch (SQLException ex) {
//			ex.printStackTrace();
//			System.out.println("isPostWriter() 에러 : " + ex);
//		}
//		return result;
//	}



	
	
	public boolean postModify(PostBean postdata) {
		String sql = """
				update post
				set writer=?, title=?, content=?, post_file=?
				where post_id = ?
				""";
		
		try (Connection con = ds.getConnection();
				 PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, postdata.getWriter());
			pstmt.setString(2, postdata.getTitle());
			pstmt.setString(3, postdata.getContent());
			pstmt.setString(4, postdata.getPost_file());
			pstmt.setInt(5, postdata.getPost_id());
			
			int result = pstmt.executeUpdate();
			if (result == 1) {
				System.out.println("성공 업데이트");
				return true;
			}
			} catch (Exception ex) {
				ex.printStackTrace();
				System.out.println("postModify() 에러: " + ex);
			} 
		return false;
	}


	

	public boolean postDelete(int num) {
		String select_sql = """
					select *
					from post
					where POST_ID = ?
				""";
		
		String post_delete_sql = """
					DELETE FROM POST
					where POST_ID = ?
				""";
		
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(select_sql);) { //1
			pstmt.setInt(1,  num);
			
			try (ResultSet rs = pstmt.executeQuery();) { //2
				if(rs.next()) {
		try(PreparedStatement pstmt2 = con.prepareStatement(post_delete_sql)) { //3
			pstmt2.setInt(1,  rs.getInt("POST_ID"));
			
			if(pstmt2.executeUpdate() >= 1)
				return true; // 삭제가 안된 경우에는 false를 반환합니다.
				}//try 3
		}// if (rs.next()) {
	}//try2
		} catch (Exception ex) {
			System.out.println("postDelete() 에러 : " + ex);
			ex.printStackTrace();
		}
			return false;
	}
	
	
	
}
