package muskycode.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

//JDBC 기능을 구현하기 위한 DAO 클래스가 상속받기 위한 클래스
// => DataSource 인스턴스(DBCP) 생성 - WAS 프로그램에 등록된 자원 사용(JNDI)
// => DataSource 인스턴스로부터 Connection 인스턴스를 제공받아 반환하는 메소드와 JDBC 
//    관련 자원을 매개변수로 전달받아 제거하는 메소드 작성 - 중복된 코드 최소화
// => 인스턴스 생성이 목적이 아닌 상속을 목적으로 선언된 클래스이므로 추상클래스로 선언하는 것을 권장
public abstract class JdbcDAO {
	private static DataSource dataSource;
	
	static {
		try {
			//WAS 프로그램에 등록된 정보로 DataSource 인스턴스를 생성하여 필드에 저장
			// => DataSource 인스턴스에는 Connection 인스턴스가 생성되어 저장
			dataSource=(DataSource)new InitialContext().lookup("java:comp/env/jdbc/oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	//DataSource 인스턴스로부터 Connection 인스턴스를 제공받아 반환하는 메소드
	public Connection getConnection() throws SQLException {
		return dataSource.getConnection();
	}
	
	//JDBC 관련 자원을 매개변수로 전달받아 제거하는 메소드
	public void close(Connection con) {
		try {
			if(con!=null) con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void close(Connection con, PreparedStatement pstmt) {
		try {
			if(pstmt!=null) pstmt.close();
			if(con!=null) con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void close(Connection con, PreparedStatement pstmt, ResultSet rs) {
		try {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(con!=null) con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}





