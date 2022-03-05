package muskycode.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import muskycode.dto.MemberDTO;

public class MemberDAO extends JdbcDAO {
	private static MemberDAO _dao;

	private MemberDAO() {

	}

	static {
		_dao = new MemberDAO();
	}

	public static MemberDAO getDAO() {
		return _dao;
	}

	// 1. 시작 행번호와 종료 행번호를 전달받아 회원 리스트를 반환하는 메소드!
	public List<MemberDTO> selectMemberList(int startRow, int endRow) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MemberDTO> memberList = new ArrayList<MemberDTO>();

		try {
			con = getConnection();

			String sql = "SELECT * FROM (SELECT ROWNUM RN, TEMP.* FROM "
					+"(SELECT * FROM MEMBER ORDER BY MID DESC) TEMP) WHERE RN BETWEEN ? AND ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				MemberDTO member = new MemberDTO();
				member.setMID(rs.getString("MID"));
				member.setMPW(rs.getString("MPW"));
				member.setMNAME(rs.getString("MNAME"));
				member.setMADDRESS1(rs.getString("MADDRESS1"));
				member.setMADDRESS2(rs.getString("MADDRESS2"));
				member.setMZIP(rs.getString("MZIP"));
				member.setMPHONE(rs.getString("MPHONE"));
				member.setMEMAIL(rs.getString("MEMAIL"));
				member.setMRESERVES(rs.getInt("MRESERVES"));
				member.setMGRADE(rs.getInt("MGRADE"));
				memberList.add(member);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectMemberList 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return memberList;
	}

	// 2. 아이디를 매개변수로 받아 회원 조회 메소드!
	public MemberDTO selectIdMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDTO member = null;

		try {
			con = getConnection();

			String sql = "SELECT * FROM MEMBER WHERE MID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				member = new MemberDTO();
				member.setMID(rs.getString("MID"));
				member.setMPW(rs.getString("MPW"));
				member.setMNAME(rs.getString("MNAME"));
				member.setMADDRESS1(rs.getString("MADDRESS1"));
				member.setMADDRESS2(rs.getString("MADDRESS2"));
				member.setMZIP(rs.getString("MZIP"));
				member.setMPHONE(rs.getString("MPHONE"));
				member.setMEMAIL(rs.getString("MEMAIL"));
				member.setMRESERVES(rs.getInt("MRESERVES"));
				member.setMGRADE(rs.getInt("MGRADE"));
			}

		} catch (SQLException e) {
			System.out.println("[에러] selectIdMember 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return member;
	}

	// 3. 회원 객체를 매개변수로 받아 삽입 메소드!
	public int insertMember(MemberDTO member) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();

			String sql = "INSERT INTO MEMBER VALUES (?,?,?,?,?,?,?,?,2000,1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getMID());
			pstmt.setString(2, member.getMPW());
			pstmt.setString(3, member.getMNAME());
			pstmt.setString(4, member.getMADDRESS1());
			pstmt.setString(5, member.getMADDRESS2());
			pstmt.setString(6, member.getMZIP());
			pstmt.setString(7, member.getMPHONE());
			pstmt.setString(8, member.getMEMAIL());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] insertMember 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 4. 멤버 객체를 매개변수로 받아 회원 정보 수정 메소드!
	public int updateMember(MemberDTO member) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();

			String sql = "UPDATE MEMBER SET MPW = ?, MNAME = ?, MADDRESS1 = ?, MADDRESS2 = ?, MZIP = ?,"
					+ "MPHONE = ?, MEMAIL = ? WHERE MID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getMPW());
			pstmt.setString(2, member.getMNAME());
			pstmt.setString(3, member.getMADDRESS1());
			pstmt.setString(4, member.getMADDRESS2());
			pstmt.setString(5, member.getMZIP());
			pstmt.setString(6, member.getMPHONE());
			pstmt.setString(7, member.getMEMAIL());
			pstmt.setString(8, member.getMID());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] updateMember 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 5. 아이디와 상태를 전달받아 해당 아이디의 회원 상태를 변경하는 메소드!
	public int updateStatus(int grade, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();

			String sql = "UPDATE MEMBER SET MGRADE = ? WHERE MID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, grade);
			pstmt.setString(2, id);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] updateState 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 6. 아이디를 전달받아 회원 정보를 삭제하는 메소드!
	public int deleteMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "UPDATE MEMBER SET MGRADE = 0 WHERE MID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] deleteMember 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 7. 회원 총 레코드 수 반환하는 메소드!
	public int selectMemberCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();

			String sql = "SELECT COUNT(*) FROM MEMBER";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectMemberCount 부분 오류" + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}

	// 8. 휴대폰번호로 아이디 찾기
	public String findId_phone(String mname, String mphone) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String mid = null;
		try {
			con = getConnection();

			String sql = "SELECT MID FROM MEMBER WHERE MNAME=? AND MPHONE=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mname);
			pstmt.setString(2, mphone);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				mid = rs.getString("MID");
			}
		} catch (SQLException e) {
			System.out.println("[에러]findId_phone 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return mid;
	}

	// 9.이메일주소로 아이디 찾기
	public String findId_email(String mname, String memail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String mid = null;
		try {
			con = getConnection();

			String sql = "SELECT MID FROM MEMBER WHERE MNAME=? AND MEMAIL=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mname);
			pstmt.setString(2, memail);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				mid = rs.getString("MID");
			}
		} catch (SQLException e) {
			System.out.println("[에러]findUserId2() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return mid;
	}

	// 10.아이디를 비교하여 새로운 비밀번호로 변경하는 메소드
	public int resetPassword(String mpw, String mid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();

			String sql = "UPDATE MEMBER SET MPW = ? WHERE MID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mpw);
			pstmt.setString(2, mid);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] resetPassword 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 11. 적립금 변경하는 메소드
	public int updateReserves(int reserves, MemberDTO member) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();
			String sql = "UPDATE MEMBER SET MRESERVES = MRESERVES - ? WHERE MID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, reserves);
			pstmt.setString(2, member.getMID());
			pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러]updateReserves() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}

		return rows;
	}

	// 12. 이름을 매개변수로 받아 멤버 객체 반환하는 메소드~!
	public MemberDTO selectNameMember(String name) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDTO member = null;

		try {
			con = getConnection();

			String sql = "SELECT * FROM MEMBER WHERE MNAME LIKE '%'||?||'%' ORDER BY MNAME DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				member = new MemberDTO();
				member.setMID(rs.getString("MID"));
				member.setMPW(rs.getString("MPW"));
				member.setMNAME(rs.getString("MNAME"));
				member.setMADDRESS1(rs.getString("MADDRESS1"));
				member.setMADDRESS2(rs.getString("MADDRESS2"));
				member.setMZIP(rs.getString("MZIP"));
				member.setMPHONE(rs.getString("MPHONE"));
				member.setMEMAIL(rs.getString("MEMAIL"));
				member.setMRESERVES(rs.getInt("MRESERVES"));
				member.setMGRADE(rs.getInt("MGRADE"));
			}

		} catch (SQLException e) {
			System.out.println("selectNameMember메소드의 SQL오류 " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}

		return member;
	}

}
