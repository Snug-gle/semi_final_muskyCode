<%@page import="muskycode.dao.MemberDAO"%>
<%@page import="muskycode.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- => 비로그인 사용자가 JSP 문서를 요청한 경우 에러페이지로 이동 --%>
<%@include file="/muskycode/security/login_check.jspf" %>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style type="text/css">
.tos {
	border: 1px solid black;
	margin: 50px;
	position: relative;
	float: left;
}

.tos_div{
	float: left;
	position: relative;
	left: 290px;
}

.content {
	border: 1px solid;
	border: 20px;
	overflow: scroll;
	width: 350px;
	height: 450px;
}
.tos1, .tos2 {
	display: inline-block;
}

.join_finish {
	clear: both;
}

fieldset {
	text-align: left;
	margin: 10px auto;
	width: 1100px;
}

legend {
	font-size: 1.2em;
}

#join label {
	width: 150px;
	text-align: right;
	float: left;
	margin-right: 10px;
}

#join ul li {
	list-style-type: none;
	margin: 20px 0;
}

#fs {
	text-align: center;
}

.error {
	color: red;
	position: relative;
	left: 160px;
	display: none;
}

#idCheck, #postSearch {
	font-size: 12px;
	font-weight: bold;
	cursor: pointer;
	margin-left: 10px;
	padding: 2px 10px;
	border: 1px solid black;
}

#idCheck:hover, #postSearch:hover {
	background: black;
	color: white;
}

</style>

	<br>
	<h1> MODIFY </h1>
	<fieldset>
	<br>
	<br>
	<br>
	<br>
		<div>
		<form name="joinForm" id="join" action="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=mypage&musky=my_modify_action" method="post">
		<input type="hidden" name="idCheckResult" id="idCheckResult" value="0"> 
			<span style="width: 700px;">
				<div class="join_write_form">
					<ul>
						<li>
							<input type="hidden" name="id" id="id" value="<%=loginMember.getMID()%>" >
						</li>
						<li>
							<input type="hidden" name="passwd" id="passwd" value="<%=loginMember.getMPW()%>">
						</li>
						<li>
							<input type="hidden" name="repasswd" id="repasswd" value="<%=loginMember.getMPW()%>">
						</li>
						<li>
							<label for="name">이름</label>
							<input type="text" name="name" id="name" value="<%=loginMember.getMNAME()%>">
							<div id="nameMsg" class="error">이름을 입력해 주세요.</div>
						</li>
						<li>
							<label for="email">이메일</label>
							<input type="text" name="email" id="email" value="<%=loginMember.getMEMAIL()%>">
							<div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
							<div id="emailRegMsg" class="error">입력한 이메일이 형식에 맞지 않습니다.</div>
						</li>
						<li>
							<label for="mobile">전화번호</label>
							<select name="mobile1">
								<option value="010" selected>&nbsp;010&nbsp;</option>
								<option value="011">&nbsp;011&nbsp;</option>
								<option value="016">&nbsp;016&nbsp;</option>
								<option value="017">&nbsp;017&nbsp;</option>
								<option value="018">&nbsp;018&nbsp;</option>
								<option value="019">&nbsp;019&nbsp;</option>
							</select>
							- <input type="text" name="mobile2" id="mobile2" size="4" maxlength="4" value="<%=loginMember.getMPHONE().substring(4,8)%>">
							- <input type="text" name="mobile3" id="mobile3" size="4" maxlength="4" value="<%=loginMember.getMPHONE().substring(9,13)%>">
							<div id="mobileMsg" class="error">전화번호를 입력해 입력해 주세요.</div>
							<div id="mobileRegMsg" class="error">전화번호는 3~4 자리의 숫자로만 입력해 주세요.</div>
						</li>
						<li>
							<label>우편번호</label>
							<input type="text" name="zipcode" id="zipcode" size="7" readonly="readonly" value="<%=loginMember.getMZIP()%>">
							<span id="postSearch" id="postSearch" >우편번호 검색</span>
							<div id="zipcodeMsg" class="error">우편번호를 입력해 주세요.</div>
						</li>
						<li>
							<label for="address1">기본주소</label>
							<input type="text" name="address1" id="address1" size="50" readonly="readonly" value="<%=loginMember.getMADDRESS1() %>">
							<div id="address1Msg" class="error">기본주소를 입력해 주세요.</div>
						</li>
						<li>
							<label for="address2">상세주소</label>
							<input type="text" name="address2" id="address2" size="50" value="<%=loginMember.getMADDRESS2() %>">
							<div id="address2Msg" class="error">상세주소를 입력해 주세요.</div>
						</li>
					</ul>
				</div>
			</span>
		</div>
		</fieldset>

		<div class="join_finish">
			<button type="submit" class="btn_black">수정하기</button>  
			<button type="reset" class="btn_black">취소</button>
			<br>
		</div>
		</form>
		</div>
