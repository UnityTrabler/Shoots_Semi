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
		// board_re_ref desc, voard_re_seq asc에 의해 정렬한 것을
		// 조건절에 맞는 rnum의 범위 만큼 가져오는 쿼리문입니다.
			
		String post_list_sql = """
					select *
					from post
					order by register_date desc;
				""";
		
		List<PostBean> list = new ArrayList<PostBean>();
										// 한 페이지당 10개씩 목록인 경우 1페이지, 2페이지, 3페이지...
		int startrow = (page - 1) * limit + 1; // 읽기 시작할 row 번호( 1		11		21	...
		int endrow = startrow + limit - 1; // 읽을 마지막 row 번호( 10		20		30	...
		
		try (Connection con = ds.getConnection();
				 PreparedStatement pstmt = con.prepareStatement(post_list_sql);) {
				
				pstmt.setInt(1, endrow);
				pstmt.setInt(2, startrow);
				pstmt.setInt(3, endrow);
			
				try (ResultSet rs = pstmt.executeQuery()) {
					
					//DB에서 가져온 데이터를 BoardBean에 담습니다.
					while(rs.next()) {
						PostBean post = new PostBean();
						post.setPost_id(rs.getInt("POST_ID"));
						post.setTitle(rs.getString("TITLE"));
						post.setWriter(rs.getInt("WRITER"));
						post.setRegister_date(rs.getString("REGISTER_DATE"));
						post.setReadcount(rs.getInt("READCOUNT"));
						
						list.add(post); // 값을 담은 객체를 리스트에 저장합니다.
					}
				}
				} catch (Exception ex) {
					ex.printStackTrace();
					System.out.println("getPostList() 에러: " + ex);
				}
			return list;
	}


	
	
	
	
}
