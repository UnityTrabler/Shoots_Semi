package net.match.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MatchDAO {
	private DataSource ds;
	
	public MatchDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception e) {
				System.out.println("DB 연결 실패 : " + e);
		}
	}

	public int matchInsert(MatchBean match) {
		int result = 0;
		String sql = """
				insert into match_post (match_id, writer, match_date, match_time, player_min, player_max, player_gender, price, description)
				values (match_seq.nextval, ?, TO_DATE(?, 'YYYY-MM-DD'), ?, ?, ?, ?, ?, ?)
				""";
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1,match.getWriter());
			pstmt.setString(2, match.getMatch_date());
			pstmt.setString(3, match.getMatch_time());
			pstmt.setInt(4, match.getPlayer_min());
			pstmt.setInt(5, match.getPlayer_max());
			pstmt.setString(6, match.getPlayer_gender());
			pstmt.setInt(7, match.getPrice());
			pstmt.setString(8, match.getDescription());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("matchInsert() 에러 : " + e);
		}
		return result;
	}

	public int getListCount(int year, int month) {
		String sql = """
				select count(*) from match_post 
				where extract(year from match_date) = ?
				and extract(month from match_date) = ?
				""";
		int x = 0;
		
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			pstmt.setInt(1, year);
			pstmt.setInt(2, month);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					x = rs.getInt(1);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getListCount() 에러 : " + e);
		}
		return x;
	}

	public List<MatchBean> getMatchList(int page, int limit, int year, int month) {
		String sql = """
				select * from 
					(select rownum rnum, j.*
						from (select mp.*, b.business_name
			                	from match_post mp
			                	join business_user b on mp.writer = b.business_idx
								and EXTRACT(YEAR from mp.match_date) = ?
			                	and EXTRACT(MONTH from mp.match_date) = ?
								order by mp.match_date desc, mp.match_time desc) j 
					where rownum <= ?)
				where rnum >= ? and rnum <= ?
	            """;
		List<MatchBean> list = new ArrayList();
		
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			 	pstmt.setInt(1, year);
	            pstmt.setInt(2, month);
	            pstmt.setInt(3, endrow);
				pstmt.setInt(4, startrow);
				pstmt.setInt(5, endrow);
				
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					MatchBean match = new MatchBean();
					match.setMatch_id(rs.getInt("match_id"));
					match.setMatch_date(rs.getString("match_date"));
					match.setMatch_time(rs.getString("match_time"));
					match.setBusiness_name(rs.getString("business_name"));
					match.setPlayer_max(rs.getInt("player_max"));
					match.setPlayer_min(rs.getInt("player_min"));
					match.setPlayer_gender(rs.getString("player_gender"));
					
					list.add(match);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getMatchList() 에러 : " + e);
		}
		return list;
	}

	public MatchBean getDetail(int matchId) {
		String sql = """
				select mp.*, b.business_name, b.address, b.description from match_post mp join business_user b
				on mp.writer = b.business_idx where match_id = ?
				""";
		MatchBean match = null;
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, matchId);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					match = new MatchBean();
					match.setMatch_id(rs.getInt("match_id"));
					match.setWriter(rs.getInt("writer"));
					match.setMatch_date(rs.getString("match_date"));
					match.setMatch_time(rs.getString("match_time"));
					match.setPlayer_max(rs.getInt("player_max"));
					match.setPlayer_min(rs.getInt("player_min"));
					match.setPlayer_gender(rs.getString("player_gender"));
					match.setPrice(rs.getInt("price"));
					match.setBusiness_name(rs.getString("business_name"));
					match.setAddress(rs.getString("address"));
					match.setDescription(rs.getString("description"));	
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getDetail() 에러 : " + e);
		}
		return match;
	}

	public int matchUpdate(MatchBean match) {
		int result = 0;
		String sql = """
				update match_post set match_date = ?, match_time = ?, player_min = ?, 
					player_max = ?, player_gender = ?, price = ?, description = ?
				where match_id = ?
				""";
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			pstmt.setString(1, match.getMatch_date());
			pstmt.setString(2, match.getMatch_time());
			pstmt.setInt(3, match.getPlayer_min());
			pstmt.setInt(4, match.getPlayer_max());
			pstmt.setString(5, match.getPlayer_gender());
			pstmt.setInt(6, match.getPrice());
			pstmt.setString(7, match.getDescription());
			pstmt.setInt(8, match.getMatch_id());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("matchUpdate() 에러 : " + e);
		}
		return result;
	}

	public int matchDelete(int matchId) {
		int result = 0;
		String sql = """
				delete from match_post where match_id = ?
				""";
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, matchId);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("matchDelete() 에러 : " + e);
		}
		return result;
	}
	
	public int getListCount(int business_idx, int year, int month) {
		String sql = """
				select count(*) from match_post where writer = ?
				and extract(year from match_date) = ?
				and extract(month from match_date) = ?
				""";
		int x = 0;
		
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			pstmt.setInt(1, business_idx);
            pstmt.setInt(2, year);
            pstmt.setInt(3, month);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					x = rs.getInt(1);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getListCount() 에러 : " + e);
		}
		return x;
	}

	public List<MatchBean> getMatchListById(int page, int limit, int business_idx, int year, int month) {
		String sql = """
				select * from 
					(select rownum rnum, j.*
						from (SELECT mp.*, b.business_name
			                	FROM match_post mp
			                	JOIN business_user b ON mp.writer = b.business_idx
			                	WHERE mp.writer = ?
								AND EXTRACT(YEAR FROM mp.match_date) = ?
			                	AND EXTRACT(MONTH FROM mp.match_date) = ?
								ORDER BY mp.match_date DESC) j 
					where rownum <= ?)
				where rnum >= ? and rnum <= ?
	            """;
		List<MatchBean> list = new ArrayList<MatchBean>();
		
		int startRow = (page - 1) * limit + 1;
        int endRow = startRow + limit - 1;
        
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			
			pstmt.setInt(1, business_idx);
            pstmt.setInt(2, year);
            pstmt.setInt(3, month);
            pstmt.setInt(4, endRow);
            pstmt.setInt(5, startRow);
            pstmt.setInt(6, endRow);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				while(rs.next()) {
					MatchBean match = new MatchBean();
					match.setMatch_id(rs.getInt("match_id"));
					match.setMatch_date(rs.getString("match_date"));
					match.setMatch_time(rs.getString("match_time"));
					match.setBusiness_name(rs.getString("business_name"));
					match.setPlayer_max(rs.getInt("player_max"));
					match.setPlayer_min(rs.getInt("player_min"));
					match.setPlayer_gender(rs.getString("player_gender"));
					
					list.add(match);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getMatchListById() 에러 : " + e);
		}
		return list;
	}
	
	public List<MatchBean> getMatchListById(int business_idx, int year, int month) {
		String sql = """
				SELECT * FROM match_post 
				WHERE writer = ?
				AND EXTRACT(YEAR FROM match_date) = ?
			    AND EXTRACT(MONTH FROM match_date) = ?
			    ORDER BY match_date DESC
	            """;
		List<MatchBean> list = new ArrayList<MatchBean>();
        
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			System.out.println(business_idx+ " " + year + " " + month );
			pstmt.setInt(1, business_idx);
            pstmt.setInt(2, year);
            pstmt.setInt(3, month);

			try (ResultSet rs = pstmt.executeQuery()) {
				while(rs.next()) {
					MatchBean match = new MatchBean();
					match.setMatch_id(rs.getInt("match_id"));
					match.setMatch_date(rs.getString("match_date"));
					match.setMatch_time(rs.getString("match_time"));
					match.setPlayer_max(rs.getInt("player_max"));
					match.setPlayer_min(rs.getInt("player_min"));
					match.setPrice(rs.getInt("price"));

					list.add(match);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getMatchListById() 에러 : " + e);
		}
		return list;
	}

	public List<MatchBean> getAfterMatchList() {
		String sql = """
				select mp.*, COALESCE(p.playerCount, 0) AS playerCount 
				from match_post mp
				left join (SELECT match_id, COUNT(*) AS playerCount
						     FROM payment 
						     WHERE status = 'SUCCESS'
						     GROUP BY match_id) p 
				on mp.match_id = p.match_id
				where match_date = TO_CHAR(SYSDATE, 'YYYY-MM-DD')
				order by match_time ASC
				""";
		List<MatchBean> list = new ArrayList<>();
		
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					MatchBean match = new MatchBean();
					
					match.setMatch_id(rs.getInt("match_id"));
					match.setWriter(rs.getInt("writer"));
					match.setMatch_date(rs.getString("match_date"));
					match.setMatch_time(rs.getString("match_time"));
					match.setPlayer_max(rs.getInt("player_max"));
					match.setPlayer_min(rs.getInt("player_min"));
					match.setPlayer_gender(rs.getString("player_gender"));
					match.setPrice(rs.getInt("price"));
					match.setPlayerCount(rs.getInt("playerCount"));
					
					list.add(match);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getAfterMatchList() 에러 : " + e);
		}
		return list;
	}

	public List<MatchBean> getMatchsByPlayerId(int idx) {
		String sql = """
				select mp.*, COALESCE(p.playerCount, 0) AS playerCount, b.business_name
				from match_post mp
				inner join (SELECT match_id, COUNT(*) AS playerCount
						     FROM payment 
						     WHERE status = 'SUCCESS' and buyer = ?
						     GROUP BY match_id) p 
				on mp.match_id = p.match_id
				inner join business_user b
				on mp.writer = b.business_idx
				order by match_date desc
				""";
		List<MatchBean> list = new ArrayList();
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, idx);
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					MatchBean match = new MatchBean();
					match.setMatch_id(rs.getInt("match_id"));
					match.setBusiness_name(rs.getString("business_name"));
					match.setMatch_date(rs.getString("match_date"));
					match.setMatch_time(rs.getString("match_time"));
					match.setPlayer_max(rs.getInt("player_max"));
					match.setPlayer_min(rs.getInt("player_min"));
					match.setPlayer_gender(rs.getString("player_gender"));
					match.setPrice(rs.getInt("price"));	
					
					list.add(match);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getMatchsByPlayerId() 에러 : " + e);
		}
		return list;
	}

	public MatchBean getMatchById(int match_id) {
		String sql = """
				select * from match_post where match_id = ?
				""";
		MatchBean match = null;
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, match_id);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					match = new MatchBean();
					match.setMatch_id(rs.getInt("match_id"));
					match.setMatch_date(rs.getString("match_date"));
					match.setMatch_time(rs.getString("match_time"));
					match.setPlayer_max(rs.getInt("player_max"));
					match.setPlayer_min(rs.getInt("player_min"));
					match.setPlayer_gender(rs.getString("player_gender"));
					match.setPrice(rs.getInt("price"));
				}
			} 
		} catch (Exception  e) {
			e.printStackTrace();
			System.out.println("getMatchListById() 에러 :  " + e);
		}
		return match;
	}
}
