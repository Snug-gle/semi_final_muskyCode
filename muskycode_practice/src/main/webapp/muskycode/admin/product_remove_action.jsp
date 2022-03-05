<%@page import="muskycode.dao.ProductDAO"%>
<%@page import="muskycode.dto.ProductDTO"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/muskycode/security/admin_check.jspf"%>     
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("num")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=error&musky=error400';");
		out.println("</script>");
		return;	
	}

	//전달값을 반환받아 저장
	int num=Integer.parseInt(request.getParameter("num"));
	
	//제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품번호의 제품정보를 검색하여
	//반환하는 DAO 클래스의 메소드 호출
	ProductDTO product=ProductDAO.getDAO().selectNumProduct(num);
	
	//제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품번호의 제품정보를 삭제하는 DAO 클래스의 메소드 호출
	ProductDAO.getDAO().updateStatusProduct(num, 0);	
	//삭제 처리된 제품에 대한 이미지 파일을 서버 디렉토리에서 삭제
	String saveDirectory=request.getServletContext().getRealPath("/muskycode/product_images");
	new File(saveDirectory, product.getPIMGURL()).delete();

	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=admin&musky=product_manage';");
	out.println("</script>");
%>









