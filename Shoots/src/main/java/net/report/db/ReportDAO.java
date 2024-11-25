package net.report.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import net.faq.db.FaqBean;
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

	
	//신고 갯수 구하기
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
	}//getReportListCount() end
	
	
	
	//신고 리스트
	public List<ReportBean> getReportList(int page, int limit) {
		List<ReportBean> list = new ArrayList<ReportBean>();
		String sql = """
				select * from (
					select rownum rnum, r.report_id, r.report_type, r.report_ref_id, ru.name reporter, tu.name target, title, register_date
					from(
							select r.*, ru.name, rt.name
							from report r
							left join regular_user ru on r.reporter = ru.idx
							left join regular_user tu on r.target = tu.idx
							order by report_id desc
							)
					) p where p.rnum >= ? and p.rnum <= ?
				""";
		
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			
			try (ResultSet rs = pstmt.executeQuery()){
				while(rs.next()) {
					ReportBean rb = new ReportBean();
					rb.setReport_id(rs.getInt("report_id"));
					rb.setReport_type(rs.getString("report_type"));
					rb.setReport_ref_id(rs.getInt("report_ref_id"));
					rb.setReporter_name(rs.getString("reporter"));
					rb.setTarget_name(rs.getString("target"));
					rb.setTitle(rs.getString("title"));
					rb.setRegister_date(rs.getString("register_date"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getReportList() 에러 : " + e);
		}
		
		return list;
	}//getReportList() end
	

	//신고 내역 구하기
	public ReportBean getDetail(int id) {
		ReportBean rb = null;
		String sql = """
				select r.*, ru.name reporter, rt.name target
					from report r
					left join regular_user ru on r.reporter = ru.idx
					left join regular_user tu on r.target = tu.idx 
				where r.report_id = ?
				""";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
				pstmt.setInt(1, id);
				try(ResultSet rs = pstmt.executeQuery()){
					if(rs.next()) {
						rb = new ReportBean();
						rb.setPost_id(rs.getInt("report_id"));
						rb.setReport_type(rs.getString("report_type"));
						rb.setReporter_name(rs.getString("reporter"));
						rb.setTarget_name(rs.getString("target"));
						rb.setTitle(rs.getString("title"));
						rb.setContent(rs.getString("content"));
						rb.setReport_file(rs.getString("report_file"));
					}
				}
				
			}catch(Exception ex) {
				System.out.println("getDetail() 에러: " + ex);
			}
			return rb;
	}//getDetail() end
		
}
