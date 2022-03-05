<%@page import="java.nio.channels.MembershipKey"%>
<%@page import="muskycode.dao.MemberDAO"%>
<%@page import="muskycode.dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="/muskycode/security/admin_check.jspf"%>

<%
//페이지 번호 반환받아 저장
int pageNum = 1; // 전달값 없으면 1페이지
if (request.getParameter("pageNum") != null) { // 전달값이 있는 경우 해당 페이지 
	pageNum = Integer.parseInt(request.getParameter("pageNum"));
}
	
//하나의 페이지에 출력될 게시글 갯수 설정
int pageSize = 10;

//테이블 전체 회원 수 반환
int totalMember = MemberDAO.getDAO().selectMemberCount();
System.out.print(totalMember);
//페이지 갯수 계산
int totalPage = (int) Math.ceil((double) totalMember / pageSize);

//전달된 페이지 번호에 검증
if (pageNum <= 0 || pageNum > totalPage) { // 페이지 번호가 잘못되면 1페이지로 이동
	pageNum = 1;
}

//페이지 시작행번호
int startRow = (pageNum - 1) * pageSize + 1;

//페이지 종료 행번호
int endRow = pageNum * pageSize;

//페이지 종료 행번호 게시글 갯수로 변경
if (endRow > totalMember) {
	endRow = totalMember;
}

//게시글 시작 글번호 
int number = totalMember - (pageNum - 1) * pageSize;

List<MemberDTO> memberList = MemberDAO.getDAO().selectMemberList(startRow, endRow);

%>

<hr class="layout"/>

<div id="board_list" class="titleArea" >
		<div id="board_title"><h2 style="color: blue;">MEMBER MANAGE</h2></div>
</div>
<form name="memberForm" id="memberForm">
<div class="ec-base-table typeList gBorder">
		 <table border="1" summary="" style="width: 1300px; position: relative; left:6%; top:10px;">
			<thead class="xans-element- xans-board xans-board-listheader-1002 xans-board-listheader xans-board-1002 ">
				<tr style=" ">
					<th><input type="checkbox" id="allCheck"></th>
					<th>번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>주소</th>
					<th>상태</th>
		</tr></thead>
		<tbody class="xans-element- xans-board xans-board-list-1002 xans-board-list xans-board-1002 center">
			<% if(memberList.isEmpty()) { %>
			<tr>
				<td colspan="8">회원이 없습니다.</td>
			</tr>
			<% } else { %>
			<% for (MemberDTO member : memberList) { %>
			<tr>
				<td class="member_check">
					<% if (member.getMGRADE() == 9) {//관리자인 경우 %> 관리자 
					<% } else {%> 
					<input type="checkbox" name="checkId" value="<%=member.getMID()%>"
					class="check"> 
					<% } %>
				</td>
				<td><%=number %></td>
				<td class="member_id"><%=member.getMID()%></td>
				<td class="member_name"><%=member.getMNAME()%></td>
				<td class="member_email"><%=member.getMEMAIL()%></td>
				<td class="member_phone"><%=member.getMPHONE()%></td>
				<td class="member_address">[<%=member.getMZIP()%>]<%=member.getMADDRESS1() %>
					<%=member.getMADDRESS2() %>
				</td>
				<td class="member_status"><select class="status"
					name="<%=member.getMID()%>">
						<option value="0" <%if (member.getMGRADE() == 0) {%>
							selected="selected" <%}%>>삭제회원</option>
						<option value="1" <%if (member.getMGRADE() == 1) {%>
							selected="selected" <%}%>>일반회원</option>
						<option value="9" <%if (member.getMGRADE() == 9) {%>
							selected="selected" <%}%>>관리자</option>
				</select></td>
			</tr>
			<% number--;%>
			<% } %>
			<% } %>
		</tbody>
	</table>
	<br><br>
	<p>
		<button type="button" id="removeBtn" class="btn_black">선택회원삭제</button>
	</p>
	<div id="message" style="color: red;"></div>
	</div>
</form>

<%
	//페이지 블럭에 출력될 페이지의 갯수 설정
	int blockSize = 5;

	//페이지 블럭에 출력될 시작 페이지 번호를 계산하여 저장
	//ex) 1Block : 1, 2Block : 6, 3Block : 11, 4Block : 16,...
	int startPage = (pageNum - 1) / blockSize * blockSize + 1;

	//페이지 블럭에 출력될 종료 페이지 번호를 계산하여 저장
	//ex) 1Block : 5, 2Block : 10, 3Block : 15, 4Block : 20,...
	int endPage = startPage + blockSize - 1;

	//마지막 페이지 블럭의 종료 페이지 번호 변경
	if (endPage > totalPage) {
		endPage = totalPage;
	}
%>
<br><br>
<%if (startPage > blockSize) {//시작 페이지 번호가 blockSize 변수값을 초과한 경우 링크 설정%>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=member_manage&pageNum=1">[처음]</a>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=member_manage&pageNum=<%=startPage - blockSize%>">[이전]</a>
	<% } else {//시작 페이지 번호가 blockSize 변수값을 초과하지 않을 경우 링크 미설정 %>
	[처음][이전]
	<% } %>

	<%for (int i = startPage; i <= endPage; i++) {%>
	<%if (pageNum != i) {//요청 페이지 번호와 출력 페이지 번호가 같지 않은 경우 링크 설정 %>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=member_manage&pageNum=<%=i%>">[<%=i%>]
	</a>
	<% } else {//요청 페이지 번호와 출력 페이지 번호가 같을 경우 링크 미설정%>
	[<%=i%>]
	<% } %>
	<% } %>

	<% if (endPage != totalPage) {//종료 페이지 번호와 전체 페이지 갯수가 같지 않은 경우 링크 설정 %>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=member_manage&pageNum=<%=startPage + blockSize%>">[다음]</a>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=member_manage&pageNum=<%=totalPage%>">[마지막]</a>
	<% } else {//종료 페이지 번호와 전체 페이지 갯수가 같은 경우 링크 미설정 %>
	[다음][마지막]
	<% } %>
	
<script type="text/javascript">
$("#allCheck").change(function() {
	if($(this).is(":checked")) {
		$(".check").prop("checked",true);
	} else {
		$(".check").prop("checked",false);
	}
});

$("#removeBtn").click(function() {
	if($(".check").filter(":checked").length==0) {
		$("#message").text("선택된 회원이 하나도 없습니다.");
		return;
	}
	
	$("#memberForm").attr("method", "post");
	$("#memberForm").attr("action", "<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=member_remove_action");
	$("#memberForm").submit();
});

$(".status").change(function() {
	//이벤트가 발생된 엘리먼트의 속성값을 반환받아 저장	
	var id=$(this).attr("name");//식별자 >> 아이디
	//이벤트가 발생된 엘리먼트의 입력값을 반환받아 저장	
	var status=$(this).val();//입력값 >> 회원상태
	//alert(id+" = "+status);
	
	location.href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=member_status_action&id="+id+"&status="+status;
});
</script>