package muskycode.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import muskycode.dto.QnaDTO;

public class QnaDAO extends JdbcDAO {
	private static QnaDAO _dao;

	private QnaDAO() {
		// TODO Auto-generated constructor stub
	}

	static {
		_dao = new QnaDAO();
	}

	public static QnaDAO getDAO() {
		return _dao;
	}

	public int InsertQna(QnaDTO qna) { // QNA 질문글 등록
		Connection con = null;
		PreparedStatement pstmt = null;

		int rows = 0;
		try {
			con = getConnection();

			String sql = "INSERT INTO QNA VALUES(?,?,SYSDATE,?,?,?,'N',?,?,?,?,SYSDATE,?,0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qna.getQNO());
			pstmt.setString(2, qna.getMID());
			pstmt.setString(3, qna.getQTITLE());
			pstmt.setString(4, qna.getQCONTENT());
			pstmt.setString(5, qna.getQCATEGORY());
			pstmt.setString(6, qna.getQACONTENT());
			pstmt.setInt(7, qna.getQREF());
			pstmt.setInt(8, qna.getQREF_STEP());
			pstmt.setInt(9, qna.getQREF_LEVEL());
			pstmt.setInt(10, qna.getQSTATUS());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] InsertQna 부분에서 오류 발생 " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	public int UpdateQna(QnaDTO qna) { // QNA 질문글 수정 (유저)
		Connection con = null;
		PreparedStatement pstmt = null;

		int rows = 0;
		try {
			con = getConnection();

			String sql = "UPDATE QNA SET QTITLE=? ,QCONTENT=? WHERE QNO=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, qna.getQTITLE());
			pstmt.setString(2, qna.getQCONTENT());
			/* pstmt.setString(2, qna.getQCATEGORY()); */
			pstmt.setInt(3, qna.getQNO());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] UpdateQna 부분에서 오류 발생 " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	public int InsertAdminQna(QnaDTO qna) { // QNA 답글
		Connection con = null;
		PreparedStatement pstmt = null;

		int rows = 0;
		try {
			con = getConnection();

			String sql = "UPDATE QNA SET QANSWER=?,QACONTENT=?" + ",QADATE=? WHERE QNO=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, qna.getQANSWER());
			pstmt.setString(2, qna.getQACONTENT());
			pstmt.setString(3, qna.getQADATE());
			pstmt.setInt(4, qna.getQNO());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] InsertAdminQna 부분에서 오류 발생 " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	public int UpdateAdminQna(QnaDTO qna) { // QNA 답글 수정
		Connection con = null;
		PreparedStatement pstmt = null;

		int rows = 0;
		try {
			con = getConnection();

			String sql = "UPDATE QNA SET QANSWER=?" + ",QACONTENT=?,QADATE=? WHERE QNO=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, qna.getQACONTENT());
			pstmt.setString(2, qna.getQDATE());
			pstmt.setInt(3, qna.getQNO());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] UpdateAdminQna 부분에서 오류 발생 " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	public int DeleteAdminQna(QnaDTO qna) { // QNA 답글 관리자가 삭제
		Connection con = null;
		PreparedStatement pstmt = null;

		int rows = 0;
		try {
			con = getConnection();

			String sql = "UPDATE QNA SET QANSWER=‘N’," + "QACONTENT=? ,QADATE=?" + ",QSTATUS = 0 WHERE QNO=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, qna.getQACONTENT());
			pstmt.setString(2, qna.getQDATE());
			pstmt.setInt(3, qna.getQNO());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] DeleteAdminQna 부분에서 오류 발생 " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	public int DeleteQna(int num) { // QNA 글 삭제
		Connection con = null;
		PreparedStatement pstmt = null;

		int rows = 0;
		try {
			con = getConnection();

			String sql = "UPDATE QNA SET QSTATUS = 0 " + " WHERE QNO=?";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, num);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] DeleteQna 부분에서 오류 발생 " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	public List<QnaDTO> SelectAllQna() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QnaDTO> qnaList = new ArrayList<QnaDTO>();

