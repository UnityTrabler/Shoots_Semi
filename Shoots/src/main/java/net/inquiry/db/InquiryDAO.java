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

	public InquiryDAO() {
		try {
			Context init = new InitialContext();
			this.ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
		}
	}

	public int getListCount() {
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

	public List<InquiryBean> getInquiryList(int page, int limit) {
		// page : 페이지
		// limit : 페이지 당 목록수
		// board_re_ref desc, board_re_seq asc에 의해 정렬한 것을 조건절에 맞는 rnum의 범위만큼 가져오는 쿼리문

		String board_list_sql = """
								select *
				from (select rownum rnum, j.*
						from (select inquiry.*, nvl(cnt, 0) as cnt
								from board left outer join (select comment_board_num, count(*) cnt
															from comm
															group by comment_board_num)
								on board_num=comment_board_num
								order by Board_re_ref desc,
								board_re_seq asc
								) j
						where rownum <= ?)
				where rnum >= ? and rnum <= ?
								""";

		List<InquiryBean> list = new ArrayList<InquiryBean>();
								//한 페이지당 10개씩 목록인 경우 1페이지, 2, 3, 4페이지...
		int startrow = (page - 1) * limit + 1; //읽기 시작할 row 번호 (1 11 1 31 ...
		int endrow = startrow + limit - 1; // 읽을 마지막 row 번호 (10 20 30 40 ...
		
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(board_list_sql);){
					pstmt.setInt(1, endrow);
					pstmt.setInt(2, startrow);
					pstmt.setInt(3, endrow);
					
					try (ResultSet rs = pstmt.executeQuery()){
						
						//DB에서 가져온 데이터를 InquiryBean에 담음
						while (rs.next()) {
							InquiryBean board = new InquiryBean();
							board.setBoard_num(rs.getInt("board_num"));
							board.setBoard_name(rs.getString("board_name"));
							board.setBoard_subject(rs.getString("board_subject"));
							board.setBoard_content(rs.getString("board_content"));
							board.setBoard_file(rs.getString("board_file"));
							board.setBoard_re_ref(rs.getInt("board_re_ref"));
							board.setBoard_re_lev(rs.getInt("board_re_lev"));
							board.setBoard_re_seq(rs.getInt("board_re_seq"));
							board.setBoard_readcount(rs.getInt("board_readcount"));
							board.setBoard_date(rs.getString("board_date"));
							board.setCnt(rs.getInt("cnt"));
							list.add(board);
						}
					}
				} catch(Exception ex) {
					ex.printStackTrace();
					System.out.println("getBoardList() 에러 : " + ex);
				}
				return list;
	}
	
	public boolean boardInsert(InquiryBean board) {
		int result=0;
		String max_sql = "(select nvl(max(board_num),0)+1 from board)";
		
		//원문글의 BOARD_RE_REF 는 자신의 글번호.
		//%1$s : 첫번째 인자를 문자열로 출력.
		String sql = """
					insert into board
					(BOARD_NUM, BOARD_NAME, BOARD_PASS, BOARD_SUBJECT,
					 BOARD_CONTENT, BOARD_FILE, BOARD_RE_REF,
					 BOARD_RE_LEV, BOARD_RE_SEQ, BOARD_READCOUNT)
					 values( %1$s , ? , ? , ? ,
					 		  ?,	?,	%1$s,
					 		  ?,	?,	?)
				""".formatted(max_sql);
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			
			//새 글 등록부분
			pstmt.setString(1, board.getBoard_name());
			pstmt.setString(2, board.getBoard_pass());
			pstmt.setString(3, board.getBoard_subject());
			pstmt.setString(4, board.getBoard_content());
			pstmt.setString(5, board.getBoard_file());
			
			
			//원문의 경우 Board_re_Lev, Board_re_seq 필드값은 0임
			pstmt.setInt(6, 0); //board_Re_lev 필드
			pstmt.setInt(7, 0); //board_re_seq 필드
			pstmt.setInt(8, 0); //board_readcount 필드
			
			result = pstmt.executeUpdate();
			if(result ==1) {
				System.out.println("데이터 삽입 다 됐다");
				return true;
			}
			
			
		} catch (Exception e) {
			System.out.println("boardInsert() 에러: " + e);
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
	
	
	
	public InquiryBean getDetail(int num) {
		InquiryBean board = null;
		String sql = """
				select *
				from board
				where board_num = ?
				""";
		
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
				pstmt.setInt(1, num);
					
					try (ResultSet rs = pstmt.executeQuery()){
						if (rs.next()) {
							board = new InquiryBean();
							board.setBoard_num(rs.getInt("board_num"));
							board.setBoard_name(rs.getString("board_name"));
							board.setBoard_subject(rs.getString("board_subject"));
							board.setBoard_content(rs.getString("board_content"));
							board.setBoard_file(rs.getString("board_file"));
							board.setBoard_re_ref(rs.getInt("board_re_ref"));
							board.setBoard_re_lev(rs.getInt("board_re_lev"));
							board.setBoard_re_seq(rs.getInt("board_re_seq"));
							board.setBoard_readcount(rs.getInt("board_readcount"));
							board.setBoard_date(rs.getString("board_date"));
						}
					}
				}catch (Exception ex) {
						System.out.println("getDetail() 에러:" + ex);
				}
		
		return board;
	} //getDetail()메서드

	public boolean isBoardWriter(int num, String pass) {
		boolean result = false;
		String board_sql = """
				select BOARD_PASS
				from board
				where BOARD_NUM =?
				""";
		
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(board_sql);){
					pstmt.setInt(1, num);
					
					try(ResultSet rs = pstmt.executeQuery()){
						if(rs.next()) {
							if(pass.equals(rs.getString("BOARD_PASS"))) {
								result = true;
							}
						}
					}
					
				} catch (SQLException ex) {
					ex.printStackTrace();
					System.out.println("isBoardWriter() 에러: " + ex);
				}
			return result;
		
	} //isBoardWriter 끝

	
	public boolean boardModify(InquiryBean boarddata) {
		String board_sql = """
				update board
				set BOARD_SUBJECT = ? , BOARD_CONTENT = ?, BOARD_FILE = ?
				where BOARD_NUM = ?
				""";
		
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(board_sql);){
					pstmt.setString(1, boarddata.getBoard_subject());
					pstmt.setString(2, boarddata.getBoard_content());
					pstmt.setString(3, boarddata.getBoard_file());
					pstmt.setInt(4, boarddata.getBoard_num());
					int result = pstmt.executeUpdate();
					
					if(result ==1) {
						System.out.println("업데이트 성공");
						return true;
					}
					
				} catch (SQLException ex) {
					System.out.println("boardModify() 에러: " + ex);
				}
		
		return false;
	} //boardModify () 메서드 끝

	public int boardReply(InquiryBean board) {
		int num = 0;
		
		try(Connection con = ds.getConnection();){
			//트랜잭션을 이용하기 위해 setAutoCommit을 false로 설정함
			con.setAutoCommit(false);
			
			try {
				reply_update(con, board.getBoard_re_ref(), board.getBoard_re_seq());
				num = reply_insert(con, board);
				con.commit();
			}
			catch(SQLException e){
				e.printStackTrace();
				
				if(con != null) {
					try {
						con.rollback();
					} catch(SQLException ex) {
						ex.printStackTrace();
					}
				}
			}
			con.setAutoCommit(true);
		} catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("boardReply() 에러: " + ex);
		}
		return num;
	}//boardReply() 끝

	
	
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
			pstmt.setInt(1, num);
			pstmt.setString(2, board.getBoard_name());
			pstmt.setString(3, board.getBoard_pass());
			pstmt.setString(4, board.getBoard_subject());
			pstmt.setString(5, board.getBoard_content());
			pstmt.setString(6, ""); //답변에는 파일 업로드 안함.
			pstmt.setInt(7, board.getBoard_re_ref()); //원문의 글번호
			pstmt.setInt(8, board.getBoard_re_lev() + 1);
			pstmt.setInt(9, board.getBoard_re_seq() + 1);
			pstmt.setInt(10, 0); //BOARD_READCOUNT(조회수)는 0
			pstmt.executeUpdate();
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

	public boolean boardDelete(int num) {
		String select_sql = """
				select BOARD_RE_REF, BOARD_RE_LEV, BOARD_RE_SEQ
				from board
				where BOARD_NUM = ?
				""";
		String board_delete_sql = """
				delete from board
			where board_re_ref = ?
			and board_re_lev >= ?
			and board_re_seq >= ?
			and board_re_seq <= ( nvl((select min (board_re_seq)-1
					from board
					where board_re_ref =?
					and board_re_lev = ?
					and board_re_seq > ?) ,(select max(board_re_seq)
							from board
							where board_re_ref = ?) )
					)
				""";
		
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(select_sql);){
			pstmt.setInt(1, num);
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()) {
					try(PreparedStatement pstmt2 = con.prepareStatement(board_delete_sql);){
					pstmt2.setInt(1, rs.getInt("BOARD_RE_REF"));
					pstmt2.setInt(2, rs.getInt("BOARD_RE_LEV"));
					pstmt2.setInt(3, rs.getInt("BOARD_RE_SEQ"));
					pstmt2.setInt(4, rs.getInt("BOARD_RE_REF"));
					pstmt2.setInt(5, rs.getInt("BOARD_RE_LEV"));
					pstmt2.setInt(6, rs.getInt("BOARD_RE_SEQ"));
					pstmt2.setInt(7, rs.getInt("BOARD_RE_REF"));
					
					if(pstmt2.executeUpdate() >= 1)
						return true; //삭제가 안된 경우에는 false를 반환함.
					} //try 3
				} // if (rs.next()){
			}  //try2
		} catch(Exception ex) {
			System.out.println("boardDelete()에러: " + ex);
			ex.printStackTrace();
		}
		
		return false;
	} //boardDelete()메서드 끝

}
