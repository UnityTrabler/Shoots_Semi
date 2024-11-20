package net.user.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BusinessUserDAO {

	private DataSource ds;

	public BusinessUserDAO() {
		try {
			Context init = new InitialContext();
			this.ds = (DataSource)init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception e) {
			System.out.println("DB 연결 실패 : " + e);
		}
	}

	public BusinessUserBean getUserInfoById(int business_idx) {
		String sql = """
				select * 
				from business_user
				where business_idx = ?
				""";
		BusinessUserBean businessUser = null;
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			pstmt.setInt(1, business_idx);
			
			try (ResultSet rs = pstmt.executeQuery();) {
				if (rs.next()) {
					businessUser = new BusinessUserBean();
					businessUser.setBusiness_idx(rs.getInt("business_idx"));
					businessUser.setBusiness_id(rs.getString("business_id"));
					businessUser.setPassword(rs.getString("password"));
					businessUser.setBusiness_name(rs.getString("business_name"));
					businessUser.setBusiness_number(rs.getInt("business_number"));
					businessUser.setTel(rs.getInt("tel"));
					businessUser.setEmail(rs.getString("email"));
					businessUser.setPost(rs.getInt("post"));
					businessUser.setAddress(rs.getString("address"));
					businessUser.setDescription(rs.getString("description"));
					businessUser.setBusiness_file(rs.getString("business_file"));
					businessUser.setRegister_date(rs.getString("register_date"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getUserInfoById() 에러 : " + e );
		}
		return businessUser;
	}

	//총 기업 수를 알아낸다
	public int getBusinessListCount() {
		String sql = """
				select count(*) from business_user
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
				System.out.println("getBusinessListCount() 에러: " + ex);
			}
			
			return x;
	}//getBusinessListCount() end

	public List<BusinessUserBean> getBusinessList(int page, int limit) {
		List<BusinessUserBean> list = new ArrayList<BusinessUserBean>();
		String sql = """
				select * from (
					select rownum rnum, business_idx, business_id, business_name ,business_number, email, post, address, register_date
					from business_user
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
						BusinessUserBean bb = new BusinessUserBean();
						bb.setBusiness_idx(rs.getInt("business_idx"));
						bb.setBusiness_id(rs.getString("business_id"));
						bb.setBusiness_name(rs.getString("business_name"));
						bb.setBusiness_number(rs.getInt("business_number"));
						bb.setEmail(rs.getString("email"));
						bb.setPost(rs.getInt("post"));
						bb.setAddress(rs.getString("address"));
						bb.setRegister_date(rs.getString("register_date"));
						
						list.add(bb);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("getBusinessList() 에러 : " + e);
			}
			
			return list;
	}
}