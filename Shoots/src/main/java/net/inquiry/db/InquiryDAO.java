package net.inquiry.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class InquiryDAO {
	
	private DataSource ds;

	public InquiryDAO() { //DB와 연결
		try {
			Context init = new InitialContext();
			this.ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
		}
	}

	public int getListCount() { //문의글의 총 개수를 세는 메서드
		String sql = "select count(*) from inquiry";
		int x = 0;
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					x = rs.getInt(1);
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount() 에러: " + ex);
		}
		return x;
	} // getListCount() end

	public List<InquiryBean> getInquiryList(int page, int limit) { //문의글의 글 페이지네이션 + 리스트 뜨게 하는 메서드
		// page : 페이지
		// limit : 페이지 당 목록수

		String sql = """
			select * from (
							SELECT ROWNUM rnum, inquiry_id, inquiry_type, inquiry_ref_idx, title, content, inquiry_file, register_date, user_id
							FROM(
								select i.*, r.user_id 
								from inquiry i 
								join regular_user r 
								on i.inquiry_ref_idx = r.idx
								order by inquiry_id desc
								)
							where rownum <= ? 
			) where rnum >= ?
					 """;

		List<InquiryBean> list = new ArrayList<InquiryBean>();
								//한 페이지당 10개씩 목록인 경우 1페이지, 2, 3, 4페이지...
		int startrow = (page - 1) * limit + 1; //읽기 시작할 row 번호 (1 11 1 31 ...
		int endrow = startrow + limit - 1; // 읽을 마지막 row 번호 (10 20 30 40 ...
		
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
					pstmt.setInt(1, endrow);
					pstmt.setInt(2, startrow);
					
					try (ResultSet rs = pstmt.executeQuery()){
						//DB에서 가져온 데이터를 InquiryBean에 담음
						while (rs.next()) {
							InquiryBean ib = new InquiryBean();
							ib.setInquiry_id(rs.getInt("inquiry_id"));
							ib.setInquiry_type(rs.getString("inquiry_type"));
							ib.setInquiry_ref_idx(rs.getInt("inquiry_ref_idx"));
							ib.setTitle(rs.getString("title"));
							ib.setContent(rs.getString("content"));
							ib.setInquiry_file(rs.getString("inquiry_file"));
							ib.setRegister_date(rs.getString("register_date").substring(0,16));
							ib.setUser_id(rs.getString("user_id"));
							list.add(ib);
						}
					}
				} catch(Exception ex) {
					ex.printStackTrace();
					System.out.println("getInquiryList() 에러 : " + ex);
				}
				return list;
	}
	
	public boolean inquiryInsert(InquiryBean iq) { //문의글 작성시 적은 글의 데이터를 삽입하는 메서드
		int result=0;
		
		//원문글의 BOARD_RE_REF 는 자신의 글번호.
		//%1$s : 첫번째 인자를 문자열로 출력.
		String sql = """
					insert into inquiry
					(inquiry_id, inquiry_ref_idx, inquiry_type, 
					title, content, inquiry_file, register_date)
					 values(inquiry_seq.nextval, ?, ?,
					 		?, ?, ?, current_timestamp)
				""";
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, iq.getInquiry_ref_idx());
			pstmt.setString(2, iq.getInquiry_type());
			pstmt.setString(3, iq.getTitle());
			pstmt.setString(4, iq.getContent());
			pstmt.setString(5, iq.getInquiry_file());
			result = pstmt.executeUpdate();
			if(result ==1) {
				System.out.println("데이터가 다 삽입 됐습니다.");
				return true;
			}
			
			
		} catch (Exception e) {
			System.out.println("InquiryInsert() 에러: " + e);
			e.printStackTrace();
		}
		
		return false;
	}//boardInsert()

	
	public void setReadCountUpdate(int num) {
	
		String sql ="""
				update board
				set board_readcount = board_readcount +1
				where board_num =?
				""";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setInt(1, num);
		} catch (SQLException ex) {
			System.out.println("setReadCountUpdate() 에러:" + ex);
		}
		
	
	} //setReadCountupdate 
	
	
	
	public InquiryBean getDetail(int inquiryid) { //문의글을 누르면 상세 페이지가 나오게 하는 메서드
		InquiryBean ib = new InquiryBean();
		String sql = """
				select * from(
							select i.*, r.user_id 
							from inquiry i 
							join regular_user r 
							on i.inquiry_ref_idx = r.idx
							order by inquiry_id desc
							)
				where inquiry_id = ?
				""";
		
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
				pstmt.setInt(1, inquiryid);
					
					try (ResultSet rs = pstmt.executeQuery()){
						if (rs.next()) {
							ib.setInquiry_id(rs.getInt("inquiry_id"));
							ib.setInquiry_type(rs.getString("inquiry_type"));
							ib.setInquiry_ref_idx(rs.getInt("inquiry_ref_idx"));
							ib.setTitle(rs.getString("title"));
							ib.setContent(rs.getString("content"));
							ib.setInquiry_file(rs.getString("inquiry_file"));
							ib.setRegister_date(rs.getString("register_date"));
							ib.setUser_id(rs.getString("user_id"));
						}
					}
				}catch (Exception ex) {
						System.out.println("getDetail() 에러:" + ex);
				}
		
		return ib;
	} //getDetail()메서드

