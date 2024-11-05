package net.inquiryComment.db;

import java.sql.Connection;
import java.sql.PreparedStatement;

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
	
	
	public int getCommentInsert(InquiryCommentBean ic, int inquiry_id) {
		int result = 0;
		
		String sql = """
				insert into inquiry_comment
				values (inquiry_comment_seq.nextval, ? , ? ,
						? , ? , current_timestamp) 
				""";
		
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
				pstmt.setInt(1, inquiry_id);
				pstmt.setInt(2, ic.getWriter());
				pstmt.setString(3, ic.getContent());
				pstmt.setString(4, ic.getComment_file());
				result = pstmt.executeUpdate();
				
				if(result == 1)
					System.out.println("문의글에 댓글이 등록되었습니다.");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("getCommentInsert() 에러입니다." + e);
		}
		
		return result;
	}
}
