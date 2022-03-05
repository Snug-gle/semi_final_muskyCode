
<%@page import="muskycode.dto.MemberDTO"%>
<%@page import="muskycode.dao.QnaDAO"%>
<%@page import="muskycode.dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/muskycode/security/admin_check.jspf"%>
<%-- 글번호를 전달받아 BOARD 테이블에 저장된 해당 글번호의 게시글을 검색하여 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => [글삭제]를 클릭한 경우 게시글 삭제페이지(board_remove_action.jsp)로 이동 - 글번호 전달 --%>    
<%-- => [글변경]를 클릭한 경우 게시글 변경값 입력페이지(board_modify.jsp)로 이동 - 글번호 전달 --%>    
<%-- => [답글쓰기]를 클릭한 경우 게시글 입력페이지(board_write.jsp)로 이동 - 부모글 관련 정보 전달 --%>    
<%-- => [글목록]를 클릭한 경우 게시글 목록 출력페이지(board_list.jsp)로 이동 - 검색 관련 정보 전달 --%>    
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
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	//글번호를 전달받아 BOARD 테이블에 저장된 해당 글번호의 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	QnaDTO qna=QnaDAO.getDAO().selectNumQna(num);
 	//검색된 게시글이 없거나 삭제글인 경우 => 비정상적인 요청에 대한 응답 처리
 	 if(qna==null || qna.getQSTATUS()==0) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='" + request.getContextPath() + "/muskycode/index.jsp?muskygroup=error&musky=error400';");
		out.println("</script>");
		return;	
	}  
	//글번호를 전달받아 BOARD 테이블에 저장된 해당 글번호의 게시글에 조회수를 증가하는 DAO 클래스의 메소드 호출
	QnaDAO.getDAO().updateQhit(num);
%> 
<hr class="layout"/>

	<div class="titleArea" >
		<h2>Q&A</h2>
	</div>

<div id="container" style="position: relative; bottom:100px; width: 1000px;">
	<div id="container_sub">
		<form id="BoardDelForm" name="" action="/exec/front/Board/del/1"
			method="post" target="_self" enctype="multipart/form-data">
			<div class="xans-element- xans-board xans-board-read-1002 xans-board-read xans-board-1002">
				<div class="ec-base-table typeWrite ">
					<table border="1" summary="">
						<caption>게시판 상세</caption>
						<colgroup>
							<col style="width: 130px;" />
							<col style="width: auto;" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">제목</th>
								<td style="text-align: left; text-indent: 20px;"><%=qna.getQTITLE() %>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<strong style="text-align: right;">작성일</strong>&nbsp;<%=qna.getQDATE()%>&nbsp;&nbsp;&nbsp;&nbsp;
										<strong>조회수</strong>&nbsp;<%=qna.getQHIT()+1 %>
								</td>
							</tr>
							<tr>
								<th scope="row">작성자</th>
								<td  style="text-align: left; text-indent: 20px;"><%=qna.getMID()%></td>
							</tr>
							<tr>
								<th scope="row" style="line-height: 50%;">내용</th>
								<td>
									<div class="detail">
										<div class="fr-view fr-view-article">
											<p style="margin: 0px; padding: 0px; box-sizing: border-box; font-family: NanumSquare, sans-serif; letter-spacing: -0.5px; display: block; line-height: 1.5; color: rgb(51, 51, 51); font-size: 15px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; orphans: 2; text-align: start; text-indent: 20px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
												<span style="font-size: 12px;"><%=qna.getQCONTENT().replace("\n", "<br>") %></span>
											</p>
										</div>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>

			</div>
		</form>
	</div>
	<br><br>
	<div id="qna_menu">
		<%-- 로그인 사용자가 게시글 작성자이거나 관리자인 경우에만 글삭제와 글변경 권한 제공 --%>
		<% if(loginMember!=null && (loginMember.getMID().equals(qna.getMID()) 
				||loginMember.getMGRADE()==9)) { %>
			<button type="button" id="removeBtn" class="btn_black">글삭제</button>
			<button type="button" id="modifyBtn" class="btn_black">글변경</button>
		<% } %>
		<% if(loginMember!=null) {//로그인 사용자인 경우에만 답글쓰기 권한 제공 %>
			<button type="button" id="replyBtn" class="btn_black">답글쓰기</button>
		<% } %>
		<button type="button" id="listBtn" class="btn_black">글목록</button>
	</div>
	
	<form id="boardForm" method="post">
		<%-- [글삭제]와 [글변경]을 클릭한 경우 요청 JSP 문서에 전달되는 값 --%>
		<input type="hidden" name="num" value="<%=qna.getQNO()%>">
		
		<%-- [답글쓰기]를 클릭한 경우 요청 JSP 문서에 전달되는 값 --%>
		<input type="hidden" name="ref" value="<%=qna.getQREF()%>">
		<input type="hidden" name="reStep" value="<%=qna.getQREF_STEP()%>">
		<input type="hidden" name="reLevel" value="<%=qna.getQREF_LEVEL()%>">
		<input type="hidden" name="qcategory" value="<%=qna.getQCATEGORY()%>">
		
		<%-- [글목록]을 클릭한 경우 요청 JSP 문서에 전달되는 값 --%>
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="search" value="<%=search%>">
		<input type="hidden" name="keyword" value="<%=keyword%>">
	</form>
</div>

<script type="text/javascript">
$("#removeBtn").click(function() {
	if(confirm("게시글을 삭제 하시겠습니까?")) {
		$("#boardForm").attr("action", "<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=qna_remove_action");
		$("#boardForm").submit();
	}
});

$("#modifyBtn").click(function() {
	$("#boardForm").attr("action", "<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=qna_modify");
	$("#boardForm").submit();
});

$("#replyBtn").click(function() {
	$("#boardForm").attr("action", "<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=qna_write");
	$("#boardForm").submit();
});

$("#listBtn").click(function() {
	$("#boardForm").attr("action", "<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=qna_manage");
	$("#boardForm").submit();
});
</script>

