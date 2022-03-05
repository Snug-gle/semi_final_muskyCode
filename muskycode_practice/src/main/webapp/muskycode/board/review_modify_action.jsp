<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="muskycode.dao.ReviewDAO"%>
<%@page import="muskycode.dto.ReviewDTO"%>
<%@page import="muskycode.dao.QnaDAO"%>
<%@page import="muskycode.dto.QnaDTO"%>
<%@page import="muskycode.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 게시글(변경글)을 전달받아 REVIEW 테이블에 저장된 게시글을 변경하고 게시글 출력페이지
(REVIEW_detail.jsp)로 이동하는 JSP 문서 --%> 
<%-- => 비로그인 사용자이거나 게시글 작성자 또는 관리자가 아닌 경우 에러 페이지 이동 --%>
<%@include file="/muskycode/security/login_check.jspf"%>
<%
//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=error&musky=error400';");
		out.println("</script>");
		return;
	}

	//전달받은 파일을 저장하기 위한 서버 디렉토리의 시스템 경로를 반환받아 저장
	String saveDirectory=request.getServletContext().getRealPath("/muskycode/board/review_images");
	
	//cos 라이브러리의 MultipartRequest 클래스로 인스턴스 생성
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());

	//전달값을 반환받아 저장
	int num=Integer.parseInt(multipartRequest.getParameter("num"));
	String pageNum=multipartRequest.getParameter("pageNum");
	String search=multipartRequest.getParameter("search");
	String keyword=multipartRequest.getParameter("keyword");
	String rtitle=Utility.escapeTag(multipartRequest.getParameter("rtitle"));
	String rimg = multipartRequest.getFilesystemName("rimage");
	System.out.print("rimg = " +rimg);
	int status=1;//전달값이 없는 경우(비밀글이 아닌 경우)에 게시글의 상태를 일반글로 저장 
	String rcontent=Utility.escapeTag(multipartRequest.getParameter("rcontent"));
	
	//DTO 인스턴스를 생성하고 필드값 변경
	
			ReviewDTO review = new ReviewDTO();
	
			review.setRNO(num);
			review.setRTITLE(rtitle);
			review.setRCONTENT(rcontent);
			review.setRIMGURL(rimg);
			review.setRSTATUS(status); 
		
	
	//게시글을 전달받아 REVIEW 테이블에 저장된 게시글을 변경하는 DAO 클래스의 메소드 호출
	ReviewDAO.getDAO().UpdateReview(review);
	
	//페이지 이동
		 out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()
			+"/muskycode/index.jsp?muskygroup=board&musky=review_detail&num="+num
			+"&pageNum="+pageNum+"&search="+search+"&keyword="+keyword+"';");
		out.println("</script>");  
%>  




