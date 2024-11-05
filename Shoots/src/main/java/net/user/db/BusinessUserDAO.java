package net.user.db;

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


}
