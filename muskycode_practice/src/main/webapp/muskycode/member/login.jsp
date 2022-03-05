<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	if(request.getParameter("grade")!=null) {
		if(request.getParameter("grade").equals("1")) {
			session.removeAttribute("url");
		}
	}

	String id = (String)session.getAttribute("id");
	if(id==null) {
		id="";
	} else {
		session.removeAttribute("id");
	}
	
	String message = (String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
%>


<style type="text/css">

#space {
	height: 50px;
}    
.login_tag {
	margin: 5px auto;
	width: 500px;
}    

#login label {
	text-align: right;
	width: 100px;
	float: left;
}

#login ul li {
	list-style-type: none;
	margin-bottom: 10px;
}

#login input:focus {
	border: 2px solid aqua;
}

input {
	padding: 0 15px;
    width: 200px;
    height: 100px;
    line-height: 50px;
    border: none;
    font-size: 14px;
    color: #000;
    box-sizing: border-box;
    position: relative;
    right: 50px;
}

#login_btn {
	width: 200px;
	height: 32px;
}

#message {
	text-align:center;
	color: red;
}


</style>

<div class="titleArea">
    <h2>LOGIN</h2>
</div>

<div id="space"></div>
<form id="login" name="loginForm" action="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=member&musky=login_action" method="post">
	<ul class="login_tag">
		<li>
			<label for="id" >아이디 </label>
			<input type="text" name="id" id="id" value="<%=id%>">
		</li>
		<li>
			<label for="pw" >비밀번호 </label>
			<input type="password" name="passwd" id="passwd" >
		</li>
	</ul>
	<div id="login_btn" class="btn_login">로그인</div>
	<div id="search" >
		<br><br>
		<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=member&musky=find_id"><span id="id_find">아이디 찾기</span></a>  |
		<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=member&musky=find_pw"><span id="pw_find">비밀번호 찾기</span></a>  |
		<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=member&musky=join">회원가입</a> 
	</div>
	<div id="message"><%=message %></div>
</form>

<script type="text/javascript">

$("#id").focus();

$("#login_btn").click(function() {
	if($("#id").val()=="") {
		$("#message").text("아이디를 입력해 주세요.");
		$("#id").focus();
		return;
	}
	
	if($("#passwd").val()=="") {
		$("#message").text("비밀번호를 입력해 주세요.");
		$("#passwd").focus();
		return;
	}
	
	$("#login").submit();
});

$("#id").keypress(function() {
	if(event.keyCode==13) { //13=엔터
		if($("#id").val()=="") {
			$("#message").text("아이디를 입력해 주세요.");
			$("#id").focus();
			return;
		}
		
		if($("#passwd").val()=="") {
			$("#message").text("비밀번호를 입력해 주세요.");
			$("#passwd").focus();
			return;
		}
		
		$("#login").submit();
	}
});

$("#passwd").keypress(function() {
	if(event.keyCode==13) { //13=엔터
		if($("#id").val()=="") {
			$("#message").text("아이디를 입력해 주세요.");
			$("#id").focus();
			return;
		}
		
		if($("#passwd").val()=="") {
			$("#message").text("비밀번호를 입력해 주세요.");
			$("#passwd").focus();
			return;
		}
		
		$("#login").submit();
	}
});
</script>