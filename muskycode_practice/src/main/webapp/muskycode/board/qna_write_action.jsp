
<%@page import="muskycode.dto.ProductDTO"%>
<%@page import="muskycode.dao.ProductDAO"%>
<%@page import="muskycode.dto.QnaDTO"%>
<%@page import="muskycode.dao.QnaDAO"%>
<%@page import="muskycode.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 게시글(새글 또는 답글)을 전달받아 QNA 테이블에 저장하고 게시글 목록 출력페이지로 이동하는 JSP 문서 --%>  
<%-- => 로그인 사용자에게만 글쓰기 권한 제공 --%>    
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

	//전달값을 반환받아 저장
	int ref=Integer.parseInt(request.getParameter("ref"));
	int refStep=Integer.parseInt(request.getParameter("reStep"));
	int refLevel=Integer.parseInt(request.getParameter("reLevel"));
	/* String pageNum=request.getParameter("pageNum"); */
	
	//전달값에 태그 관련 기호가 있는 경우 회피문자로 변환하여 저장 - XSS 공격에 대한 방어
	String qtitle=Utility.escapeTag(request.getParameter("qtitle"));
	int QSTATUS=1;//전달값이 없는 경우(비밀글이 아닌 경우)에 게시글의 상태를 일반글로 저장 
	
	String qcontent=Utility.escapeTag(request.getParameter("qcontent"));

	//카테고리 
	String qcategory=request.getParameter("qcategory");
	
	//QNA_SEQ 시퀸스의 다음값을 검색하여 반환하는 DAO 클래스의 메소드 호출
	// => 새글 또는 답글의 글번호(num 컬럼값)로 저장
	int num=QnaDAO.getDAO().selectNextNum();
	

	QnaDAO.getDAO().UpdateCategory(num, qcategory);
	
	//새글과 답글을 구분하여 QNA 테이블의 컬럼값으로 저장될 변수값 변경
	if(ref==0) {//새글인 경우
		//새글은 REF 컬럼값으로 자동 증가값이 저장되도록 ref 변수값 변경 
		// => NUM 컬럼값과 REF 컬럼값으로 동일한 값 저장
		// => RE_STEP 컬럼(reStep 변수값)과 RE_LEVEL 컬럼(reLevel 변수값)에는 "0" 저장
		ref=num;
		QnaDAO.getDAO().UpdateCategory(num, qcategory);
	} else {//답글인 경우 - ref,reStep,reLevel 변수에 부모글의 전달값이 저장
		//부모글의 전달값을 이용하여 QNA 테이블에 저장된 게시글의 RE_STEP 컬럼값을 
		//변경하는 DAO 클래스의 메소드 호출
		// => QNA 테이블에 저장된 게시글 중 부모글에서 전달된 ref 변수값과 REF 컬럼값이
		//같고 reStep 변수값보다 RE_STEP 컬럼값이 큰 게시글의 RE_STEP 컬럼값을 1 증가되도록 변경
		// => 동일한 깊이의 기존 답글보다 위에 출력되도록 그룹 게시글 순서를 변경
		QnaDAO.getDAO().updateqRefStep(ref, refStep);
		
		
		//RE_STEP 컬럼에 저장되는 reStep 변수값과 RE_LEVEL 컬럼에 저장되는 reLevel 
		//변수값을 1증가하여 저장
		// => REF 컬럼에는 부모글에서 전달된 ref 변수값 저장
		refStep++;
		refLevel++;
		
		/* int num=Integer.parseInt(request.getParameter("num")); */
		
		QnaDAO.getDAO().UpdateAnswer(num-1);
		QnaDAO.getDAO().UpdateAnswer(num-refStep);
	}
	
	
	//DTO 인스턴스를 생성하고 필드값 변경
	
	QnaDTO qna = new QnaDTO();
	qna.setQNO(num);
	qna.setMID(loginMember.getMID());
	qna.setQTITLE(qtitle);
	qna.setQREF(ref);
	qna.setQACONTENT(qna.getQACONTENT());
	qna.setQREF_STEP(refStep);
	qna.setQREF_LEVEL(refLevel);
	qna.setQCONTENT(qcontent);
	qna.setQSTATUS(QSTATUS);
	qna.setQCATEGORY(qcategory);
	

	//게시글을 전달받아 QNA 테이블에 저장하는 DAO 클래스의 메소드 호출
	QnaDAO.getDAO().InsertQna(qna);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=board&musky=qna';");
	out.println("</script>");
%>












