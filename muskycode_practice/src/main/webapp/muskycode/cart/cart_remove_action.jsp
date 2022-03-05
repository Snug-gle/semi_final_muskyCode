<%@page import="muskycode.dao.CartDAO"%>
<%@page import="muskycode.dao.MemberDAO"%>
<%@page import="muskycode.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/muskycode/security/login_check.jspf"%>

<% 
	/* if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=error&musky=error400';");
		out.println("</script>");
		return;
	} */

	int status=0;
	if(request.getParameter("status")!=null && request.getParameter("status")!="") {
		status= Integer.parseInt(request.getParameter("status"));
	}
	
	
	
	String mid = loginMember.getMID();
	
	if(status==1) {
		CartDAO.getDAO().deleteAllCart(mid);
	} else {
		int cno = Integer.parseInt(request.getParameter("cno"));
		
		CartDAO.getDAO().deleteCart(cno, mid);
	}
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=cart&musky=cart_list';");
	out.println("</script>");
	


%>