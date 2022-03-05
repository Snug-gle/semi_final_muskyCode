<%@page import="muskycode.dao.MemberDAO"%>
<%@page import="muskycode.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- => 비로그인 사용자가 JSP 문서를 요청한 경우 에러페이지로 이동 --%>
<%@include file="/muskycode/security/login_check.jspf" %>

<%
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=error&musky=error400';");
		out.println("</script>");
	
		return;
	}
	
	//전달값을 반환받아 저장
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String mobile = request.getParameter("mobile1")+"-"+request.getParameter("mobile2")+"-"+request.getParameter("mobile3");
	String zipcode = request.getParameter("zipcode");
	String address1 = request.getParameter("address1");
	String address2 = Utility.stripTag(request.getParameter("address2"));
	
	
	//DTO인스턴스를 생성하고 전달값으로 필드값 변경
	MemberDTO member = new MemberDTO();
	
	member.setMID(id);
	member.setMPW(passwd);
	member.setMNAME(name);
	member.setMADDRESS1(address1);
	member.setMADDRESS2(address2);
	member.setMZIP(zipcode);
	member.setMPHONE(mobile);
	member.setMEMAIL(email);
	
	
	MemberDAO.getDAO().updateMember(member);
	

%>

	
	<h2>정보가 성공적으로 수정되었습니다.</h2>
	
	
<%
	session.removeAttribute("loginMember");
%>

	<input type="button" class="btn_black" value="로그인" id="mainBtn" onclick="location.href='<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=member&musky=login';">
