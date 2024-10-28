package net.board.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import net.board.action.BoardBean;

public class BoardDAO {

	private DataSource ds;

	public BoardDAO() {
		try {
			Context init = new InitialContext();
			this.ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
		}
	}

	public int getListCount() {
		String sql = "select count(*) from board";
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

	public List<BoardBean> getBoardList(int page, int limit) {
		// page : 페이지
		// limt : 페이지 당 목록수
		// board_re_ref desc, board_re_seq asc에 의해 정렬한 것을 조건절에 맞는 rnum의 범위만큼 가져오는 쿼리문

		String board_list_sql = """
								select *
				from (select rownum rnum, j.*
						from (select board.*, nvl(cnt, 0) as cnt
								from board left outer join (select comment_board_num, count(*) cnt
															from comm
															group by comment_board_num)
								on board_num=comment_board_num
								order by Board_re_ref desc,
								board_re_seq asc
								) j
						where rownum <= ?)
				where rnum >=? and rnum <=?
								""";

		List<BoardBean> list = new ArrayList<BoardBean>(); // 한 페이지당 10개씩 목록인 경우 1페이지, 2, 3, 4페이지...
		int startrow = (page - 1) * limit + 1; // 읽기 시작할 row 번호 (1 11 1 31 ...
		int endrow = startrow + limit - 1; // 읽을 마지막 row 번호 (10 20 30 40 ...

		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(board_list_sql);) {
			pstmt.setInt(1, endrow);
			pstmt.setInt(2, startrow);
			pstmt.setInt(3, endrow);

			try (ResultSet rs = pstmt.executeQuery();) {

				// DB에서 가져온 데이터를 BoardBean에 담음
				while (rs.next()) {
					BoardBean board = new BoardBean();
					board.setBoard_num(rs.getInt("BOARD_NUM"));
					board.setBoard_name(rs.getString("BOARD_NAME"));
					board.setBoard_subject(rs.getString("BOARD_SUBJECT"));
					board.setBoard_content(rs.getString("BOARD_CONTENT"));
					board.setBoard_file(rs.getString("BOARD_FILE"));
					board.setBoard_re_ref(rs.getInt("BOARD_RE_REF"));
					board.setBoard_re_lev(rs.getInt("BOARD_RE_LEV"));
					board.setBoard_re_seq(rs.getInt("BOARD_RE_SEQ"));
					board.setBoard_readcount(rs.getInt("BOARD_READCOUNT"));
					board.setBoard_date(rs.getString("BOARD_DATE"));
					board.setCnt(rs.getInt("cnt"));
					list.add(board);
				}
			} // try
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("getBoardList() error : " + e);
		}

		return list;
	}

	public boolean boardInsert(BoardBean board) {
		int result = 0;
		String max_sql = "(select nvl(max(board_num),0)+1 from board)";

		// 원문글의 BOARD_RE_REF 는 자신의 글번호.
		// %1$s : 첫번째 인자를 문자열로 출력.
		String sql = """
					insert into board
					(BOARD_NUM, BOARD_NAME, BOARD_PASS, BOARD_SUBJECT,
					 BOARD_CONTENT, BOARD_FILE, BOARD_RE_REF,
					 BOARD_RE_LEV, BOARd_RE_SEQ, BOARD_READCOUNT)
					 values( %1$s , ? , ? , ? ,
					 		  ?,	?,	%1$s,
					 		  ?,	?,	?)
				""".formatted(max_sql);
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			// 새 글 등록
			pstmt.setString(1, board.getBoard_name());
			pstmt.setString(2, board.getBoard_pass());
			pstmt.setString(3, board.getBoard_subject());
			pstmt.setString(4, board.getBoard_content());
			pstmt.setString(5, board.getBoard_file());

			// 원문 - BOARD_RE_LEV, BOARD_RE_SEQ = 0
			pstmt.setInt(6, 0); // BOARD_RE_LEV
			pstmt.setInt(7, 0); // BOARD_RE_SEQ
			pstmt.setInt(8, 0); // BOARD_RE_READCOUNT

			result = pstmt.executeUpdate();
			if (result == 1) {
				System.out.println("데이터 삽입 모두 완료.");
				return true;
			}

		} catch (SQLException e) {
			System.out.println("boardInsert() 에러 : " + e);
			e.printStackTrace();
		}

