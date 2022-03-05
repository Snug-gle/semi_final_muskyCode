<%@page import="muskycode.dto.NoticeDTO"%>
<%@page import="muskycode.dao.NoticeDAO"%>
<%@page import="muskycode.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/muskycode/security/login_check.jspf" %>

<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=error&musky=error400';");
		out.println("</script>");
		return;
	}
//String pageNum="1";
	String pageNum = request.getParameter("pageNum");
	System.out.print(pageNum);
	
	//전달값에 태그 관련 기호가 있는 경우 회피문자로 변환하여 저장 - XSS 공격에 대한 방어
	String subject=Utility.escapeTag(request.getParameter("subject"));
	String content=Utility.escapeTag(request.getParameter("content"));
	
	//SEQ_NOTICE 시퀸스의 다음값을 검색하여 반환하는 DAO 클래스의 메소드 호출
	// => 새글 또는 답글의 글번호(num 컬럼값)로 저장
	int num=NoticeDAO.getDAO().selectNextNo();
	System.out.print(num);
	NoticeDTO notice = new NoticeDTO();
	notice.setNNO(num);
	notice.setNTITLE(subject);
	notice.setNCONTENT(content);
	
	//게시글을 전달받아 NOTICE 테이블에 저장하는 DAO 클래스의 메소드 호출
	NoticeDAO.getDAO().InsertNotice(notice);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=admin&musky=notice_manage&pageNum="+pageNum+"';");
	out.println("</script>");
	
	
%>