		try {
			con = getConnection();

			String sql = "SELECT * FROM QNA ORDER BY QDATE DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				QnaDTO qna = new QnaDTO();
				qna.setQNO(rs.getInt("QNO"));
				qna.setPNO(rs.getInt("PNO"));
				qna.setMID(rs.getString("MID"));
				qna.setQDATE(rs.getString("QDATE"));
				qna.setQTITLE(rs.getString("QTITLE"));
				qna.setQCONTENT(rs.getString("QCONTENT"));
				qna.setQCATEGORY(rs.getString("QCATEGORI"));
				qna.setQREF(rs.getInt("QREF"));
				qna.setQREF(rs.getInt("QREF_STEP"));
				qna.setQREF(rs.getInt("QREF_LEVEL"));
				qna.setQADATE(rs.getString("QADATE"));
				qna.setQSTATUS(rs.getInt("QSTATUS"));
				qnaList.add(qna);
			}
		} catch (SQLException e) {
			System.out.println("[에러] SelectAllQna" + " 부분에서 오류 발생 " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qnaList;
	}

	public List<QnaDTO> SelectNoAnswerQna() { // 답글 없는 게시글 검색
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QnaDTO> qnaList = new ArrayList<QnaDTO>();

		try {
			con = getConnection();

			String sql = "SELECT * FROM QNA WHERE  QANSWER = 'N'";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				QnaDTO qna = new QnaDTO();
				qna.setQNO(rs.getInt("QNO"));
				qna.setPNO(rs.getInt("PNO"));
				qna.setMID(rs.getString("MID"));
				qna.setQDATE(rs.getString("QDATE"));
				qna.setQTITLE(rs.getString("QTITLE"));
				qna.setQCONTENT(rs.getString("QCONTENT"));
				qna.setQCATEGORY(rs.getString("QCATEGORI"));
				qna.setQREF(rs.getInt("QREF"));
				qna.setQREF(rs.getInt("QREF_STEP"));
				qna.setQREF(rs.getInt("QREF_LEVEL"));
				qna.setQADATE(rs.getString("QADATE"));
				qna.setQSTATUS(rs.getInt("QSTATUS"));
				qnaList.add(qna);
			}
		} catch (SQLException e) {
			System.out.println("[에러] SelectNoAnswerQna" + " 부분에서 오류 발생 " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qnaList;
	}

	public List<QnaDTO> SelectMyQna(QnaDTO qna) { // 회원 QNA List 반환
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QnaDTO> qnaList = new ArrayList<QnaDTO>();

		try {
			con = getConnection();

			String sql = "SELECT QNO, QDATE, QTITLE," + " QCONTENT, QCATEGORI ,QANSWER," + " QACONTENT FROM QNA WHERE "
					+ "MID = ? ORDER BY QDATE DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, qna.getMID());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				QnaDTO qna1 = new QnaDTO();
				qna1.setQNO(rs.getInt("QNO"));
				qna1.setPNO(rs.getInt("PNO"));
				qna1.setMID(rs.getString("MID"));
				qna1.setQDATE(rs.getString("QDATE"));
				qna1.setQTITLE(rs.getString("QTITLE"));
				qna1.setQCONTENT(rs.getString("QCONTENT"));
				qna1.setQCATEGORY(rs.getString("QCATEGORI"));
				qna1.setQREF(rs.getInt("QREF"));
				qna1.setQREF(rs.getInt("QREF_STEP"));
				qna1.setQREF(rs.getInt("QREF_LEVEL"));
				qna1.setQADATE(rs.getString("QADATE"));
				qna1.setQSTATUS(rs.getInt("QSTATUS"));
				qnaList.add(qna1);
			}
		} catch (SQLException e) {
			System.out.println("[에러] SelectMyQna" + " 부분에서 오류 발생 " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qnaList;
	}
	
	// 검색, 내용, 시작, 끝 행번호 매개변수 전달받아 해당 QNA 게시글 갯수 반환
	public List<QnaDTO> SelectQnaList(int startRow, int endRow, String search, String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QnaDTO> qnaList = new ArrayList<QnaDTO>();

		try {
			con = getConnection();

			if (keyword.equals("")) {
				String sql = "select * from (select rownum rn,temp.* from "
						+ "(select * from qna order by QREF desc,QREF_STEP) temp) where rn between ? and ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {

				String sql = "select * from (select rownum rn,temp.* from " + "(select * from qna where " + search
						+ " like '%'||?||'%' and qstatus!=0 "
						+ "order by QREF desc ,QREF_STEP) temp) where rn between ? and ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				QnaDTO qna = new QnaDTO();
				qna.setQNO(rs.getInt("QNO"));
				qna.setMID(rs.getString("MID"));
				qna.setQDATE(rs.getString("QDATE"));
				qna.setQTITLE(rs.getString("QTITLE"));
				qna.setQCONTENT(rs.getString("QCONTENT"));
				qna.setQCATEGORY(rs.getString("QCATEGORY"));
				qna.setQREF(rs.getInt("QREF"));
				qna.setQREF_STEP(rs.getInt("QREF_STEP"));
				qna.setQREF_LEVEL(rs.getInt("QREF_LEVEL"));
				qna.setQADATE(rs.getString("QADATE"));
				qna.setQSTATUS(rs.getInt("QSTATUS"));
				qna.setQHIT(rs.getInt("QHIT"));
				qna.setQACONTENT(rs.getString("QACONTENT"));
				qna.setQANSWER(rs.getString("QANSWER"));
				qnaList.add(qna);

			}
		} catch (SQLException e) {
			System.out.println("[에러] SelectQnaList" + " 부분에서 오류 발생 " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qnaList;
	}
	
	// 검색, 내용 매개변수 전달받아 해당 QNA 게시글 갯수 반환
	public int selectQnaCount(String search, String keyword) { 
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int count = 0;

		try {
			con = getConnection();

			if (keyword.equals("")) { // 검색 사용 안함
				String sql = "SELECT COUNT(*) FROM QNA";
				pstmt = con.prepareStatement(sql);
			} else {
				String sql = "SELECT COUNT(*) FROM QNA WHERE " + search + " like '%'||?||'%' ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.getMessage();
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}

	public int selectNextNum() { // 시퀀스 다음 값 반환
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int nextNum = 0;
		try {
			con = getConnection();

			String sql = "select SEQ_QNO.nextval from dual";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				nextNum = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNextNum 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}

	// BOARD 테이블에 저장된 게시글 중 조건에 맞는 게시글의 RE_STEP 컬럼값을 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateqRefStep(int ref, int refStep) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "update qna set qref_step=qref_step+1 where qref=? and qref_step>?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, refStep);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateRefStep 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 글번호를 전달받아 BOARD 테이블에 저장된 해당 글번호의 게시글을 검색하여 반환하는
	public QnaDTO selectNumQna(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QnaDTO qna = null;
		try {
			con = getConnection();

			String sql = "SELECT * FROM QNA WHERE QNO = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				qna = new QnaDTO();
				qna.setQNO(rs.getInt("QNO"));
				qna.setMID(rs.getString("MID"));
				qna.setQDATE(rs.getString("QDATE"));
				qna.setQTITLE(rs.getString("QTITLE"));
				qna.setQCONTENT(rs.getString("QCONTENT"));
				qna.setQCATEGORY(rs.getString("QCATEGORY"));
				qna.setQREF(rs.getInt("QREF"));
				qna.setQREF_STEP(rs.getInt("QREF_STEP"));
				qna.setQREF_LEVEL(rs.getInt("QREF_LEVEL"));
				qna.setQADATE(rs.getString("QADATE"));
				qna.setQSTATUS(rs.getInt("QSTATUS"));
				qna.setQHIT(rs.getInt("QHIT"));
				qna.setQACONTENT(rs.getString("QACONTENT"));
				qna.setQANSWER(rs.getString("QANSWER"));

			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNumQna 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qna;
	}

	// 글번호를 전달받아 BOARD 테이블에 저장된 해당 글번호의 게시글 조회수를 변경(증가)
	// 하고 변경행의 갯수를 반환하는 메소드
	public int updateQhit(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "UPDATE QNA SET QHIT=QHIT+1 where QNO=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] updateQhit 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	public int UpdateAnswer(int num) { // 답글 달면 답변여부 수정
		Connection con = null;
		PreparedStatement pstmt = null;

		int rows = 0;
		try {
			con = getConnection();

			String sql = "UPDATE QNA SET QANSWER='Y' WHERE QNO=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] UpdateAnswer 부분에서 오류 발생 " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	public int UpdateCategory(int num, String qcategory) { // 답글 달면 답변여부 수정
		Connection con = null;
		PreparedStatement pstmt = null;

		int rows = 0;
		try {
			con = getConnection();

			String sql = "UPDATE QNA SET QANSWER=? WHERE QNO=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, qcategory);
			pstmt.setInt(2, num);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] UpdateCategory 부분에서 오류 발생 " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 아이디와 상태로 QNA 게시글 수 받아오기
	public int selectIdQnaCount(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {

			con = getConnection();
			String sql = "SELECT Count(*) FROM QNA WHERE MID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectIdQnaCount 부분 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	// 회원 개인 QNA 글 조회 리스트 반환하는 메소드
	public List<QnaDTO> SelectQnaIdList(int startRow, int endRow, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QnaDTO> qnaList = new ArrayList<QnaDTO>();

		try {
				con = getConnection();
				String sql = "select * from (select rownum rn,temp.* from "
						+ "(select * from qna where mid = ? order by QREF desc,QREF_STEP) temp) where rn between ? and ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);


			rs = pstmt.executeQuery();

			while (rs.next()) {
				QnaDTO qna = new QnaDTO();
				qna.setQNO(rs.getInt("QNO"));
				qna.setMID(rs.getString("MID"));
				qna.setQDATE(rs.getString("QDATE"));
				qna.setQTITLE(rs.getString("QTITLE"));
				qna.setQCONTENT(rs.getString("QCONTENT"));
				qna.setQCATEGORY(rs.getString("QCATEGORY"));
				qna.setQREF(rs.getInt("QREF"));
				qna.setQREF_STEP(rs.getInt("QREF_STEP"));
				qna.setQREF_LEVEL(rs.getInt("QREF_LEVEL"));
				qna.setQADATE(rs.getString("QADATE"));
				qna.setQSTATUS(rs.getInt("QSTATUS"));
				qna.setQHIT(rs.getInt("QHIT"));
				qna.setQACONTENT(rs.getString("QACONTENT"));
				qna.setQANSWER(rs.getString("QANSWER"));
				qnaList.add(qna);

			}
		} catch (SQLException e) {
			System.out.println("[에러] SelectQnaIdList" + " 부분에서 오류 발생 " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qnaList;
	}
}