<script type="text/javascript">
$("#passwd").focus();

$("#join").submit(function() {
	var submitResult=true;
	
	$(".error").css("display","none");
	

	var idReg=/^[a-zA-Z]\w{5,19}$/g;
	if($("#id").val()=="") {
		$("#idMsg").css("display","block");
		submitResult=false;
	} else if(!idReg.test($("#id").val())) {
		$("#idRegMsg").css("display","block");
		submitResult=false;
	} else if($("#idCheckResult").val()=="0") {
		$("#idCheckMsg").css("display","block");
		submitResult=false;		
	}
		
	var passwdReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
	if($("#passwd").val()=="") {
		$("#passwdMsg").css("display","block");
		submitResult=false;
	} else if(!passwdReg.test($("#passwd").val())) {
		$("#passwdRegMsg").css("display","block");
		submitResult=false;
	} 
	
	if($("#repasswd").val()=="") {
		$("#repasswdMsg").css("display","block");
		submitResult=false;
	} else if($("#passwd").val()!=$("#repasswd").val()) {
		$("#repasswdMatchMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#name").val()=="") {
		$("#nameMsg").css("display","block");
		submitResult=false;
	}
	
	var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
	if($("#email").val()=="") {
		$("#emailMsg").css("display","block");
		submitResult=false;
	} else if(!emailReg.test($("#email").val())) {
		$("#emailRegMsg").css("display","block");
		submitResult=false;
	}

	var mobile2Reg=/\d{3,4}/;
	var mobile3Reg=/\d{4}/;
	if($("#mobile2").val()=="" || $("#mobile3").val()=="") {
		$("#mobileMsg").css("display","block");
		submitResult=false;
	} else if(!mobile2Reg.test($("#mobile2").val()) || !mobile3Reg.test($("#mobile3").val())) {
		$("#mobileRegMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#zipcode").val()=="") {
		$("#zipcodeMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#address1").val()=="") {
		$("#address1Msg").css("display","block");
		submitResult=false;
	}
	
	if($("#address2").val()=="") {
		$("#address2Msg").css("display","block");
		submitResult=false;
	}
	
	if(!serviceAgree.checked || !privacyAgree.checked ) {
		alert("약관에 모두 동의해주세요.")
		return false;
	}
	
	return submitResult;
});


$("#idCheck").click(function() {
	$("#idMsg").css("display", "none");
	$("#idRegMsg").css("display", "none");
	
	var idReg=/^[a-zA-Z]\w{5,19}$/g;
	if($("#id").val()=="") {
		$("#idMsg").css("display","block");
		return;
	} else if(!idReg.test($("#id").val())) {
		$("#idRegMsg").css("display","block");
		return;
	}
		
	window.open("<%=request.getContextPath()%>/muskycode/member/join_id_check.jsp?id="+$("#id").val(), "idcheck", "width=450,height=100,left=700,top=400");
});

$("#id").change(function() {
	if($("#idCheckResult").val()=="1") {
		$("#idCheckResult").val("0"); 
	}
});


$("#postSearch").click(function() {
	new daum.Postcode({
		oncomplete: function(data) {
			var addr = ''; // 주소 변수
			
			if (data.userSelectedType === 'R' || data.userSelectedType === 'J') {
				addr = data.roadAddress;
			
			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById("zipcode").value = data.zonecode;
			document.getElementById("address1").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("address2").focus();
			}
		}
	}).open();
});


</script>

