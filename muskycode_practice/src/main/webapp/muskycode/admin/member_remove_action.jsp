<%@page import="muskycode.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@include file="/muskycode/security/admin_check.jspf"%>
    <%
    if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=error&musky=error400';");
		out.println("</script>");
		return;			
	}	

    String pageNum="1"; 
	if(request.getParameter("pageNum") != null){ 	
		pageNum = request.getParameter("pageNum");  
	}
	
    
	//체크박스에 의해 선택되어 전달된 값(아이디)들을 반환받아 저장
	// => 하나의 이름으로 여러개의 값이 전달되므로 request.getParameterValues() 메소드 사용
	String[] checkId=request.getParameterValues("checkId");
	
	//배열에 저장된 요소(아이디)를 제공받아 반복 처리 
	for(String id:checkId) {
		//아이디를 전달받아 MEMBER 테이블에 저장된 해당 아이디의 회원정보를 삭제 처리하는 DAO 클래스의 메소드 호출
		MemberDAO.getDAO().deleteMember(id);
	}
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=admin&musky=member_manage&pageNum="+pageNum+"';");
	out.println("</script>");
    %>
