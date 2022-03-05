<%@page import="muskycode.dto.ReviewDTO"%>
<%@page import="muskycode.dao.ReviewDAO"%>
<%@page import="muskycode.dao.QnaDAO"%>
<%@page import="muskycode.dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 글번호를 전달받아 REVIEW 테이블에 저장된 해당 글번호의 게시글을 검색하여 입력태그의 초기값으로 
설정하고 변경값을 입력받기 위한 JSP 문서 --%>
<%-- => 비로그인 사용자이거나 게시글 작성자 또는 관리자가 아닌 경우 에러 페이지 이동 --%>
<%-- => [글변경]을 클릭한 경우 게시글 변경페이지(REVIEW_modify_action.jsp)로 이동 - 변경값 전달 --%>    
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
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	//글번호를 전달받아 BOARD 테이블에 저장된 해당 글번호의 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
		ReviewDTO review=ReviewDAO.getDAO().selectNumReview(num);
	
	//검색된 게시글이 없거나 삭제글인 경우 => 비정상적인 요청에 대한 응답 처리
 	 if(review==null || review.getRSTATUS()==0) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='" + request.getContextPath() + "/muskycode/index.jsp?muskygroup=error&musky=error400';");
		out.println("</script>");
		return;	
	}   
	
	//로그인 사용자가 게시글 작성자가 아니거나 관리자가 아닌 경우 => 비정상적인 요청에 대한 응답 처리 
 	if(!loginMember.getMID().equals(review.getMID()) && loginMember.getMGRADE()!=9) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=error&musky=error400';");
		out.println("</script>");
		return;	
	} 
%>
<style type="text/css">
table {
	width: 350px;
	height: 350px;
	display: inline;
	margin-bottom: 40px;
}

th {
	width: 70px;
	margin: 5px;
	font-weight: normal;
}

td {
	text-align: left;
}

#AllForm{
	width: 100%;
}
</style>

<hr class="layout"/>

	<div class="titleArea" >
	<h2>REVIEW 수정</h2>
	</div>
<div id="AllForm">	
	<form action="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=board&musky=review_modify_action"
		method="post" id="boardForm" enctype="multipart/form-data">
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="search" value="<%=search%>">
		<input type="hidden" name="keyword" value="<%=keyword%>">
		<table>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="rtitle" id="subject" size="40" value="<%=review.getRTITLE()%>">
				</td>
			</tr>
			<tr>
				<th>이미지</th>
				 <td><img src="<%=request.getContextPath()%>/muskycode/board/review_images/<%=review.getRIMGURL()%>" width="200">
					 <br> 
					 <span style="color: red;">이미지를 변경하지 않을 경우 입력하지 마세요.</span> 
					<input type="file" name="rimage" id="rimage">
				</td> 
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="7" cols="60" name="rcontent" id="board_content"><%=review.getRCONTENT() %></textarea>
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<br><br>
					<button type="submit" class="btn_black">글변경</button>
					<button type="reset" id="resetBtn" class="btn_black">다시쓰기</button>
				</th>
			</tr>
		</table>
	</form>
</div>
<div id="message" style="color: red;"></div>

<script type="text/javascript">
$("#subject").focus();

$("#boardForm").submit(function() {
	if($("#subject").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#subject").focus();
		return false;
	}
	
	if($("#board_content").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#board_content").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#subject").focus();
	$("#message").text("");	
});
</script>
