<%@page import="muskycode.dao.OrderDAO"%>
<%@page import="muskycode.dto.OrderDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 그룹정보를 전달받아 ORDER 테이블에 저장된 제품정보를 변경하고 제품정보 출력페이지
(ORDER_detail.jsp)로 이동하는 JSP 문서 --%>
<%-- => 관리자만 JSP 문서를 요청하여 처리되도록 권한 설정 --%>
<%@include file="/muskycode/security/admin_check.jspf"%>  

<%
	//비정상적인 요청에 대한 응답처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=error&musky=error400';");
		out.println("</script>");
		return;			
	}	
	
	// 배송 상태 받기
	int orderStatus = Integer.parseInt(request.getParameter("orderStatus"));
	
	// 전화 번호 받기
	String phone = request.getParameter("mobile1")+"-"+request.getParameter("mobile2")+"-"+request.getParameter("mobile3");

	// 우편 번호 받기
	String zipCode = request.getParameter("zipcode");
	
	// 배송 주소 받기
	String address1 = request.getParameter("address1");
	
	// 상세 주소 받기
	String address2 = request.getParameter("address2");

	// 주문 그룹 받기
	int orderGroup = Integer.parseInt(request.getParameter("orderGroupNo"));
	
	// 주문 번호 받기
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));

	OrderDTO order = new OrderDTO();
	
	order.setOSTATUS(orderStatus);
	order.setOPHONE(phone);
	order.setOZIP(zipCode);
	order.setOADDRESS1(address1);
	order.setOADDRESS2(address2);
	order.setOGROUP(orderGroup);
	
	// 수정 주문 정보 전달받아 같은 주문 그룹의 데이터들을 수정
	OrderDAO.getDAO().updateOrderAdmin(order);
	
	//페이지 이동
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=admin&musky=order_detail&orderGroupNo="+orderGroup+"&orderNo="+orderNo+"';");
		out.println("</script>");
	%>
%>
