<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/muskycode/security/admin_check.jspf"%>
<%
	//전닭밧을 저장하기 위한 변수 선언
	// => 전달값(부모글)이 없는 경우 변수에 초기값 저장
	String qRef="0",qRefStep="0", qRefLevel="0";
	String pageNum="1";
	
	//전달값(부모글)을 반환받아 저장
	if(request.getParameter("ref")!= null){
		qRef=request.getParameter("ref");
		qRefStep=request.getParameter("reStep");
		qRefLevel=request.getParameter("reLevel");
		pageNum=request.getParameter("pageNum");
		
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
		<% if(qRef.equals("0")) {//새글인 경우 %>
			<h2>새글 쓰기</h2>
		<% } else {//답글인 경우 %>
			<h2>답글 쓰기</h2>
		<% } %>
	</div>

<div id="AllForm">
	<form action="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=qna_write_action"
		method="post" id="qnaForm">
		<input type="hidden" name="ref" value="<%=qRef%>">
		<input type="hidden" name="reStep" value="<%=qRefStep%>">
		<input type="hidden" name="reLevel" value="<%=qRefLevel%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<table>
			<tr>
				<th>카테고리</th>
				<td>
						<%if (qRef.equals("0")) { %>
						<select name="qcategory">
						<option value="배송" selected="selected">&nbsp;배송&nbsp;</option>
						<option value="교환">&nbsp;교환&nbsp;</option>
						<option value="환불">&nbsp;환불&nbsp;</option>
						<option value="일반문의">&nbsp;일반문의&nbsp;</option>
						</select>
						<%} else { %>
						<select name="qcategory">
						<option value="<%=request.getParameter("qcategory") %>" selected="selected">&nbsp;<%=request.getParameter("qcategory") %>&nbsp;</option>
						</select>
						<%} %>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				 <td>
					<input type="text" name="qtitle" id="mid" size="40">
				</td> 
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="7" cols="60" name="qcontent" id="qna_content"></textarea>
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
<div id="message" style="color: red;"></div>

<script type="text/javascript">
$("#qtitle").focus();

$("#qnaForm").submit(function() {
	if($("#qtitle").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#qtitle").focus();
		return false;
	}
	
	if($("#qna_content").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#qna_content").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#subject").focus();
	$("#message").text("");	
});
</script>


