package net.user.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import net.notice.db.NoticeBean;

public class UserDAO {

	private DataSource ds;

	public UserDAO() {
		try {
			Context init = new InitialContext();
			this.ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception e) {
			System.out.println("DB 연결 실패 : " + e);
		}
	}
	
	//login 할 때 입력한 id,pwd 검증
	public int isId(String id, String pwd) { //=getMemberById()
		String sql = """
				select user_id, password
				from regular_user
				where user_id = ?
				""";
		int result = 0;
		
		try(Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
				pstmt.setString(1, id);
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()) 
					result = pwd.equals(rs.getString("password")) ? 1 : 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public int isIdBusiness(String id, String pwd) { //=getMemberById()
		String sql = """
				select  business_id, password
				from business_user
				where business_id = ?
				""";
		int result = 0;
		
		try(Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, id);
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()) 
					result = pwd.equals(rs.getString("password")) ? 1 : 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}

	public int insertUser(UserBean userBean) {
		if(getUserIdx(userBean.getId()) > 0) {
			System.out.println("duplicated regular user ID");
			return 0;
		}
		//nickname, user_file 빠짐
		String sql = """
				INSERT INTO regular_user
				(idx, user_id, password, name, jumin, gender, tel, email)
				VALUES (user_seq.nextval,?,?,?, ?,?,?, ?)
				""";
		int result = 0;
		
		try(Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
				pstmt.setString(1, userBean.getId());
				pstmt.setString(2, userBean.getPassword());
				pstmt.setString(3, userBean.getName());
				pstmt.setInt(4, userBean.getRRN());
				pstmt.setInt(5, userBean.getGender());
				pstmt.setString(6, userBean.getTel());
				pstmt.setString(7, userBean.getEmail());
				result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}

	public int update(UserBean userBean) {
		String sql = """
				update regular_user
				set user_file = ?
				where user_id = ?
				""";
		int result = 0;
		
		try(Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, userBean.getUserfile());
			pstmt.setString(2, userBean.getId());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}

	public UserBean getUser(String id) {
		String sql = """
				select *
				from regular_user
				where user_id = ?
				""";
		UserBean userBean = new UserBean();
		
		try(Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
				pstmt.setString(1, id);
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()) {
					userBean.setIdx(rs.getString("idx"));
					userBean.setId(id);
					userBean.setPassword(rs.getString("password"));
					userBean.setIdx(rs.getString("name"));
					userBean.setRRN(Integer.parseInt(rs.getString("jumin")));
					userBean.setGender(Integer.parseInt(rs.getString("gender")));
					userBean.setTel(rs.getString("tel"));
					userBean.setEmail(rs.getString("email"));
					userBean.setNickname(rs.getString("nickname"));
					userBean.setUserfile(rs.getString("user_file"));
					userBean.setRegister_date(rs.getString("register_date"));
					userBean.setRole(rs.getString("role"));
				}
				else {System.err.println("ID not found in the database.");return null;}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return userBean;
	}
	
	public int getUserIdx(String id) {
		String sql = """
				select idx
				from regular_user
				where user_id = ?
				""";
		int result = 0;
		
		try(Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, id);
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()) 
					result = rs.getInt(1);
				else 
					System.err.println("ID not found in the database.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public int getBusinessUserIdx(String id) {
		String sql = """
				select business_idx
				from business_user
				where business_id = ?
				""";
		int result = 0;
		
		try(Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, id);
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()) 
					result = rs.getInt(1);
				else 
					System.err.println("ID not found in the database.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}

	public int insertUser(BusinessUserBean userBean) {
		if(getBusinessUserIdx(userBean.getBusiness_id()) > 0) {
			System.out.println("duplicated business ID");
			return 0;
		}
		
		String sql = """
				INSERT INTO business_user
				(business_idx, business_id, password, 
				business_name, business_number, tel,
				email, post, address,
				description, business_file)
				VALUES (business_seq.nextval,?,?, ?,?,?, ?,?,?, ?,?)
				""";
		int result = 0;
		
		try(Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
				pstmt.setString(1, userBean.getBusiness_id());
				pstmt.setString(2, userBean.getPassword());
				pstmt.setString(3, userBean.getBusiness_name());
				pstmt.setInt(4, userBean.getBusiness_number());
				pstmt.setInt(5, userBean.getTel());
				pstmt.setString(6, userBean.getEmail());
				pstmt.setInt(7, userBean.getPost());
				pstmt.setString(8, userBean.getAddress());
				pstmt.setString(9, userBean.getDescription());
				pstmt.setString(10, userBean.getBusiness_file());
				result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
  
	public List<UserBean> getCustomersById(int idx) {
		String sql = """
				select * from (
				    select u.idx, u.user_id, u.name, u.email, u.tel, u.gender, u.user_file, u.jumin, count(p.seller) AS payment_count
				    from regular_user u
				    inner join payment p 
				        on u.idx = p.buyer
				    where p.seller = ? 
				      and p.status != 'REFUNDED'
				    group by u.idx, u.user_id, u.name, u.email, u.tel, u.gender, u.user_file, u.jumin, p.seller
				    order by payment_count desc
				) 
				where rownum <= 10
				""";
		List<UserBean> list = new ArrayList();
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, idx);
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					UserBean user = new UserBean();
					user.setIdx(rs.getString("idx"));
					user.setId(rs.getString("user_id"));
					user.setName(rs.getString("name"));
					user.setEmail(rs.getString("email"));
					user.setTel(rs.getString("tel"));
					user.setGender(rs.getInt("gender"));
					user.setUserfile(rs.getString("user_file"));
					user.setRRN(rs.getInt("jumin"));
					
					if (user.getTel() != null && user.getTel().length() == 11) {
	                    String formattedTel = user.getTel().substring(0, 3) + "-" + user.getTel().substring(3, 7) + "-" + user.getTel().substring(7);
	                    user.setTel(formattedTel);
	                }
					
					list.add(user);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getCustomersById() 에러 : " + e);
		}
		return list;
	}

	public List<UserBean> getAllCustomersById(int idx) {
		String sql = """
				select * from (
				    select u.idx, u.user_id, u.name, u.email, u.tel, u.gender, u.user_file, u.jumin, count(p.seller) AS payment_count
				    from regular_user u
				    inner join payment p 
				        on u.idx = p.buyer
				    where p.seller = ? 
				      and p.status != 'REFUNDED'
				    group by u.idx, u.user_id, u.name, u.email, u.tel, u.gender, u.user_file, u.jumin, p.seller
				    order by payment_count desc
				) 
				""";
		List<UserBean> list = new ArrayList();
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, idx);
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					UserBean user = new UserBean();
					user.setIdx(rs.getString("idx"));
					user.setId(rs.getString("user_id"));
					user.setName(rs.getString("name"));
					user.setEmail(rs.getString("email"));
					user.setTel(rs.getString("tel"));
					user.setGender(rs.getInt("gender"));
					user.setUserfile(rs.getString("user_file"));
					user.setRRN(rs.getInt("jumin"));
					
					if (user.getTel() != null && user.getTel().length() == 11) {
	                    String formattedTel = user.getTel().substring(0, 3) + "-" + user.getTel().substring(3, 7) + "-" + user.getTel().substring(7);
	                    user.setTel(formattedTel);
	                }
					
					list.add(user);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getCustomersById() 에러 : " + e);
		}
		return list;
	}

