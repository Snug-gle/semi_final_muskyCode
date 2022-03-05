
<%@page import="muskycode.dao.QnaDAO"%>
<%@page import="muskycode.dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 글번호를 전달받아 QNA 테이블에 저장된 해당 글번호의 게시글을 삭제하고 게시글
목록 출력페이지(board_list.jsp)로 이동하는 JSP 문서 --%>
<%-- => 비로그인 사용자이거나 게시글 작성자 또는 관리자가 아닌 경우 에러 페이지 이동 --%>
<%@include file="/muskycode/security/login_check.jspf"%>
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
	
	//글번호를 전달받아 QNA 테이블에 저장된 해당 글번호의 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	QnaDTO qna=QnaDAO.getDAO().selectNumQna(num);
	
	//검색된 게시글이 없거나 삭제글인 경우 => 비정상적인 요청에 대한 응답 처리
	//검색된 게시글이 없거나 삭제글인 경우 => 비정상적인 요청에 대한 응답 처리
 	 if(qna==null || qna.getQSTATUS()==0) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='" + request.getContextPath() + "/muskycode/index.jsp?muskygroup=error&musky=error400';");
		out.println("</script>");
		return;	
	}   
	
	
	//로그인 사용자가 게시글 작성자가 아니거나 관리자가 아닌 경우 => 비정상적인 요청에 대한 응답 처리 
 	if(!loginMember.getMID().equals(qna.getMID()) && loginMember.getMGRADE()!=9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=error&musky=error400';");
		out.println("</script>");
		return;	
	} 
	
	//글번호를 전달받아 QNA 테이블에 저장된 해당 글번호의 게시글을 삭제 처리하는 DAO 클래스의 메소드 호출
	QnaDAO.getDAO().DeleteQna(num);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=board&musky=qna';");
	out.println("</script>");
%>

