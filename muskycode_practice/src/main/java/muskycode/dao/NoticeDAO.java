package muskycode.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import muskycode.dto.NoticeDTO;

public class NoticeDAO extends JdbcDAO {

	private static NoticeDAO _dao;

	private NoticeDAO() {

	}

	static {
		_dao = new NoticeDAO();
	}

	public static NoticeDAO getDAO() {
		return _dao;
	}

	// 공지사항 ----------------------------------------------- 시작
	/*
	 * public List<NoticeDTO> SelectAllNotice() { // 공지사항 전체 검색 (보류) Connection con
	 * = null; PreparedStatement pstmt = null; ResultSet rs = null; List<NoticeDTO>
	 * noticeList = new ArrayList<NoticeDTO>(); try { con = getConnection();
	 * 
	 * String sql = "SELECT * FROM NOTICE ORDER BY NNO DESC"; pstmt =
	 * con.prepareStatement(sql);
	 * 
	 * rs = pstmt.executeQuery(); while (rs.next()) { NoticeDTO notice = new
	 * NoticeDTO(); notice.setNNO(rs.getInt("NNO"));
	 * notice.setNHITT(rs.getInt("NHIT")); notice.setNDATE(rs.getString("NDATE"));
	 * notice.setNTITLE(rs.getString("NTITLE"));
	 * notice.setNCONTENT(rs.getString("NCONTENT")); noticeList.add(notice); }
	 * 
	 * } catch (SQLException e) {
	 * System.out.println("[에러] SelectALlNotice 부분에서 오류 발생 " + e.getMessage()); }
	 * finally { close(con, pstmt, rs); } return noticeList; }
	 */

	public List<NoticeDTO> SelectTitleNotice(NoticeDTO notice) { // 제목으로 공지사항 검색
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<NoticeDTO> titleNoticeList = new ArrayList<NoticeDTO>();
		try {
			con = getConnection();

			String sql = "SELECT * FROM NOTICE WHERE NTITLE LIKE '%'||?||'%' ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, notice.getNTITLE());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				NoticeDTO notice1 = new NoticeDTO();
				notice1.setNNO(rs.getInt("NNO"));
				notice1.setNHIT(rs.getInt("NHIT"));
				notice1.setNDATE(rs.getString("NDATE"));
				notice1.setNTITLE(rs.getString("NTITLE"));
				notice1.setNCONTENT(rs.getString("NCONTENT"));
				titleNoticeList.add(notice1);
			}

		} catch (SQLException e) {
			System.out.println("[에러] SelectTitleNotice 부분에서 오류 발생 " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return titleNoticeList;
	}

	public int InsertNotice(NoticeDTO notice) { // 공지사항 등록
		Connection con = null;
		PreparedStatement pstmt = null;

		int rows = 0;
		try {
			con = getConnection();

			String sql = "INSERT INTO NOTICE VALUES(?,?,?,1,SYSDATE)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, notice.getNNO());
			pstmt.setString(2, notice.getNTITLE());
			pstmt.setString(3, notice.getNCONTENT());

			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러] InsertNotice 부분에서 오류 발생");
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	public int UpdateNotice(NoticeDTO notice) { // 공지사항 수정
		Connection con = null;
		PreparedStatement pstmt = null;

		int rows = 0;
		try {
			con = getConnection();

			String sql = "UPDATE NOTICE SET NTITLE=?,NCONTENT=? WHERE NNO=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, notice.getNTITLE());
			pstmt.setString(2, notice.getNCONTENT());
			pstmt.setInt(3, notice.getNNO());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] UpdateNotice 부분에서 오류 발생");
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	public int DeleteNotice(int nno) { // 공지사항 삭제
		Connection con = null;
		PreparedStatement pstmt = null;

		int rows = 0;
		try {
			con = getConnection();

			String sql = "DELETE FROM NOTICE WHERE NNO=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, nno);

			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러] DeleteNotice 부분에서 오류 발생");
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	public int selectNoticeCount(String search, String keyword) { // 총 공지글 수 반환
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();
			if (keyword.equals("")) {
				String sql = "SELECT COUNT(*) FROM NOTICE";
				pstmt = con.prepareStatement(sql);
			} else {
				String sql = "SELECT COUNT(*) FROM NOTICE WHERE "+search+" LIKE '%'||?||'%' ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectNoticeCount 부분 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}

	public int selectNextNo() { // 다음 공지글 번호 반환
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int nextNo = 0;

		try {
			con = getConnection();

			String sql = "SELECT SEQ_NNO.NEXTVAL FROM DUAL";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				nextNo = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectNextNo() 메소드의 SQL 오류 : " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNo;

	}

	// 공지사항 전체 검색
	public List<NoticeDTO> selectNoticeList(int startRow, int endRow, String search, String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<NoticeDTO> noticeList = new ArrayList<NoticeDTO>();
		try {
			con = getConnection();

			if (keyword.equals("")) {
				String sql = "SELECT * FROM (SELECT ROWNUM RN, TEMP.* FROM "
						+ "(SELECT * FROM NOTICE ORDER BY NNO DESC) TEMP) WHERE RN BETWEEN ? AND ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {
				//System.out.println(search + keyword);
				String sql = "SELECT * FROM (SELECT ROWNUM RN, TEMP.* FROM " + "(SELECT * FROM NOTICE WHERE " + search
						+ " LIKE '%'||?||'%'" + "ORDER BY NNO DESC ) TEMP ) WHERE RN BETWEEN ? AND ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				NoticeDTO notice = new NoticeDTO();
				notice.setNNO(rs.getInt("NNO"));
				notice.setNHIT(rs.getInt("NHIT"));
				notice.setNDATE(rs.getString("NDATE"));
				notice.setNTITLE(rs.getString("NTITLE"));
				notice.setNCONTENT(rs.getString("NCONTENT"));
				noticeList.add(notice);
			}

		} catch (SQLException e) {
			System.out.println("[에러] SelectNoticeList 부분에서 오류 발생 " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return noticeList;
	}

	// 글 번호를 입력 받아 게시글 객체를 반환하는 메소드!
	public NoticeDTO selectNumNotice(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		NoticeDTO notice = null;

		try {
			con = getConnection();

			String sql = "SELECT * FROM NOTICE WHERE NNO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				notice = new NoticeDTO();
				notice.setNNO(rs.getInt("NNO"));
				notice.setNTITLE(rs.getString("NTITLE"));
				notice.setNCONTENT(rs.getString("NCONTENT"));
				notice.setNHIT(rs.getInt("NHIT"));
				notice.setNDATE(rs.getString("NDATE"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNumNotice 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return notice;
	}

	public int updateReadcount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "UPDATE NOTICE SET NHIT = NHIT + 1 WHERE NNO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateReadcount 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

}