//	글 수정하기 전에 작성자의 비번과 수정시도자의 입력비번을 검증하는 메서드.
//	public boolean isBoardWriter(int listnum, int id) {
//		boolean result = false;
//		String board_sql = """
//				select inquiry_ref_idx
//				from inquiry
//				where inquiry_id =?
//				""";
//		
//		try(Connection con = ds.getConnection();
//				PreparedStatement pstmt = con.prepareStatement(board_sql);){
//					pstmt.setInt(1, listnum);
//					
//					try(ResultSet rs = pstmt.executeQuery()){
//						if(rs.next()) {
//							if(id == rs.getInt("inquiry_ref_idx")) {
//								result = true;
//							}
//						}
//					}
//					
//				} catch (SQLException ex) {
//					ex.printStackTrace();
//					System.out.println("isBoardWriter() 에러: " + ex);
//				}
//			return result;
//		
//	} //isBoardWriter 끝

	
	public boolean inquiryModify(InquiryBean inquirydata) {
		String sql = """
				update inquiry
				set title = ? , content = ?, inquiry_file = ?
				where inquiry_id = ?
				""";
		
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
					pstmt.setString(1, inquirydata.getTitle());
					pstmt.setString(2, inquirydata.getContent());
					pstmt.setString(3, inquirydata.getInquiry_file());
					pstmt.setInt(4, inquirydata.getInquiry_id());
					int result = pstmt.executeUpdate();
					
					if(result ==1) {
						System.out.println("업데이트에 성공했습니다.");
						return true;
					}
					
				} catch (SQLException ex) {
					System.out.println("inquiryModify() 에러: " + ex);
				}
		
		return false;
	} //boardModify () 메서드 끝

//	public int boardReply(InquiryBean board) {
//		int num = 0;
//		
//		try(Connection con = ds.getConnection();){
//			//트랜잭션을 이용하기 위해 setAutoCommit을 false로 설정함
//			con.setAutoCommit(false);
//			
//			try {
//				reply_update(con, board.getBoard_re_ref(), board.getBoard_re_seq());
//				num = reply_insert(con, board);
//				con.commit();
//			}
//			catch(SQLException e){
//				e.printStackTrace();
//				
//				if(con != null) {
//					try {
//						con.rollback();
//					} catch(SQLException ex) {
//						ex.printStackTrace();
//					}
//				}
//			}
//			con.setAutoCommit(true);
//		} catch(Exception ex) {
//			ex.printStackTrace();
//			System.out.println("boardReply() 에러: " + ex);
//		}
//		return num;
//	}//boardReply() 끝

	
	
	private int reply_insert(Connection con, InquiryBean board) throws SQLException{
		int num = 0;
		String board_max_sql = "select max(board_num) +1 from board";
		try(PreparedStatement pstmt = con.prepareStatement(board_max_sql);){
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					num=rs.getInt(1);
				}
			}
		}
		
		String sql = """
				insert into board
				(BOARD_NUM, BOARD_NAME, BOARD_PASS, BOARD_SUBJECT,
				BOARD_CONTENT, BOARD_FILE, BOARD_RE_REF, 
				BOARD_RE_LEV, BOARD_RE_SEQ, BOARD_READCOUNT)
				values(?, ?, ?, ?,
					?, ?, ?,
					?, ?, ?)
				""";
		try(PreparedStatement pstmt = con.prepareStatement(sql);){
//			pstmt.setInt(1, num);
//			pstmt.setString(2, board.getBoard_name());
//			pstmt.setString(3, board.getBoard_pass());
//			pstmt.setString(4, board.getBoard_subject());
//			pstmt.setString(5, board.getBoard_content());
//			pstmt.setString(6, ""); //답변에는 파일 업로드 안함.
//			pstmt.setInt(7, board.getBoard_re_ref()); //원문의 글번호
//			pstmt.setInt(8, board.getBoard_re_lev() + 1);
//			pstmt.setInt(9, board.getBoard_re_seq() + 1);
//			pstmt.setInt(10, 0); //BOARD_READCOUNT(조회수)는 0
//			pstmt.executeUpdate();
		}
		
		return num;
	} //reply_insert() 끝

	private void reply_update(Connection con, int board_re_ref, int board_re_seq) throws SQLException{
		/*BOARD_RE_REF, BOARD_RE_SEQ 값을 확인하여 원문 글에 답글이 달렸으면
		달린 답글들의 BOARD_RE_SEQ값을 1씩 증가시킴.
		현재 글을 이미 달린 답글보다 앞에 출력되게 하기 위함.
		*/
		
		String sql = """
				update board
				set BOARD_RE_SEQ = BOARD_RE_SEQ + 1
				where BOARD_RE_REF = ?
				and BOARD_RE_SEQ > ?
				""";
		
		try(PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setInt(1, board_re_ref);
			pstmt.setInt(2, board_re_seq);
			pstmt.executeUpdate();
		}
		
	} //reply_update() 끝 

	
	public boolean boardDelete(int num) { //문의글 삭제하는 메서드
		String inquiry_delete_sql = """
				delete from inquiry
			where inquiry_id = ?
				""";
		
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(inquiry_delete_sql);){
			pstmt.setInt(1, num);
			int result = pstmt.executeUpdate();
			
			if(result ==1) {
				System.out.println("데이터가 삭제되었습니다.");
				return true;
			}
			
		} catch(Exception ex) {
			System.out.println("inquiryDelete()에러: " + ex);
			ex.printStackTrace();
		}
		
		return false;
	} //boardDelete()메서드 끝

}