	public UserBean getUserInfoById(int idx) {
		String sql = """
				select * 
				from regular_user
				where idx = ?
				""";
		UserBean user = null;
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			pstmt.setInt(1, idx);
			
			try (ResultSet rs = pstmt.executeQuery();) {
				if (rs.next()) {
					user = new UserBean();
					user.setName(rs.getString("name"));
					user.setId(rs.getString("user_id"));
					user.setRRN(rs.getInt("jumin"));
					user.setEmail(rs.getString("email"));
					user.setTel(rs.getString("tel"));
					user.setGender(rs.getInt("gender"));
					user.setUserfile(rs.getString("user_file"));
					
					if (user.getTel() != null && user.getTel().length() == 11) {
	                    String formattedTel = user.getTel().substring(0, 3) + "-" + user.getTel().substring(3, 7) + "-" + user.getTel().substring(7);
	                    user.setTel(formattedTel);
	                }
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getUserInfoById() 에러 : " + e );
		}
		return user;
	}

	//사용자 총 수를 알아낸다
	public int getUserListCount() {
		String sql = """
				select count(*) from regular_user
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
			System.out.println("getUserListCount() 에러: " + ex);
		}
		
		return x;
	}//getUserListCount() end

	//사용자 리스트를 알아낸다
	public List<UserBean> getUserList(int page, int limit) {
		List<UserBean> list = new ArrayList<UserBean>();
		String sql = """
				select * from (
					select rownum rnum, idx, user_id, name ,jumin, gender, tel, email, register_date, role
					from regular_user
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
						UserBean ub = new UserBean();
						ub.setIdx(rs.getString("idx"));
						ub.setId(rs.getString("user_id"));
						ub.setName(rs.getString("name"));
						ub.setRRN(rs.getInt("jumin"));
						ub.setGender(rs.getInt("gender"));
						ub.setTel(rs.getString("tel"));
						ub.setEmail(rs.getString("email"));
						ub.setRegister_date(rs.getString("register_date"));
						ub.setRole(rs.getString("role"));
						
						list.add(ub);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("getUserList() 에러 : " + e);
			}
			
			return list;
	}//getUserList() end

	public int grantAdmin(String id) {
		int result = 0;
		String sql = """
				update regular_user 
				set role = 'admin' 
				where user_id = ?
				""";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
				pstmt.setString(1, id);
				result = pstmt.executeUpdate();
			}catch(SQLException ex) {
				System.out.println("grantAdmin() 에러: " + ex);
			}
		
		return result;
	}

	public int revokeAdmin(String id) {
		int result = 0;
		String sql = """
				update regular_user 
				set role = 'common' 
				where user_id = ?
				""";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
				pstmt.setString(1, id);
				result = pstmt.executeUpdate();
			}catch(SQLException ex) {
				System.out.println("revokeAdmin() 에러: " + ex);
			}
		
		return result;
	}
}
