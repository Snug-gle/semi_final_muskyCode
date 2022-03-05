<%@page import="muskycode.dao.QnaDAO"%>
<%@page import="muskycode.dto.QnaDTO"%>
<%@page import="muskycode.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 게시글(변경글)을 전달받아 QNA 테이블에 저장된 게시글을 변경하고 게시글 출력페이지
(board_detail.jsp)로 이동하는 JSP 문서 --%> 
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

	//전달값을 반환받아 저장
	int num=Integer.parseInt(request.getParameter("num"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	String qtitle=Utility.escapeTag(request.getParameter("qtitle"));
	int status=1;//전달값이 없는 경우(비밀글이 아닌 경우)에 게시글의 상태를 일반글로 저장 
	String qcontent=Utility.escapeTag(request.getParameter("qcontent"));
	
	//DTO 인스턴스를 생성하고 필드값 변경
	QnaDTO qna = new QnaDTO();
	qna.setQNO(num);
	/* qna.setQCATEGORY(qcategory); */
	qna.setQTITLE(qtitle);
	qna.setQCONTENT(qcontent);
	qna.setQSTATUS(status); 
		
	
	//게시글을 전달받아 BOARD 테이블에 저장된 게시글을 변경하는 DAO 클래스의 메소드 호출
	QnaDAO.getDAO().UpdateQna(qna);
	
	//페이지 이동
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()
			+"/muskycode/index.jsp?muskygroup=board&musky=qna_detail&num="+num
			+"&pageNum="+pageNum+"&search="+search+"&keyword="+keyword+"';");
		out.println("</script>");  
%>  




