<%@page import="muskycode.util.Utility"%>
<%@page import="muskycode.dao.MemberDAO"%>
<%@page import="muskycode.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskcode/index.jsp?muskygroup=error&musky=error400';");
		out.println("</script>");
		return;
	} 

	String mid=request.getParameter("mid");
	//비밀번호는 암호화하여 mpw변수에 담기
	String mpw=Utility.encrypt(request.getParameter("passwd"));
	
	
	MemberDTO member = new MemberDTO();
	
	member.setMPW(mpw);
	member.setMID(mid);
	
	//아이디를 입력받아 새로운 비밀번호로 변경하는 메소드 호출
	MemberDAO.getDAO().resetPassword(mpw, mid);
%>

<style type="text/css">
.notFind {
	position: absolute;
	width: 100%;
	top: 20%;
}
</style>

   	<hr width='300px;'><br>
	<h2>비밀번호가 성공적으로 변경되었습니다</h2><br>
	<hr width='300px;'><br>
	<input type="button" class="btn_black" value="로그인" id="loginBtn" onclick="location.href='<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=member&musky=login';">
	<input type="button" class="btn_black" value="메인으로" id="mainBtn" onclick="location.href='<%=request.getContextPath()%>/muskycode/index.jsp';">
   