package muskycode.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale.Category;

import org.eclipse.jdt.core.compiler.CategorizedProblem;

import muskycode.dto.ProductDTO;

public class ProductDAO extends JdbcDAO {
	private static ProductDAO _dao;

	private ProductDAO() {
		// TODO Auto-generated constructor stub
	}

	static {
		_dao = new ProductDAO();
	}

	public static ProductDAO getDAO() {
		return _dao;
	}

	// 1. 전체 상품 검색
	public List<ProductDTO> selectAllProduct() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();

		try {
			con = getConnection();

			String sql = "SELECT * FROM PRODUCT ORDER BY PNO";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();

				product.setPNO(rs.getInt("PNO"));
				product.setPNAME(rs.getString("PNAME"));
				product.setPPRICE(rs.getInt("PPRICE"));
				product.setPSTOCK(rs.getInt("PSTOCK"));
				product.setPCATEGORY(rs.getString("PCATEGORY"));
				product.setPCONTENT(rs.getString("PCONTENT"));
				product.setPIMGURL(rs.getString("PIMGURL"));
				product.setPSTATUS(rs.getInt("PSTATUS"));

				productList.add(product);
			}

		} catch (SQLException e) {
			System.out.println("selectAllProduct메소드의 SQL오류 " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}

		return productList;
	}

	// 2. 상품 이름 검색
	public ProductDTO selectNameProduct(String PNAME) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductDTO product = null;

		try {
			con = getConnection();

			String sql = "SELECT * FROM PRODUCT WHERE PNAME LIKE '%'||?||'%' ORDER BY PNO DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, PNAME);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				product = new ProductDTO();

				product.setPNO(rs.getInt("PNO"));
				product.setPNAME(rs.getString("PNAME"));
				product.setPPRICE(rs.getInt("PPRICE"));
				product.setPSTOCK(rs.getInt("PSTOCK"));
				product.setPCATEGORY(rs.getString("PCATEGORY"));
				product.setPCONTENT(rs.getString("PCONTENT"));
				product.setPIMGURL(rs.getString("PIMGURL"));
				product.setPSTATUS(rs.getInt("PSTATUS"));
			}

		} catch (SQLException e) {
			System.out.println("selectNameProduct메소드의 SQL오류 " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}

		return product;
	}

	// 3. 상품 추가
	public int insertProduct(ProductDTO product) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();
			System.out.println("메소드 호출!");
			System.out.println(product.getPCATEGORY());
			String sql = "INSERT INTO PRODUCT VALUES(SEQ_PNO.NEXTVAL,?,?,?,?,?,?,1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, product.getPNAME());
			pstmt.setInt(2, product.getPPRICE());
			pstmt.setInt(3, product.getPSTOCK());
			pstmt.setString(4, product.getPCATEGORY());
			pstmt.setString(5, product.getPCONTENT());
			pstmt.setString(6, product.getPIMGURL());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("insertProduct메소드의 SQL오류 " + e.getMessage());
		} finally {
			close(con, pstmt);
		}

		return rows;
	}

	// 4. 상품 정보 수정
	public int updateProduct(ProductDTO product) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();

			String sql = "UPDATE PRODUCT SET PNAME=?, PPRICE=?, PSTOCK=?, PCATEGORY=?, PCONTENT=?, PIMGURL=? WHERE PNO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, product.getPNAME());
			pstmt.setInt(2, product.getPPRICE());
			pstmt.setInt(3, product.getPSTOCK());
			pstmt.setString(4, product.getPCATEGORY());
			pstmt.setString(5, product.getPCONTENT());
			pstmt.setString(6, product.getPIMGURL());
			pstmt.setInt(7, product.getPNO());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("updateProduct메소드의 SQL오류 " + e.getMessage());
		} finally {
			close(con, pstmt);
		}

		return rows;
	}

	// 5. 상품 상태 변경 메소드 (삭제, 기본)
	public int updateStatusProduct(int pno, int status) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();

			String sql = "UPDATE PRODUCT SET PSTATUS=? WHERE PNO=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, status);
			pstmt.setInt(2, pno);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("updateStatusProduct메소드의 SQL오류 " + e.getMessage());
		} finally {
			close(con, pstmt);
		}

		return rows;
	}

	// 6. 카테고리를 매개변수로 받아 해당 카테고리의 제품 정보를 검색하여 반환하는 메소드!
	public List<ProductDTO> selectCategoryProductList(String category) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		try {
			con = getConnection();

			if (category.equals("ALL")) {// 모든 제품정보를 검색할 경우
				String sql = "SELECT * FROM PRODUCT ORDER BY PNO";
				pstmt = con.prepareStatement(sql);
			} else {
				String sql = "SELECT * FROM PRODUCT WHERE PCATEGORY = ? ORDER BY PNO DESC";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, category);
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setPNO(rs.getInt("PNO"));
				product.setPNAME(rs.getString("PNAME"));
				product.setPPRICE(rs.getInt("PPRICE"));
				product.setPSTOCK(rs.getInt("PSTOCK"));
				product.setPCATEGORY(rs.getString("PCATEGORY"));
				product.setPCONTENT(rs.getString("PCONTENT"));
				product.setPIMGURL(rs.getString("PIMGURL"));
				product.setPSTATUS(rs.getInt("PSTATUS"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectCategoryProductList 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}

	// 7. 상품 번호를 전달받아 해당 제품의 정보를 얻어 반환하는 메소드!
	public ProductDTO selectNumProduct(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductDTO product = null;
		try {
			con = getConnection();

			String sql = "SELECT * FROM PRODUCT WHERE PNO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				product = new ProductDTO();
				product.setPNO(rs.getInt("PNO"));
				product.setPNAME(rs.getString("PNAME"));
				product.setPPRICE(rs.getInt("PPRICE"));
				product.setPSTOCK(rs.getInt("PSTOCK"));
				product.setPCATEGORY(rs.getString("PCATEGORY"));
				product.setPCONTENT(rs.getString("PCONTENT"));
				product.setPIMGURL(rs.getString("PIMGURL"));
				product.setPSTATUS(rs.getInt("PSTATUS"));
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectNumProduct 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return product;
	}

	// 8. 검색 종류와 검색어를 전달 받아 해당 상품 레코드 수를 반환하는 메소드!
	public int selectProductCount(String search, String keyword, String category) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		try {
			con = getConnection();
			
			if(category.equals("ALL")) { // 카테고리 검색 X
				if (keyword.equals("")) {
					String sql = "SELECT COUNT(*) FROM PRODUCT";
					pstmt = con.prepareStatement(sql);
				} else {
					String sql = "SELECT COUNT(*) FROM PRODUCT WHERE " + search + " LIKE '%'||?||'%' ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, keyword);
				}
			}
			else { // 카테고리 검색 o
				if (keyword.equals("")) {
					String sql = "SELECT COUNT(*) FROM PRODUCT WHERE PCATEGORY = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, category);
				} else {
					String sql = "SELECT COUNT(*) FROM PRODUCT WHERE " + search + " LIKE '%'||?||'%' AND PCATEGORY = ? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, keyword);
					pstmt.setString(2, category);
				}
			}
			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectProductCount 부분 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}

	// 9. 시작 행번호와 종료 행번호를 전달받아 PRODUCT 테이블에 저장된 해당 행범위의 상품 목록을 검색하여 반환하는 메소드
	public List<ProductDTO> selectProductList(int startRow, int endRow, String search, String keyword,
			String category) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		try {
			con = getConnection();
			if (category.equals("ALL")) { // 카테고리 사용안한 경우
				if (keyword.equals("")) {// 검색기능을 사용하지 않은 경우
					String sql = "SELECT * FROM (SELECT ROWNUM RN,TEMP.* FROM "
							+ "(SELECT * FROM PRODUCT ORDER BY PNO DESC) TEMP) WHERE RN BETWEEN ? AND ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, startRow);
					pstmt.setInt(2, endRow);
				} else {
					String sql = "SELECT * FROM (SELECT ROWNUM RN,TEMP.* FROM " + "(SELECT * FROM PRODUCT WHERE "
							+ search + " LIKE '%'||?||'%' "
							+ "ORDER BY PNO DESC) TEMP) WHERE RN BETWEEN ? AND ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, keyword);
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, endRow);
				}
			} else {// 카테고리를 골랐을 경우
				if (keyword.equals("")) { // 검색기능을 사용하지 않은 경우
					String sql = "SELECT * FROM (SELECT TEMP2.* FROM (SELECT ROWNUM RN,TEMP.* FROM "
							+ "(SELECT * FROM PRODUCT WHERE PCATEGORY = ? ORDER BY PNO DESC) TEMP) TEMP2) WHERE RN BETWEEN ? AND ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, category);
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, endRow);

				}
				else {
					String sql = "SELECT TEMP2.* FROM (SELECT ROWNUM RN,TEMP.* FROM "
							+ "(SELECT * FROM PRODUCT WHERE " + search + " LIKE '%'||?||'%' WHERE PCATEGORY = ?"
							+ "ORDER BY PNO DESC) TEMP) TEMP2) WHERE RN BETWEEN ? AND ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, keyword);
					pstmt.setString(2, category);
					pstmt.setInt(3, startRow);
					pstmt.setInt(4, endRow);

				}
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setPNO(rs.getInt("PNO"));
				product.setPNAME(rs.getString("PNAME"));
				product.setPPRICE(rs.getInt("PPRICE"));
				product.setPSTOCK(rs.getInt("PSTOCK"));
				product.setPCATEGORY(rs.getString("PCATEGORY"));
				product.setPCONTENT(rs.getString("PCONTENT"));
				product.setPIMGURL(rs.getString("PIMGURL"));
				product.setPSTATUS(rs.getInt("PSTATUS"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductList 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
	// 10. 카테고리별 상품의 개수를 반환
	public int selectCategoryProductCount(String category) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		try {
			con = getConnection();

			String sql = "SELECT COUNT(*) FROM PRODUCT WHERE PCATEGORY= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, category);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectCategoryProductCount 부분 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	
	// 11. 시작 행번호와 종료 행번호를 전달받아 PRODUCT 테이블에 저장된 해당 행범위의 상품 목록을 카테고리별로 검색하는 메소드
		public List<ProductDTO> selectProductList(int startRow, int endRow, String category) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<ProductDTO> productList = new ArrayList<ProductDTO>();
			try {
				con = getConnection();

				String sql = "SELECT * FROM (SELECT rownum rn, PRD.* FROM (SELECT * FROM PRODUCT WHERE PSTATUS=1 AND PCATEGORY = ? ORDER BY PNO DESC) PRD) WHERE rn BETWEEN ? AND ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, category);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);

				rs = pstmt.executeQuery();

				while (rs.next()) {
					ProductDTO product = new ProductDTO();
					product.setPNO(rs.getInt("PNO"));
					product.setPNAME(rs.getString("PNAME"));
					product.setPPRICE(rs.getInt("PPRICE"));
					product.setPSTOCK(rs.getInt("PSTOCK"));
					product.setPCATEGORY(rs.getString("PCATEGORY"));
					product.setPCONTENT(rs.getString("PCONTENT"));
					product.setPIMGURL(rs.getString("PIMGURL"));
					product.setPSTATUS(rs.getInt("PSTATUS"));
					productList.add(product);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectProductList 메소드의 SQL 오류 = " + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return productList;
		}
		

	// 12. 카테고리별 판매중인 상품의 개수를 반환
	public int selectStatusProductCount(String category) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		try {
			con = getConnection();

			String sql = "SELECT COUNT(*) FROM PRODUCT WHERE PCATEGORY= ? AND PSTATUS=1";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, category);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectCategoryProductCount 부분 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	// 13. 키워드가 포함된 판매 제품 목록을 반환하는 메소드
	public List<ProductDTO> selectKeywordProduct(String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		
		try {
			con = getConnection();

			String sql = "SELECT PRD.* FROM (SELECT * FROM PRODUCT WHERE PSTATUS=1 ORDER BY PNO DESC) PRD WHERE PNAME LIKE '%'||?||'%'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, keyword);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setPNO(rs.getInt("PNO"));
				product.setPNAME(rs.getString("PNAME"));
				product.setPPRICE(rs.getInt("PPRICE"));
				product.setPSTOCK(rs.getInt("PSTOCK"));
				product.setPIMGURL(rs.getString("PIMGURL"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectKeywordProduct 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
	
	// 14. 회원 아이디를 전달받아 회원이 구매한 상품 정보 검색
	public List<ProductDTO> selectMemberBuyProduct(String mid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();

		try {
			con = getConnection();

			String sql = "SELECT * FROM PRODUCT WHERE MID=? ORDER BY PNO DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();

				product.setPNO(rs.getInt("PNO"));
				product.setPNAME(rs.getString("PNAME"));
				product.setPPRICE(rs.getInt("PPRICE"));
				product.setPSTOCK(rs.getInt("PSTOCK"));
				product.setPCATEGORY(rs.getString("PCATEGORY"));
				product.setPCONTENT(rs.getString("PCONTENT"));
				product.setPIMGURL(rs.getString("PIMGURL"));
				product.setPSTATUS(rs.getInt("PSTATUS"));

				productList.add(product);
			}

		} catch (SQLException e) {
			System.out.println("selectMemberBuyProduct메소드의 SQL오류 " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}

		return productList;
	}
	
	// 15. 검색어를 전달 받아 해당 검색어가 포함된 모든 상품의 판매 개수를 반환하는 메소드
	public int searchProductCount(String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		try {
			con = getConnection();
			
			String sql = "SELECT COUNT(*) FROM (SELECT * FROM PRODUCT WHERE PSTATUS=1 ORDER BY PNO DESC) WHERE PNAME LIKE '%'||?||'%'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, keyword);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러] searchProductCount 부분 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	// 16. 주문 완료 후 상품 재고 수 감소하는 메소드
	public int deleteOrderStock(int stock, int pno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int count = 0;
		
		try {
			con = getConnection();
			
			String sql = "UPDATE PRODUCT SET PSTOCK = PSTOCK - ? WHERE PNO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, stock);
			pstmt.setInt(2, pno);
			
			count = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] deleteOrderStock 부분 오류" + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return count;
	}
}