<%@page import="java.io.File"%>
<%@page import="muskycode.dao.ProductDAO"%>
<%@page import="muskycode.dto.ProductDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/muskycode/security/login_check.jspf"%>   
<%
	//비정상적인 요청에 대한 응답처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=error&musky=error400';");
		out.println("</script>");
		return;			
	}	

	//전달받은 파일을 저장하기 위한 서버 디렉토리의 시스템 경로를 반환받아 저장
	// => 작업 디렉토리(WorkSpace)가 아닌 웹 디렉토리(WebApps)의 시스템 경로 반환
	String saveDirectory=request.getServletContext().getRealPath("/muskycode/product_images");
	
	//cos 라이브러리의 MultipartRequest 클래스로 인스턴스 생성
	// => MultipartRequest 클래스 : 멀티파트 폼데이타]를 처리하기 위한 클래스
	// => MultipartRequest 인스턴스를 생성하면 모든 전달파일은 자동으로 서버 디렉토리에 저장
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	//전달값과 업로드 파일명을 반환받아 저장
	String category=multipartRequest.getParameter("category");
	String name=multipartRequest.getParameter("name");
	String image=multipartRequest.getFilesystemName("image");
	String detail=multipartRequest.getParameter("detail");
	int qty=Integer.parseInt(multipartRequest.getParameter("qty"));
	int price=Integer.parseInt(multipartRequest.getParameter("price"));
	
	//DTO 인스턴스를 생성하고 전달값과 파일명으로 필드값 변경
	ProductDTO product=new ProductDTO();
	product.setPCATEGORY(category);
	product.setPNAME(name);
	product.setPIMGURL(image);
	product.setPCONTENT(detail);
	product.setPSTOCK(qty);
	product.setPPRICE(price);
	
	//제품정보를 전달받아 PRODUCT 테이블에 삽입하여 저장하는 DAO 클래스의 메소드 호출
	int rows=ProductDAO.getDAO().insertProduct(product);
	if(rows<=0) {//PRODUCT 테이블에 삽입된 행이 없는 경우
		//업로드된 제품이미지 파일 삭제 처리
		new File(saveDirectory, image).delete();
	}
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=admin&musky=product_manage';");
	out.println("</script>");
%>










