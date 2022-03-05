<%@page import="muskycode.dao.ProductDAO"%>
<%@page import="java.io.File"%>
<%@page import="muskycode.dto.ProductDTO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 제품정보를 전달받아 PRODUCT 테이블에 저장된 제품정보를 변경하고 제품정보 출력페이지
(product_detail.jsp)로 이동하는 JSP 문서 --%>
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

	//전달받은 파일을 저장하기 위한 서버 디렉토리의 시스템 경로를 반환받아 저장
	String saveDirectory=request.getServletContext().getRealPath("/muskycode/product_images");
	
	//cos 라이브러리의 MultipartRequest 클래스로 인스턴스 생성
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	//전달값과 업로드 파일명을 반환받아 저장
	int num=Integer.parseInt(multipartRequest.getParameter("num"));
	String currentImage=multipartRequest.getParameter("currentImage");
	String category=multipartRequest.getParameter("category");
	String name=multipartRequest.getParameter("name");
	//업로드 처리된 파일이 없는 경우 NULL을 반환받아 저장
	String image=multipartRequest.getFilesystemName("image");
	String detail=multipartRequest.getParameter("detail");
	int qty=Integer.parseInt(multipartRequest.getParameter("qty"));
	int price=Integer.parseInt(multipartRequest.getParameter("price"));
	
	//DTO 인스턴스를 생성하여 전달값이나 파일명으로 필드값 변경
	ProductDTO product=new ProductDTO();
	product.setPNO(num);
	product.setPCATEGORY(category);
	product.setPNAME(name);
	if(image!=null) {//업로드된 파일이 있는 경우 - 제품이미지 변경
		product.setPIMGURL(image);
		//기존 제품이미지 파일을 서버 디렉토리에서 삭제 처리
		new File(saveDirectory, currentImage).delete();
	} else {//업로드된 파일이 없는 경우 - 제품이미지 미변경
		product.setPIMGURL(currentImage);
	}
	product.setPCONTENT(detail);
	product.setPSTOCK(qty);
	product.setPPRICE(price);

	//제품정보를 전달받아 PRODUCT 테이블에 저장된 제품정보를 변경하는 DAO 클래스의 메소드 호출
	ProductDAO.getDAO().updateProduct(product);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=admin&musky=product_detail&num="+num+"';");
	out.println("</script>");
%>








