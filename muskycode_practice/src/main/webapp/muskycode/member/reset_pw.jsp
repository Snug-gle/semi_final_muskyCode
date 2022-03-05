<%@page import="muskycode.dao.MemberDAO"%>
<%@page import="muskycode.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String mid=request.getParameter("mid");
	String mname=request.getParameter("mname");
	String memail=request.getParameter("memail");
	String mphone=request.getParameter("mphone");

	
	MemberDTO member = MemberDAO.getDAO().selectIdMember(mid);

%>

<style type="text/css">
.login_tag {
	margin: 5px auto;
	width: 500px;
}    

.notFind {
	position: absolute;
	width: 100%;
	top: 20%;
}

.error {
	color: red;
}
</style>
	<% if (member == null) { //아이디가 없을 때 %>
	<h2>입력한 아이디가 존재하지 않습니다.</h2>
	<br>
	<button class="btn_black" onclick="location.href='<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=member&musky=find_pw';">돌아가기</button>
	<% } else {
			if( mid.equals(member.getMID()) && mname.equals(member.getMNAME()) && memail.equals(member.getMEMAIL()) ) { %>
				<h2>NEW PASSWORD</h2>
				<br>
				<hr width='300px;'>
				<form id="resetPwForm" action="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=member&musky=reset_pw_action" method="post">
				<div style="height: 20px;">새로운 비밀번호를 입력해주세요.</div>
				
				<ul class="login_tag">
					<li>
						<input type="hidden" name="mid" id="mid" value=<%=mid %> readonly="readonly">
						<label for="passwd" >비밀번호 </label>
						<input type="password" name="passwd" id="passwd">
						<div id="passwdMsg" class="error">비밀번호를 입력해 주세요.</div>
						<div id="passwdRegMsg" class="error">비밀번호는 영문자,숫자,특수문자가 반드시 하나이상 포함된 6~20 범위의 문자로만 작성 가능합니다.</div>
					</li>
					<li>
						<label for="repasswd" >비밀번호 확인 </label>
						<input type="password" name="repasswd" id="repasswd">
						<div id="repasswdMsg" class="error">비밀번호 확인을 입력해 주세요.</div>
						<div id="repasswdMatchMsg" class="error">비밀번호와 비밀번호 확인이 서로 맞지 않습니다.</div>
					</li>
				</ul>
				<br>
				<button type="submit" class="btn_black">확인</button> 
				</form>
				<hr width='300px;'>
			<% } else if( mid.equals(member.getMID()) && mname.equals(member.getMNAME()) && mphone.equals(member.getMPHONE()) ) { %>
				<h2>NEW PASSWORD</h2>
				<br>
				<hr width='300px;'>
				<form id="resetPwForm" action="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=member&musky=reset_pw_action" method="post">
				<div style="height: 20px;">새로운 비밀번호를 입력해주세요.</div>
				
				<ul class="login_tag">
					<li>
						<input type="hidden" name="mid" id="mid" value=<%=mid %> readonly="readonly">
						<label for="passwd" >비밀번호 </label>
						<input type="password" name="passwd" id="passwd">
						<div id="passwdMsg" class="error">비밀번호를 입력해 주세요.</div>
						<div id="passwdRegMsg" class="error">비밀번호는 영문자,숫자,특수문자가 반드시 하나이상 포함된 6~20 범위의 문자로만 작성 가능합니다.</div>
					</li>
					<li>
						<label for="repasswd" >비밀번호 확인 </label>
						<input type="password" name="repasswd" id="repasswd">
						<div id="repasswdMsg" class="error">비밀번호 확인을 입력해 주세요.</div>
						<div id="repasswdMatchMsg" class="error">비밀번호와 비밀번호 확인이 서로 맞지 않습니다.</div>
						
					</li>
				</ul>
				<br>
				<button type="submit" class="btn_black">확인</button> 
				</form>
				<hr width='300px;'>
			<% } else if(!mid.equals(member.getMID()) || !mname.equals(member.getMNAME()) || !memail.equals(member.getMEMAIL()) || !mphone.equals(member.getMPHONE())) { %>
				<div class="notFind">
					<div class="notFind">
						<hr width='300px;'><br>
						<h2>입력하신 정보의 회원이 존재하지 않습니다.</h2><br>
						<hr width='300px;'><br>
						<button class="btn_black" onclick="location.href='<%=request.getContextPath()%>/muskycode/index.jsp';">메인으로</button>
					</div>
				</div>
		<% } %>
	<% } %>

<script type="text/javascript">
$(".error").css("display","none");

$("#resetPwForm").submit( function() {
		
	var submitResult=true;
	//비밀번호 유효성 검사
	var passwdReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
	if($("#passwd").val()=="") {
		$("#passwdMsg").css("display","block");
		$("#passwdRegMsg").css("display","none");
		submitResult=false;
	} else if(!passwdReg.test($("#passwd").val())) {
		$("#passwdRegMsg").css("display","block");
		$("#passwdMsg").css("display","none");
		submitResult=false;
	}
	
	if($("#repasswd").val()=="") {
		$("#repasswdMsg").css("display","block");
		$("#repasswdMatchMsg").css("display","none");
		submitResult=false;
	} else if($("#passwd").val()!=$("#repasswd").val()) {
		$("#repasswdMatchMsg").css("display","block");
		$("#repasswdMsg").css("display","none");
		submitResult=false;
	}
	
	return submitResult;
});
</script>