		return false;
	}

	public void setReadCountUpdate(int num) {
		String sql = """
				update board
				set board_readcount = board_readcount +1
				where board_num =?
				""";
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, num);
		} catch (SQLException ex) {
			System.out.println("setReadCountUpdate() 에러:" + ex);
		}
	}

	public BoardBean getDetail(int num) {
		BoardBean board = null;
		String sql = """
				select *
				from board
				where board_num = ?
				""";

		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, num);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					board = new BoardBean();
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
		} catch (Exception e) {
			System.out.println("getDetail() 에러:" + e);
		}

		return board;
	}

	public boolean isBoardWriter(int num, String pass) {
		String board_sql = """
					select  BOARD_PASS
					from	BOARD
					where	BOARD_NUM=?
				""";
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(board_sql);) {
			pstmt.setInt(1, num);
			
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()) {
					if(pass.equals(rs.getString("BOARD_PASS"))) 
						return true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("isBoardWriter() error : " + e);
		}

		return false;
	}
 
	public boolean boardModify(BoardBean boarddata) {
		int result = 0;
		String sql = """
				update board
				set board_subject = ?,
					board_content = ?,
					board_file = ?
				where board_num =?
				""";
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, boarddata.getBoard_subject());
			pstmt.setString(2, boarddata.getBoard_content());
			pstmt.setString(3, boarddata.getBoard_file());
			pstmt.setInt(4, boarddata.getBoard_num());
			System.out.println("boardModify() update.");
			result = pstmt.executeUpdate();
		} catch (SQLException ex) {
			System.out.println("boardModify() 에러:" + ex);
		}
		return result==1 ? true : false;
	}
	
	private void reply_update(Connection con, int board_re_ref, int board_re_seq) throws SQLException {
		/*
		 * BOARD_RE_REF, BOARD_RE_SEQ 값을 확인하여 원문 글에 답글이 달렸으면 달린 답글들의 BOARD_RE_SEQ값을 1씩
		 * 증가시킴. 현재 글을 이미 달린 답글보다 앞에 출력되게 하기 위함.
		 */

		String sql = """
				update board
				set BOARD_RE_SEQ = BOARD_RE_SEQ + 1
				where BOARD_RE_REF = ?
				and BOARD_RE_SEQ > ?
				""";

		try (PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, board_re_ref);
			pstmt.setInt(2, board_re_seq);
			pstmt.executeUpdate();
		}

	} // reply_update() 끝
	
	public int boardReply(BoardBean boardData) {
	    int num = 0;

	    try (
	            Connection conn = ds.getConnection()
	    ) {
	        conn.setAutoCommit(false);

	        try {
	            reply_update(conn, boardData.getBoard_re_ref(), boardData.getBoard_re_seq());
	            num = reply_insert(conn, boardData);

	            conn.commit();
	        } catch (SQLException e) {
	            e.printStackTrace();

	            if (conn != null) {
	                try {
	                    conn.rollback(); // rollback합니다.
	                } catch (SQLException ex) {
	                    ex.printStackTrace();
	                }
	            }
	        }
	        conn.setAutoCommit(true);
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("boardReply() 에러 : " + e);
	    }

	    return num;
	}
	
	
	public int reply_insert(Connection con, BoardBean board) throws SQLException{
		int num=0;
		String board_max_sql = """
					select max(board_num)+1 from board
				""";
		try(PreparedStatement pstmt = con.prepareStatement(board_max_sql);){
			try(ResultSet rs= pstmt.executeQuery();){
				if(rs.next())
					num = rs.getInt(1);
			}
		}
		
		String sql = """
					insert into board
						(BOARD_NUM, BOARD_NAME, BOARD_PASS, BOARD_SUBJECT,
						 BOARD_CONTENT, BOARD_FILE, BOARD_RE_REF,
						 BOARD_RE_LEV, BOARD_RE_SEQ, BOARD_READCOUNT)
				 values (?,?,?,?,
				 		 ?,?,?,
				 		 ?,?,?)
				""";
		try (PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, num);
			pstmt.setString(2, board.getBoard_name());
			pstmt.setString(3, board.getBoard_pass());
			pstmt.setString(4, board.getBoard_subject());
			pstmt.setString(5, board.getBoard_content());
			pstmt.setString(6, ""); //답변에는 file x
			pstmt.setInt(7, board.getBoard_re_ref()); // 원문 글번호
			pstmt.setInt(8, board.getBoard_re_lev()+1);
			pstmt.setInt(9, board.getBoard_re_seq()+1);
			pstmt.setInt(10, 0);
			System.out.println("reply_insert().");
			pstmt.executeUpdate(); // BOARD_READCOUNT(조회수)는 -
		}
		return num;
	}

	public boolean boardDelete(int num) {
		
		String select_sql = """
					select BOARD_RE_REF, BOARD_RE_LEV, BOARD_RE_SEQ
					from board
					where BOARD_NUM = ?
				""";
		
		String board_delete_sql = """
				delete from board
				where BOARD_RE_REF = ?
				and BOARD_RE_LEV >= ?
				and BOARD_RE_SEQ >= ?
				and BOARD_RE_SEQ <= (
									 nvl(
									 	 (SELECT min(board_re_seq)-1
									 	  FROM BOARD
									 	  WHERE BOARD_RE_REF=?
									 	  AND BOARD_RE_LEV=?
									 	  AND BOARD_RE_SEQ>?) ,
									 	  (SELECT max(board_re_seq)
									 	   FROM BOARD
									 	   WHERE BOARD_RE_REF=?)
									    )
									)
				""";
		
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(select_sql);) {//1
			pstmt.setInt(1, num);
			try(ResultSet rs = pstmt.executeQuery();) {
				if(rs.next()) {
					try(PreparedStatement pstmt2=  con.prepareStatement(board_delete_sql);){
						pstmt2.setInt(1, rs.getInt("BOARD_RE_REF"));
						pstmt2.setInt(2, rs.getInt("BOARD_RE_LEV"));
						pstmt2.setInt(3, rs.getInt("BOARD_RE_SEQ"));
						pstmt2.setInt(4, rs.getInt("BOARD_RE_REF"));
						pstmt2.setInt(5, rs.getInt("BOARD_RE_LEV"));
						pstmt2.setInt(6, rs.getInt("BOARD_RE_SEQ"));
						pstmt2.setInt(7, rs.getInt("BOARD_RE_REF"));
						
						if(pstmt2.executeUpdate() >= 1)
							return true;
					}
				}
			}
		} catch (SQLException ex) {
			System.out.println("boardDelete() 에러:" + ex);
			ex.printStackTrace();
		}
		
		return false;
	}

}
