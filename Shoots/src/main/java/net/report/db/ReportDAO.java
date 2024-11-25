package net.report.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import net.notice.db.NoticeBean;

import java.util.*;

public class ReportDAO {
	
	private DataSource ds;

	public ReportDAO() { //DB와 연결
		try {
			Context init = new InitialContext();
			this.ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
		}
	}

	public boolean reportInsert(ReportBean rb) { //신고 내용을 report DB에 저장
		int result = 0;
		
			String sql = """
					insert into report
					(report_id, report_type, report_ref_id, reporter,
					target, title, content, register_date)
					 values(report_seq.nextval, ?, ?, ?,
					 		 ?, ?, ?, current_timestamp)
				""";
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, rb.getReport_type());
			pstmt.setInt(2, rb.getReport_ref_id());
			pstmt.setInt(3, rb.getReporter());
			pstmt.setInt(4, rb.getTarget());
			pstmt.setString(5, rb.getTitle());
			pstmt.setString(6, rb.getContent());
			result = pstmt.executeUpdate();
			if(result ==1) {
				System.out.println("데이터가 다 삽입 됐습니다.");
				return true;
			}
			
			
		} catch (Exception e) {
			System.out.println("reportInsert() 에러: " + e);
			e.printStackTrace();
		}
		
		return false;
	}//reportInsert() 끝

	public int getReportListCount() {
		String sql = """
				select count(*) from report
				""";
		int x = 0;
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					x = rs.getInt(1);
				}
			}
				}catch(Exception ex) {
					ex.printStackTrace();
					System.out.println("getReportListCount() 에러: " + ex);
				}
				return x;
	}

	public List<ReportBean> getReportList(int page, int limit) {
		List<ReportBean> list = new ArrayList<ReportBean>();
		String sql = """
				select * from (
					select rownum rnum, report_id, report_type, report_ref_id, reporter, target, title, register_date
					from report 
				) p where p.rnum >= ? and p.rnum <= ?
				""";
		
		
		return null;
	}
		


}
