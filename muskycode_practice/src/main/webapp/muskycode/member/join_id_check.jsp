<%@page import="muskycode.dao.MemberDAO"%>
<%@page import="muskycode.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(request.getParameter("id")==null) { //전달값이 없는 경우
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}

	String id = request.getParameter("id");
	
	
	//아이디를 전달하여 MEMBER테이블에 저장된 해당 아이디의 회원정보를 반환
	MemberDTO member = MemberDAO.getDAO().selectIdMember(id);
%>

<script src="<%=request.getContextPath()%>/muskycode/design/swiper.min.js"></script>
<script src="<%=request.getContextPath()%>/muskycode/design/jquery-1.11.2.min.js"></script>
<script src="<%=request.getContextPath()%>/muskycode/design/jquery.bpopup-0.10.0.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/muskycode/design/cid.generatecade.js?vs=a8107c4e63cb45f5d57f4101a2b2ef0e"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/muskycode/design/wcslog.js"></script>

<style type="text/css">
div {
	text-align: center;
	margin: 10px;
}

.id { 
	color : red;
	font-weight: bold;
}

.btn_black:hover {
	background: black;
	color: white;
}
</style>

	<% if(member==null) {  %> 
		<div>입력한 <span class="id">[<%=id %>]</span>는 사용 가능한 아이디입니다</div>
		<div>
			<br><button type="button" class="btn_black" onclick="windowClose();">아이디 사용</button>
		</div>
		
		<script type="text/javascript">
		function windowClose() {
			opener.joinForm.id.value = "<%=id%>";
			opener.joinForm.idCheckResult.value=1;
			window.close(); 
		}
		</script>
	<% } else { %>
		<div id="message">입력한 <span class="id">[<%=id %>]</span>는 이미 사용중인 아이디입니다<br>
		다른 아이디를 입력하고 [확인]버튼을 눌러주세요
		</div>
		
		<div>
			<form name="checkForm">
				<input type="text" name="id">
				<button type="button" id="btn" class="btn_black">확인</button>
			</form>
		</div>
		
		<script type="text/javascript">
		document.getElementById("btn").onclick = function() {
			var id = checkForm.id.value;
			if(id=="") {
				document.getElementById("message").innerHTML="아이디를 입력해주세요"
				document.getElementById("message").style="color:red;";
				return;
			}
			
			
			var idReg = /^[a-zA-Z]\w{5,19}$/g;
			if(!idReg.test(id)) {
				document.getElementById("message").innerHTML="아이디는 영문자로 시작되는 영문자,숫자 6~20범위의 문자로만 작성 가능합니다."
				document.getElementById("message").style="color:red;";
				return;
			}
			
			checkForm.submit();
		}
		</script>
	<% } %>
