<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그아웃 처리 - 세션에 저장된 권한 관련 정보를 제거
	//session.invalidate();
	session.removeAttribute("loginMember");
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp';");
	out.println("</script>");

%>
    