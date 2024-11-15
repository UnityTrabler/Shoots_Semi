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

public class InquiryDAOSAVE {
	
	private DataSource ds;

	public InquiryDAOSAVE() { //DB와 연결
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
	}//inquiryInsert() 끝

	
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
							select i.*, r.user_id, r.idx
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
							ib.setIdx(rs.getInt("idx"));;
						}
					}
				}catch (Exception ex) {
						System.out.println("getDetail() 에러:" + ex);
				}
		
		return ib;
	} //getDetail()메서드

	
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
	} //inquiryModify () 끝


	
	public boolean inquiryDelete(int num) { //문의글 삭제하는 메서드
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
	} //inquiryDelete()메서드 끝

}
