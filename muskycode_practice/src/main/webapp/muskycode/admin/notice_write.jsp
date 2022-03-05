<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/muskycode/security/login_check.jspf" %>

<%
 	String pageNum="1"; 
	if(request.getParameter("pageNum") != null){ 	
		pageNum = request.getParameter("pageNum");  
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
	<h2>NOTICE 작성</h2>
	</div>
	
<div id="AllForm">
	<form action="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=notice_write_action"
		method="post" id = "noticeForm">
			<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<table>
			<tr>
				<th>제목</th>
					<td>
						<input type="text" name = "subject" id = "subject" size = "40">
					</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows = "7" cols="60" name="content" id="notice_content"></textarea>
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<br><br>
					<button type="submit" class="btn_black">글저장</button>
					<button type="reset" id="resetBtn" class="btn_black">다시쓰기</button>
				</th>
			</tr>
		</table>
	</form>
</div>

<div id = "message" style = "color : blue;"></div>

<script type="text/javascript">
$("#subject").focus();

$("#noticeForm").submit(function() {
	if($("#subject").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#subject").focus();
		return false;
	}
	
	if($("#notice_content").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#notice_content").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#subject").focus();
	$("#message").text("");	
});
</script>
