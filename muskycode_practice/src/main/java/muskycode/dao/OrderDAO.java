package muskycode.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import muskycode.dto.OrderDTO;

public class OrderDAO extends JdbcDAO {

	private static OrderDAO _dao;

	private OrderDAO() {

	}

	static {

		_dao = new OrderDAO();

	}

	public static OrderDAO getDAO() {

		return _dao;
	}

	// 주문 그룹 시퀀스 얻어오는 메소드
	public int getOrderGroupNo() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int number = 0;

		try {
			con = getConnection();

			String sql = "SELECT SEQ_OGROUP.NEXTVAL FROM DUAL";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				number = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]getOrderGroupNo() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return number;
	}

	// 주문 추가
	public int insertOrder(OrderDTO order,int ostatus) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();

			if(ostatus == 2) {
			String sql = "INSERT INTO" + "\"ORDER\"" + "VALUES(SEQ_ONO.nextval,?,?,?,?,SYSDATE,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, order.getPNO());
			pstmt.setString(2, order.getMID());
			pstmt.setString(3, order.getONAME());
			pstmt.setString(4, order.getOPHONE());
			pstmt.setInt(5, order.getOQUANTITY());
			pstmt.setString(6, order.getOPAYMENT());
			pstmt.setString(7, order.getOADDRESS1());
			pstmt.setString(8, order.getOADDRESS2());
			pstmt.setString(9, order.getOZIP());
			pstmt.setInt(10, ostatus);
			pstmt.setInt(11, order.getOGROUP());
			}
			
			else {
				String sql = "INSERT INTO" + "\"ORDER\"" + "VALUES(SEQ_ONO.nextval,?,?,?,?,SYSDATE,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);

				pstmt.setInt(1, order.getPNO());
				pstmt.setString(2, order.getMID());
				pstmt.setString(3, order.getONAME());
				pstmt.setString(4, order.getOPHONE());
				pstmt.setInt(5, order.getOQUANTITY());
				pstmt.setString(6, order.getOPAYMENT());
				pstmt.setString(7, order.getOADDRESS1());
				pstmt.setString(8, order.getOADDRESS2());
				pstmt.setString(9, order.getOZIP());
				pstmt.setInt(10, ostatus);
				pstmt.setInt(11, order.getOGROUP());
			}
			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러]insertOrder() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 주문 수정_관리자용
	public int updateOrderAdmin(OrderDTO order) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();

			String sql = "UPDATE" + "\"ORDER\""
					+ "SET OPHONE=?,OADDRESS1=?,OADDRESS2=?,OZIP=?, OSTATUS=? WHERE OGROUP=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, order.getOPHONE());
			pstmt.setString(2, order.getOADDRESS1());
			pstmt.setString(3, order.getOADDRESS2());
			pstmt.setString(4, order.getOZIP());
			pstmt.setInt(5, order.getOSTATUS());
			pstmt.setInt(6, order.getOGROUP());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateOrderAdmin() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	// 주문 조회

	public OrderDTO selectAllOrder(int ONO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		OrderDTO order = null;

		try {

			con = getConnection();

			String sql = "SELECT * FROM" + "\"ORDER\"" + " WHERE ONO=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ONO);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				order = new OrderDTO();
				order.setONO(rs.getInt("ONO"));
				order.setONAME(rs.getString("ONAME"));
				order.setOPHONE(rs.getString("OPHONE"));
				order.setODATE(rs.getString("ODATE"));
				order.setOQUANTITY(rs.getInt("OQUANTITY"));
				order.setOPAYMENT(rs.getString("OPAYMENT"));
				order.setOADDRESS1(rs.getString("OADDRESS1"));
				order.setOADDRESS2(rs.getString("OADDRESS2"));
				order.setOZIP(rs.getString("OZIP"));
				order.setOSTATUS(rs.getInt("OSTATUS"));
				order.setOGROUP(rs.getInt("OGROUP"));

			}
		} catch (SQLException e) {
			System.out.println("[에러]selectAllOrder() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return order;

	}

	// 전체 주문 건수 반환 제목과 카테고리 매개변수로
	public int selectOrderCount(String search, String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();
			if (keyword.equals("")) {
				String sql = "SELECT COUNT(*) FROM " + "\"ORDER\"";
				pstmt = con.prepareStatement(sql);
			} else {
				String sql = "SELECT COUNT(*) FROM " + "\"ORDER\"" + " WHERE " + search + " LIKE '%'||?||'%'";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectOrderCount 부분 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}

	// 조건에 맞는 주문정보 검색 order_manage에서 사용
	public List<OrderDTO> selectOrderList(int startRow, int endRow, String search, String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<OrderDTO> orderList = new ArrayList<OrderDTO>();
		try {
			con = getConnection();

			if (keyword.equals("")) {
				String sql = "SELECT * FROM (SELECT ROWNUM RN, TEMP.* FROM " + "(SELECT * FROM " + "\"ORDER\""
						+ " ORDER BY ONO DESC) TEMP) WHERE RN BETWEEN ? AND ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {

				String sql = "SELECT * FROM (SELECT ROWNUM RN, TEMP.* FROM " + "(SELECT * FROM " + "\"ORDER\""
						+ " WHERE " + search + " LIKE '%'||?||'%'"
						+ "ORDER BY ONO DESC ) TEMP ) WHERE RN BETWEEN ? AND ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				OrderDTO order = new OrderDTO();
				order.setONO(rs.getInt("ONO"));
				order.setMID(rs.getString("MID"));
				order.setPNO(rs.getInt("PNO"));
				order.setODATE(rs.getString("ODATE"));
				order.setOSTATUS(rs.getInt("OSTATUS"));
				order.setOGROUP(rs.getInt("OGROUP"));
				order.setOPAYMENT(rs.getString("OPAYMENT"));
				orderList.add(order);
			}

		} catch (SQLException e) {
			System.out.println("[에러] selectOrderList 부분에서 오류 발생 " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return orderList;
	}

	// 그룹 번호를 매개로 전달 받아 해당 그룹 번호인 dto 배열 반환하는 메소드
	public List<OrderDTO> selectGroupList(int groupNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<OrderDTO> orderList = new ArrayList<OrderDTO>();

		try {
			con = getConnection();

			String sql = "SELECT * FROM " + "\"ORDER\"" + "WHERE OGROUP = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, groupNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				OrderDTO order = new OrderDTO();
				order.setONO(rs.getInt("ONO"));
				order.setMID(rs.getString("MID"));
				order.setPNO(rs.getInt("PNO"));
				order.setODATE(rs.getString("ODATE"));
				order.setOSTATUS(rs.getInt("OSTATUS"));
				order.setOZIP(rs.getString("OZIP"));
				order.setOADDRESS1(rs.getString("OADDRESS1"));
				order.setOADDRESS2(rs.getString("OADDRESS2"));
				order.setOGROUP(rs.getInt("OGROUP"));
				order.setOPAYMENT(rs.getString("OPAYMENT"));
				order.setONAME(rs.getString("ONAME"));
				order.setOQUANTITY(rs.getInt("OQUANTITY"));
				order.setOPHONE(rs.getString("OPHONE"));
				orderList.add(order);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectGroupList 부분에서 오류 발생 " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return orderList;
	}

	// 주문 횟수가 많은 상위 5개 제품의 정보를 반환하는 메소드
	public List<OrderDTO> productOrderCount(int pno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<OrderDTO> orderList = new ArrayList<OrderDTO>();

		try {
			con = getConnection();
			String sql = "SELECT * FROM (SELECT COUNT(*) FROM"+"\"ORDER\""+"WHERE PNO=?) ORD WHERE ROWNUM <= 5";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				OrderDTO order = new OrderDTO();
				order.setONO(rs.getInt("ONO"));
				order.setMID(rs.getString("MID"));
				order.setPNO(rs.getInt("PNO"));
				order.setODATE(rs.getString("ODATE"));
				order.setOSTATUS(rs.getInt("OSTATUS"));
				order.setOZIP(rs.getString("OZIP"));
				order.setOADDRESS1(rs.getString("OADDRESS1"));
				order.setOADDRESS2(rs.getString("OADDRESS2"));
				order.setOGROUP(rs.getInt("OGROUP"));
				order.setOPAYMENT(rs.getString("OPAYMENT"));
				order.setONAME(rs.getString("ONAME"));
				order.setOQUANTITY(rs.getInt("OQUANTITY"));
				order.setOPHONE(rs.getString("OPHONE"));
				orderList.add(order);
			}
		} catch (SQLException e) {
			System.out.println("[에러] produdctOrderCount 부분 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return orderList;
	}

	// 아이디로 주문 횟수 받아오기 (status를 왜 넣었을까? 기억이 안난다)
	public int selectIdOrderCount(String id, int status) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {

			if (status == 0) {
				con = getConnection();
				String sql = "SELECT Count(*) FROM" + "\"ORDER\"" + "WHERE MID = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
			} else {
				con = getConnection();
				String sql = "SELECT Count(*) FROM" + "\"ORDER\"" + "WHERE MID = ? AND OSTATUS = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setInt(2, status);
				rs = pstmt.executeQuery();
			}
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectIdOrderCount 부분 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}

	// 회원 개인 주문 조회 리스트
	public List<OrderDTO> selectOrderIdList(int startRow, int endRow, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<OrderDTO> orderList = new ArrayList<OrderDTO>();

		try {
			con = getConnection();
			String sql = "SELECT * FROM (SELECT ROWNUM RN, TEMP.* FROM (SELECT * FROM " + "\"ORDER\""
					+ " WHERE  MID = ? ORDER BY ONO DESC ) TEMP ) WHERE RN BETWEEN ? AND ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				OrderDTO order = new OrderDTO();
				order.setONO(rs.getInt("ONO"));
				order.setMID(rs.getString("MID"));
				order.setPNO(rs.getInt("PNO"));
				order.setODATE(rs.getString("ODATE"));
				order.setOSTATUS(rs.getInt("OSTATUS"));
				order.setOZIP(rs.getString("OZIP"));
				order.setOADDRESS1(rs.getString("OADDRESS1"));
				order.setOADDRESS2(rs.getString("OADDRESS2"));
				order.setOGROUP(rs.getInt("OGROUP"));
				order.setOPAYMENT(rs.getString("OPAYMENT"));
				order.setONAME(rs.getString("ONAME"));
				order.setOQUANTITY(rs.getInt("OQUANTITY"));
				order.setOPHONE(rs.getString("OPHONE"));
				orderList.add(order);
			}

		} catch (SQLException e) {
			System.out.println("[에러] selectOrderIdList 부분 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return orderList;
	}
	
	// 주문 번호로 해당 주문 상품 번호 배열 출력하는 메소드
	public List<Integer> selectGroupNoPnoList(int groupNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Integer> pnoList = new ArrayList<Integer>();

		try {
			con=getConnection();
			
			String sql = "SELECT PNO FROM"+"\"ORDER\"" + "WHERE OGROUP = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, groupNo);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				pnoList.add(rs.getInt(1));
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectGroupNoPnoList 부분 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return pnoList;
	}
	
	// 상품 번호와 주문 그룹 번호로 주문 객체 얻어오는 메소드
	public OrderDTO selectOrderPno(int pno, int groupNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		OrderDTO order = null;
		
		try {
			con=getConnection();
			
			String sql = "SELECT * FROM "+"\"ORDER\"" + "WHERE PNO = ? AND OGROUP = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, pno);
			pstmt.setInt(2, groupNo);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				order=new OrderDTO();
				order.setONO(rs.getInt("ONO"));
				order.setMID(rs.getString("MID"));
				order.setPNO(rs.getInt("PNO"));
				order.setODATE(rs.getString("ODATE"));
				order.setOSTATUS(rs.getInt("OSTATUS"));
				order.setOZIP(rs.getString("OZIP"));
				order.setOADDRESS1(rs.getString("OADDRESS1"));
				order.setOADDRESS2(rs.getString("OADDRESS2"));
				order.setOGROUP(rs.getInt("OGROUP"));
				order.setOPAYMENT(rs.getString("OPAYMENT"));
				order.setONAME(rs.getString("ONAME"));
				order.setOQUANTITY(rs.getInt("OQUANTITY"));
				order.setOPHONE(rs.getString("OPHONE"));
			}
		}catch (SQLException e) {
			System.out.println("[에러] selectOrderPno 부분 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return order;
	}
}
