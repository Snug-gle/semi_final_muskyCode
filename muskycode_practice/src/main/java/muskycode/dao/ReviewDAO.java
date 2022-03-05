package muskycode.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import muskycode.dto.ReviewDTO;

public class ReviewDAO extends JdbcDAO {

	private static ReviewDAO _dao;

	private ReviewDAO() {
		// TODO Auto-generated constructor stub
	}

	static {
		_dao = new ReviewDAO();
	}

	public static ReviewDAO getDAO() {
		return _dao;
	}

	//1.리뷰 작성
	public int InsertReview(ReviewDTO review) { // 리뷰 작성
		Connection con = null;
		PreparedStatement pstmt = null;

		int rows = 0;
		try {
			con = getConnection();

			String sql = "INSERT INTO REVIEW VALUES(SEQ_RNO.NEXTVAL,?,?,?" + ",SYSDATE,0,?,1)";
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, review.getMID());
			pstmt.setString(2, review.getRTITLE());
			pstmt.setString(3, review.getRCONTENT());
			pstmt.setString(4, review.getRIMGURL());
			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러] InsertReview 부분에서 에러 발생 " + e.getMessage());
		} finally {
			close(con, pstmt);
		}

		return rows;
	}

	//2. 리뷰번호를 전달받아 리뷰를 수정하는 메소드
	public int UpdateReview(ReviewDTO review) { 
		Connection con = null;
		PreparedStatement pstmt = null;

		int rows = 0;

		try {
			con = getConnection();

			String sql = "UPDATE REVIEW SET RTITLE=?, RCONTENT=?, RIMGURL = ? WHERE RNO=?";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, review.getRTITLE());
			pstmt.setString(2, review.getRCONTENT());
			pstmt.setString(3, review.getRIMGURL());
			/* pstmt.setString(3, review.getRIMGURL()); */
			pstmt.setInt(4, review.getRNO());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] UpdateReview 부분에서 에러 발생 " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	//3. 리뷰 번호를 전달받아 리뷰를 삭제하는 메소드(STATUS=0으로 변경)
	public int DeleteReview(int num) { 
		Connection con = null;
		PreparedStatement pstmt = null;

		int rows = 0;
		try {
			con = getConnection();

			String sql = "UPDATE REVIEW SET RSTATUS = 0 " + " WHERE RNO=?";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, num);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] DeleteReview 부분에서 오류 발생 " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	//4.모든 리뷰 검색
	public List<ReviewDTO> SelectAllReview(int startRow, int endRow, String search, String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();

		try {
			con = getConnection();
			
			if (keyword.equals("")) {
				String sql = "SELECT * FROM (SELECT ROWNUM RN, TEMP.* FROM "
						+ "(SELECT * FROM REVIEW ORDER BY RNO DESC) TEMP) WHERE RN BETWEEN ? AND ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {
				//System.out.println(search + keyword);
				String sql = "SELECT * FROM (SELECT ROWNUM RN, TEMP.* FROM " + "(SELECT * FROM REVIEW WHERE " + search
						+ " LIKE '%'||?||'%' AND RSTATUS!=0" + "ORDER BY RNO DESC ) TEMP ) WHERE RN BETWEEN ? AND ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ReviewDTO review = new ReviewDTO();
				review.setMID(rs.getString("MID"));
				review.setRTITLE(rs.getString("RTITLE"));
				review.setRCONTENT(rs.getString("RCONTENT"));
				review.setRIMGURL(rs.getString("RIMGURL"));
				review.setRDATE(rs.getString("RDATE"));
				review.setRNO(rs.getInt("RNO"));
				review.setRHIT(rs.getInt("RHIT"));
				review.setRSTATUS(rs.getInt("RSTATUS"));
				reviewList.add(review);
			}

		} catch (SQLException e) {
			System.out.println("[에러] SelectAllReview 부분에서 에러 발생 " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return reviewList;
	}

	//5. 상품번호를 전달받아서 해당 상품의 리뷰 검색
	public List<ReviewDTO> SelectNoReview(int pno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();

		try {
			con = getConnection();

			String sql = "SELECT * FROM REVIEW WHERE PNO=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReviewDTO review = new ReviewDTO();
				review.setMID(rs.getString("MID"));
				review.setRTITLE(rs.getString("RTITLE"));
				review.setRCONTENT(rs.getString("RCONTENT"));
				review.setRIMGURL(rs.getString("RIMGURL"));
				review.setRDATE(rs.getString("RDATE"));
				review.setRNO(rs.getInt("RNO"));
				review.setRREF(rs.getInt("RREF"));
				review.setRHIT(rs.getInt("RHIT"));
				review.setRREF_STEP(rs.getInt("RREF_STEP"));
				review.setRREF_LEVEL(rs.getInt("RREF_LEVEL"));
				review.setRSTATUS(rs.getInt("RSTATUS"));
				reviewList.add(review);
			}

		} catch (SQLException e) {
			System.out.println("[에러] SelectNoReview 부분에서 에러 발생 " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return reviewList;
	}

	//6. 제품번호를 전달받아 Review 테이블에 저장된 게시글의 개수를 검색하여 반환하는 메소드
	public int selectPnoRboardCount (int pno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		try {
			con = getConnection();

			String sql = "select count(*) from review WHERE PNO=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pno);

			rs = pstmt.executeQuery();       

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectPnoRboardCount() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}

	//7.시작번호와 끝번호를 전달받아 게시글을 출력하는 메소드
	public List<ReviewDTO> selectReviewList(int startRow, int endRow) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReviewDTO> ReviewList = new ArrayList<ReviewDTO>();
		try {
			con = getConnection();

			String sql = "SELECT * FROM (SELECT ROWNUM RN, TEMP.* FROM "
					+ "(SELECT * FROM REVIEW ORDER BY RNO DESC) TEMP) WHERE RN BETWEEN ? AND ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReviewDTO review = new ReviewDTO();
				review.setMID(rs.getString("MID"));
				review.setRNO(rs.getInt("RNO"));
				review.setRCONTENT(rs.getString("RCONTENT"));
				review.setRDATE(rs.getString("RDATE"));
				review.setRHIT(rs.getInt("RHIT"));
				review.setRIMGURL(rs.getString("RIMGURL"));
				review.setRTITLE(rs.getString("RTITLE"));
				review.setRSTATUS(rs.getInt("RSTATUS"));
				ReviewList.add(review);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectReviewList() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return ReviewList;
	}

	//8. 시퀀스 메소드
	public int selectNextNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int nextNum = 0;
		try {
			con = getConnection();
			String sql = "select SEQ_RNO.nextval from dual";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				nextNum = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNextNum() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;

	}
	
	//9.리뷰번호를 전달받아 리뷰글을 검색하는 메소드
	public ReviewDTO selectNumReview(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ReviewDTO review = null;
		try {
			con = getConnection();

			String sql = "SELECT * FROM REVIEW WHERE RNO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				review = new ReviewDTO();
				review.setMID(rs.getString("MID"));
				review.setRNO(rs.getInt("RNO"));
				review.setRCONTENT(rs.getString("RCONTENT"));
				review.setRDATE(rs.getString("RDATE"));
				review.setRHIT(rs.getInt("RHIT"));
				review.setRIMGURL(rs.getString("RIMGURL"));
				review.setRTITLE(rs.getString("RTITLE"));
				review.setRSTATUS(rs.getInt("RSTATUS"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNumReview 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return review;
	}
	
	//10.조회수를 증가시키는 메소드
	public int updateHit(int num) { 
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="UPDATE REVIEW SET RHIT=RHIT+1 where RNO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] updateHit 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//11. 모든 리뷰 게시판의 게시글 개수를 반환하는 메소드
	public int selectCountBoard(String search, String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		try {
			con = getConnection();
			if (keyword.equals("")) {
				String sql = "select count(*) from REVIEW ORDER BY RNO DESC";
				pstmt = con.prepareStatement(sql);
			} else {
				String sql = "select count(*) from REVIEW WHERE "+search+" LIKE '%'||?||'%' ORDER BY RNO DESC";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
		
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}

		} catch (SQLException e) {
			System.out.println("[에러]selectCountBoard() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
}
