     
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="muskycode.dto.ReviewDTO"%>
<%@page import="muskycode.dao.ReviewDAO"%>
<%@page import="muskycode.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 게시글(새글 또는 답글)을 전달받아 REVIEW 테이블에 저장하고 게시글 목록 출력페이지 로 이동하는 JSP 문서 --%>     
<%-- => 비로그인 사용자가 JSP 문서를 요청한 경우 에러페이지로 이동 --%>
<%@include file="/muskycode/security/login_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/musky/index.jsp?muskygroup=error&musky=error400';");
		out.println("</script>");
		return;
	}

 	//전달값에 태그 관련 기호가 있는 경우 회피문자로 변환하여 저장 - XSS 공격에 대한 방어
	String rtitle=request.getParameter("rtitle");
	
 	
 	String rcontent=request.getParameter("rcontent");
	
	//전달받은 파일을 저장하기 위한 서버 디렉토리의 시스템 경로를 반환받아 저장
	String saveDirectory=request.getServletContext().getRealPath("/muskycode/board/review_images");
	
	//cos 라이브러리의 MultipartRequest 클래스로 인스턴스 생성
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 1024*1024*30, "utf-8", new DefaultFileRenamePolicy());

	// 상품명 받아오는 메소드
 	String pname = multipartRequest.getParameter("pname");

 	//REVIEW_SEQ 시퀸스의 다음값을 검색하여 반환하는 DAO 클래스의 메소드 호출
	// => 새글 또는 답글의 글번호(num 컬럼값)로 저장
	int num=ReviewDAO.getDAO().selectNextNum();

	//DTO 인스턴스를 생성하고 필드값 변경
	ReviewDTO review = new ReviewDTO();
	review.setRNO(num);
	review.setMID(loginMember.getMID());
	review.setRTITLE(multipartRequest.getParameter("rtitle"));
	review.setRCONTENT(multipartRequest.getParameter("rcontent"));
	review.setRIMGURL(multipartRequest.getFilesystemName("rimage"));

	//게시글을 전달받아 REVIEW 테이블에 저장하는 DAO 클래스의 메소드 호출
	int rows = ReviewDAO.getDAO().InsertReview(review);
	if(rows <= 0){//Review 테이블에 삽입된 행이 없는 경우
		//업로드된 제품이미지 파일 삭제 처리
		new File(saveDirectory, multipartRequest.getParameter("rimage")).delete();
	}
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=board&musky=review&pname="+pname+"';");
	out.println("</script>");
%>












