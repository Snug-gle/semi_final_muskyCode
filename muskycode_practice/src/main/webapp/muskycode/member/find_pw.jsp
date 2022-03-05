<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String message=(String)session.getAttribute("message"); 
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
%>	
<style type="text/css">
div h2 {
	text-align: center;
	color: rgb(81, 48, 43);
}


span {
	margin-left: auto;
	margin-right: auto;
}

p {
	text-align: center;
	padding-top: 7px;
}

#mname, #mphone, #memail,#mid {
	margin: 0 auto; 
	margin-top:10px;
	width:200px;
	height: 20px;
}

.error {
	text-align: center;
	color: red;
}

</style>
	<div class="row">
		<div class="col-sm-4"></div>
		<div class="col-sm-4">
			<h2>FIND PASSWORD</h2><br>
			<hr width="250px;">
			<div class="row">
				<div class="col-sm-2"></div>
				<div class="col-sm-8">
					<form name="findPw" id="findPw" method="post" action="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=member&musky=reset_pw">
					<div class="row">
						<div class="radio-inline" style="margin: 0 auto; margin-top: 30px; margin-bottom: 20px;">
							<label><input type="radio" name="inlineRadioOptions" id="findemail" value="option1" checked="checked">이메일로 찾기</label> &nbsp;&nbsp; 
							<label><input type="radio" name="inlineRadioOptions" id="findphone" value="option2">휴대폰 번호로 찾기</label>
						</div>
					</div>
					<div class="row" style="margin: 0;">
						<div class="col-sm-4">
							<p>아이디</p>
						</div>
						<div class="col-sm-8" >
							<div><input type="text" name="mid" id="mid" class="form-control"></div>
						</div>
					</div>
							<p id="idMsg" class="error">아이디를 입력해 주세요.</p>
					<div class="row" style="margin: 0;">
						<div class="col-sm-4">
							<p>이름</p>
						</div>
						<div class="col-sm-8" style="padding: 0;">
							<div><input type="text" id="mname" name="mname" class="form-control"></div>
						</div>
					</div>
							<p id="nameMsg" class="error">이름을 입력해 주세요.</p>
					<div class="row" style="margin: 0;">
						<div class="col-sm-4">
							<p id="email">이메일</p>
						</div>
						<div class="col-sm-8" style="padding: 0;">
							<input type="email" id="memail" name="memail" class="form-control">
							<input type="text" id="mphone" name="mphone" class="form-control"> 
						</div>
					</div>
							<p id="emailMsg" class="error">이메일을 입력해 주세요.</p>
							<p id="phoneMsg" class="error">휴대폰 번호를 입력해 주세요.</p>
					<br><br>	
					<div class="row">
						<button type="submit" id="confirmBtn" class="btn_black" style="width: 200px;">확인</button>
					</div>
					<br><hr width="250px;">
					</form>
				</div>
				<div class="col-sm-2"></div>


			</div>
		</div>
		<div class="col-sm-4"></div>
		
		<img src="<%=request.getContextPath()%>/muskycode/images/sub_1.png" style="width:800px; height: auto; position: relative; top: 30px;">
	</div>
<script type="text/javascript">
	//휴대폰번호로 찾기, 이메일로 찾기 선택
	$("#mphone").css("display","none");
	
	$(function() {
		$("#findphone").on("click", function() { //휴대폰번호로 찾기 누르면 이메일 숨겨지고 text 입력 input 창 나타남
			$("#email").html("<div>휴대폰 번호</div>");
			$("#mphone").css("display","block");
			$("#memail").css("display","none");	
		});
	});
	
	$(function() {
		$("#findemail").on("click", function() { //이메일로찾기 누르면 휴대폰찾기 숨겨지고 email 입력 input 나타남
			$("#email").html("<div>이메일</div>");
			$("#memail").css("display","block");
			$("#mphone").css("display","none");
		});
	});	

	//유효성 검사
	$("#mid").focus();
	$(".error").css("display","none");
	
	$("#findPw").submit(function() {	
		
		var submitResult=true;
		if($("input[name=inlineRadioOptions]:checked").val()=="option2"){
			
			if($("#mid").val()=="") {
				$("#idMsg").css("display","block");
				$("#mid").focus();
				submitResult=false;
			}
			if($("#mname").val()=="") {
				$("#nameMsg").css("display","block");
				$("#mname").focus();
				submitResult=false;
			}
			if($("#mphone").val()=="") { //휴대폰번호 빈칸이면 메세지
				$("#emailMsg").css("display","none");
				$("#phoneMsg").css("display","block");		
				$("#mphone").focus();
				submitResult=false;
			} 
			
		}
		else if($("input[name=inlineRadioOptions]:checked").val()=="option1") {
			
			if($("#mid").val()=="") {
				$("#idMsg").css("display","block");
				$("#mid").focus();
				submitResult=false;
			}
			if($("#mname").val()=="") {
				$("#nameMsg").css("display","block");
				$("#mname").focus();
				submitResult=false;
			}
			
			var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
			if($("#memail").val()=="") { //이메일 빈칸이면 메세지
				$("#emailMsg").css("display","block");
				$("#phoneMsg").css("display","none");		
				$("#memail").focus();
				submitResult=false;			
			}
		}
		return submitResult;
	});
	
	$("input[name=inlineRadioOptions]").change( function() {
		$(".error").css("display","none");
	});
</script>
</body>
</html>
