package muskycode.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import muskycode.dto.CartDTO;


public class CartDAO extends JdbcDAO{
	private static CartDAO _dao;
	
	private CartDAO() {
		
	}
	
	static {
		_dao = new CartDAO();
	}
	
	public static CartDAO getDAO() {
		return _dao;
	}
	
	// 1. 아이디 매개 변수로 받아 장바구니 전체 조회 메소드
	public List<CartDTO> selectCart(String MID) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CartDTO> cartList = new ArrayList<CartDTO>();
		
		try { 
			con = getConnection();
			
			String sql = "SELECT * FROM CART WHERE MID = ? order by CNO";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, MID);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CartDTO cart = new CartDTO();
				cart.setCNO(rs.getInt("CNO"));
				cart.setPNO(rs.getInt("PNO"));
				cart.setMID(rs.getString("MID"));
				cart.setCQUANTITY(rs.getInt("CQUANTITY"));
				
				cartList.add(cart);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectCart 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return cartList;
	}
	
	// 2. 장바구니 객체를 매개변수로 받아 삽입하는 메소드!
	public int insertCart(CartDTO cart) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			
			String sql = "INSERT INTO CART VALUES(?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, cart.getCNO());
			pstmt.setInt(2, cart.getPNO());
			pstmt.setString(3, cart.getMID());
			pstmt.setInt(4, cart.getCQUANTITY());
			
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] insertCart 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	// 3. 장바구니 객체를 매개변수로 받아 장바구니 상품 수량 수정 메소드!
	public int updateCart(int quantity, int cno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			String sql = "UPDATE CART SET CQUANTITY = ? WHERE CNO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, quantity);
			pstmt.setInt(2, cno);
			
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] updateCart 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	// 4. 장바구니 번호와 아이디를 매개변수로 받아 장바구니를 삭제하는 메소드!
	public int deleteCart(int cno ,String mid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try { 
			con = getConnection();
			
			String sql = "DELETE FROM CART WHERE CNO = ? AND MID=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cno);
			pstmt.setString(2, mid);
			
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] deleteCart 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	// 5. 카트번호 시퀀스 메소드
	public int cartNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select seq_cno.nextval from dual";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				nextNum=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]cartNextNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
	
	//6. 제품 정보를 전달받아 장바구니 상품을 출력하는 메소드
	public CartDTO selectNumCart(int PNO, String MID) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		CartDTO cart=null;
		try {
			con=getConnection();
			String sql="select * from cart where PNO=? and MID=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, PNO);
			pstmt.setString(2, MID);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				cart=new CartDTO();
				cart.setCNO(rs.getInt("CNO"));
				cart.setPNO(rs.getInt("PNO"));
				cart.setMID(rs.getString("MID"));
				cart.setCQUANTITY(rs.getInt("CQUANTITY"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNumCart() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt,rs);
		} return cart;
	}
	
	// 7. 장바구니 아이디를 매개변수로 받아 모든 장바구니를 삭제하는 메소드!
		public int deleteAllCart(String mid) {
			Connection con = null;
			PreparedStatement pstmt = null;
			int rows = 0;
			
			try { 
				con = getConnection();
				
				String sql = "DELETE FROM CART WHERE MID=?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, mid);
				
				rows = pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러] deleteAllCart() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}
		
	// 8. 장바구니 카운트 메소드
		public int selectCountCart(String mid) {
			//System.out.println(mid);
			Connection con = null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int count = 0;
			try {
				con=getConnection();
				String sql="select count(*) from cart where MID=?";
				pstmt=con.prepareStatement(sql);
				
				pstmt.setString(1, mid);
				
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					count=rs.getInt(1);
					
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectCountCart() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt,rs);
			} return count;
		}
			
	// 9. 장바구니 번호를 전달받아 장바구니 객체를 받아오는 메소드
		public CartDTO selectNoCart(int cartNo) {
			Connection con = null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			CartDTO cart=null;
			try {
				con=getConnection();
				String sql="select * from cart where CNO=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, cartNo);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					cart=new CartDTO();
					cart.setCNO(rs.getInt("CNO"));
					cart.setPNO(rs.getInt("PNO"));
					cart.setMID(rs.getString("MID"));
					cart.setCQUANTITY(rs.getInt("CQUANTITY"));
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectNoCart() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt,rs);
			} return cart;
		}
}
