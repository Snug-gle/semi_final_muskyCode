<%@page import="muskycode.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/muskycode/security/admin_check.jspf"%>

<%
//비정상적인 요청에 대한 응답처리
if (request.getParameter("pno") == null || request.getParameter("status") == null) {
	System.out.print(request.getParameter("pno") + request.getParameter("status"));
	out.println("<script type='text/javascript'>");
	out.println("location.href='" + request.getContextPath() + "/muskycode/index.jsp?workgroup=error&work=error400';");
	out.println("</script>");
	return;
}
	String pageNum="1"; 
	if(request.getParameter("pageNum") != null){ 	
		pageNum = request.getParameter("pageNum");  
	}
	
	//전달값을 반환받아 저장
	int pno = Integer.parseInt(request.getParameter("pno"));
	int status = Integer.parseInt(request.getParameter("status"));
	
	//아이디와 상태를 전달받아 MEMBER 테이블에 저장된 해당 아이디의 회원상태를 변경하는 DAO 클래스의 메소드 호출
	ProductDAO.getDAO().updateStatusProduct(pno, status);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='" + request.getContextPath() + "/muskycode/index.jsp?muskygroup=admin&musky=product_manage&pageNum="+pageNum+"';");
	out.println("</script>");
%>
	