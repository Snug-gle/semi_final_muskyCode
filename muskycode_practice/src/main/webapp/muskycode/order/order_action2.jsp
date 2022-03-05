<%@page import="java.util.Arrays"%>
<%@page import="muskycode.dao.CartDAO"%>
<%@page import="muskycode.dao.ProductDAO"%>
<%@page import="muskycode.dto.CartDTO"%>
<%@page import="java.util.List"%>
<%@page import="muskycode.dao.MemberDAO"%>
<%@page import="muskycode.dto.ProductDTO"%>
<%@page import="muskycode.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@include file="/muskycode/security/login_url.jspf"%>   
<%
	// 장바구니 번호 배열 반환
	String[] cartNo = request.getParameterValues("checkName");

	String[] productNo=null;
	String[] qty=null;
	
	if(cartNo==null) { // 상세페이지 주문 시
		// 상품 번호 배열 반환
		productNo = request.getParameterValues("pno");
		// 상품 수량 배열 반환
		qty = request.getParameterValues("qty");
	} else { // 카트 주문 시 
		productNo=new String[cartNo.length];
		qty=new String[cartNo.length];
		
		for(int i=0; i<cartNo.length; i++){
			CartDTO cart = CartDAO.getDAO().selectNoCart(Integer.parseInt(cartNo[i]));
			productNo[i]= String.valueOf(cart.getPNO());
			qty[i]= String.valueOf(cart.getCQUANTITY());
		}	
	}
	
	int totalPay = 0;
	int presentPay = 0;
	ProductDTO productEx = null;
	
	for(int k=0; k<productNo.length; k++) {
		System.out.println("productNo[k]) = "+productNo[k]);
		productEx=ProductDAO.getDAO().selectNumProduct(Integer.parseInt(productNo[k]));	
		System.out.println(productEx);
		presentPay = productEx.getPPRICE() * Integer.parseInt(qty[k]);
		totalPay += presentPay;
	}

%>

<style type="text/css">
fieldset {
	text-align: left;
	margin: 10px auto;
}

legend {
	font-size: 1.2em;
}

#order label {
	width: 150px;
	text-align: left;
	margin-right: 10px;

}

#order ul li {
	list-style-type: none;
	margin: 15px 0;
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

#postSearch {
	font-size: 12px;
	font-weight: bold;
	cursor: pointer;
	margin-left: 10px;
	padding: 2px 10px;
	border: 1px solid black;
	background: black;
	color: white;
}

#postSearch:hover {
	background: white;
	color: black;
}

</style>

<hr class="layout"/>
<div class ="titlearea">

	<div id = "review_title"  class="titleArea">
		<h1>주문 / 결제</h1>
	</div>
</div>
	
<div class="orderAllForm" style="width: 1200px">
	<form name="orderForm" id="order" action="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=order&musky=order_add_action" method="post">
	<p style="font-size: 20px; font-weight: bold; color: blue; text-align: left; text-indent: 120px;">주문상품</p>
	<br>
	
		<div>
			<table border="1" style="position: relative; left: 10px; ">
				<tr>
					<th width="300" >IMAGE</th>
					<th width="300" >PRODUCT</th>
					<th width="200">PRICE</th>
					<th width="200">Quantity</th>
					<th width="200">Total Pay Amount</th>			
				</tr>
				<% for(int i=0;i<productNo.length;i++) { %>
					<% ProductDTO product=ProductDAO.getDAO().selectNumProduct(Integer.parseInt(productNo[i])); %>
				<tr>
					<td><img src = "<%= request.getContextPath()%>/muskycode/product_images/<%=product.getPIMGURL()%>"></td>
					<td><%=product.getPNAME() %></td>
					<td><%=product.getPPRICE() %></td>
					<td><%=qty[i] %></td>
					<td><%=product.getPPRICE()*Integer.parseInt(qty[i])%></td>
				</tr>
				<%} %>
			</table>
		</div>
		
		<br><br><br>
		
		<div>
		<p style="font-size: 20px; font-weight: bold; color: blue; text-align: left; text-indent: 120px;">주문정보</p>
		<fieldset>
			<% for(String qty1 : qty ) {%>
			<input type="hidden" name ="qty" value="<%=qty1 %>">
			<% } %>
			<%  if(cartNo != null) {for(String cartNo1 : cartNo) { %>
			<input type="hidden" name ="cartNo" value="<%=cartNo1 %>">
			<% } %>
			<% } %>
			<% for(String productNo1 : productNo) { %>
			<input type="hidden" name ="productNo" value="<%=productNo1 %>">
			<% } %>
			<div id = "sameMember" style="position: relative; left: 120px;">
				<span><button type="button" id="same" class="btn_black">회원 정보와 동일</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
				<button type="reset" id="newmem" class="btn_black">새로운 구매자</button></span>	
			</div>
			<br>
			<legend>주문 정보</legend>
			<ul style="position: relative; left: 120px;">
				<li>
					<label for="name">이름</label>
					<input type="text" name="name" id="name">
					<div id="nameMsg" class="error">이름을 입력해 주세요.</div>
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
					- <input type="text" name="mobile2" id="mobile2" size="4" maxlength="4">
					- <input type="text" name="mobile3" id="mobile3" size="4" maxlength="4">
					<div id="mobileMsg" class="error">전화번호를 입력해 입력해 주세요.</div>
					<div id="mobileRegMsg" class="error">전화번호는 3~4 자리의 숫자로만 입력해 주세요.</div>
				</li>
				<li>
					<label>우편번호</label>
					<input type="text" name="zipcode" id="zipcode" size="7" readonly="readonly">
					<span id="postSearch">우편번호 검색</span>
					<div id="zipcodeMsg" class="error">우편번호를 입력해 주세요.</div>
				</li>
				<li>
					<label for="address1">기본주소</label>
					<input type="text" name="address1" id="address1" size="50" readonly="readonly">
					<div id="address1Msg" class="error">기본주소를 입력해 주세요.</div>
				</li>
				<li>
					<label for="address2">상세주소</label>
					<input type="text" name="address2" id="address2" size="50">
					<div id="address2Msg" class="error">상세주소를 입력해 주세요.</div>
				</li>
			</ul>
		</fieldset>
	</div>
	<br><br>
	
	<div>
	<p style="font-size: 20px; font-weight: bold; color: blue; text-align: left; text-indent: 120px;">결제정보</p>
		<div class="paycontents" style="position: relative; left: 120px;">
		<fieldset>
			<ul>
				<li>
					<label>결제방식</label>
					<select name="payment">
						<option value="card" selected>&nbsp;카드결제&nbsp;</option>
						<option value="account">&nbsp;계좌이체&nbsp;</option>
						<option value="deposit">&nbsp;무통장입금&nbsp;</option>
					</select>
				</li>
				<li>
					<label>계좌번호</label>
					<textarea rows="1" cols="30" id="accountdetail"></textarea>
					<div id="accountMsg" class="error">계좌 정보를 입력해 주세요.</div>
				</li>
			</ul>
		</fieldset>
		</div>
	</div>
	<br><br><br>
	
	<div>
	<p style="font-size: 20px; font-weight: bold; color: blue; text-align: left; text-indent: 120px;">적립금 사용</p>
		<div>
			<fieldset>
				<ul style="position:relative; left: 120px;">
					<li>
						<input type="text" id="reserves" name="reserves" value="0">
						<span>사용 가능 적립금 : [<%=loginMember.getMRESERVES()%>]원 </span>
					</li>
					<br>
					<li>
					<button id="reservetotBtn" name="reservetotBtn" type="button" class="btn_black">전액 사용</button>
					<button id="reserveBtn" name="reserveBtn" type="button" class="btn_black">적립금 사용</button>
					</li>
				</ul>
			</fieldset>
		</div>
		<div id="reservesMsg" class="error">가지고 계신 적립금만 이용 가능합니다. 다시 입력하세요.</div>
		</div>
	</div>
	
	<br><br><br>
	
	<div id="totalOrder">
	<p style="font-size: 20px; font-weight: bold; color: blue; text-align: left; text-indent: 120px;">결제 금액</p>
		<br>
		<table style="position: relative; left: 50px; ">
			<tr>
				<th>주문 금액</th>
				<th>할인 금액</th>
				<th>최종 결제 금액</th>
			</tr>
			<tr>
				<td><%=totalPay%></td>
				<td>
				<input type="text" id ="discounted" value="0" readonly="readonly" >
				</td>
				<td>
				<input type="text" id ="totalpay" readonly="readonly" value ="<%=totalPay %>">
				</td>
			</tr>
		</table>
	</div>
	
		<div class = "order_finish">
			<br><br>
			<button type="submit" class="btn_black">결제하기</button>  
			<button type="reset" class="btn_black">다시입력</button>
		</div>
	</form>
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

$("#name").focus();

$("#order").submit(function() {
	var submitResult=true;
$(".error").css("display","none");

	if($("#name").val()=="") {
		$("#nameMsg").css("display","block");
		submitResult=false;
		console.log("1");
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
	
	if($("#accountdetail").val()==""){
		$("#accountMsg").css("display","block");
		submitResult=false;
	}

	return submitResult;
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
	

/* 동일 버튼 눌렀을 때 세션 회원 정보 삽입  */
$("#same").click(function () { 
	document.orderForm.name.value = "<%=loginMember.getMNAME() %>";
	var m1 = document.getElementsByName("mobile1");
	m1[0].value="<%=loginMember.getMPHONE().substring(0, 3)%>";
	document.orderForm.mobile2.value = "<%=loginMember.getMPHONE().substring(4,8)%>";
	document.orderForm.mobile3.value = "<%=loginMember.getMPHONE().substring(9)%>";
	zipcode.value = "<%=loginMember.getMZIP() %>";
	address1.value = "<%=loginMember.getMADDRESS1()%>";
	address2.value = "<%=loginMember.getMADDRESS2()%>";
});

/* 적립금 버튼 눌렸을 때 가지고 있는 모든 적립금 사용 가능하게  */
$("#reservetotBtn").click(function () {
	$("#reservesMsg").css("display","none");
	if(<%=totalPay %> < <%=loginMember.getMRESERVES()%>){ // 총 금액 < 적립금 일때 
		alert("주문 금액 이상인 적립금을 사용하실 수 없습니다.");
		return;
	}
	else {
	document.orderForm.reserves.value = "<%=loginMember.getMRESERVES()%>";
	document.getElementById("discounted").value = "<%=loginMember.getMRESERVES()%>"; // 할인된 가격에 적립금 값 넣고
	document.getElementById("totalpay").value = "<%=totalPay - loginMember.getMRESERVES()%>";
	}
});

$("#reserveBtn").click(function() { // 적립금 입력했을 때
	if( reserves.value > <%=totalPay%>){ // 총 금액 < 적립금 일때 
		alert("주문 금액 이상인 적립금을 사용하실 수 없습니다.");
		
	} 
	else{
	if(<%=loginMember.getMRESERVES()%> < reserves.value){ // 가지고 있는 적립금 보다 더 많은 금액을 입력했을 때
			$("#reservesMsg").css("display","block");
			
		}
		else{	
			$("#reservesMsg").css("display","none");
			document.getElementById("discounted").value = reserves.value; 
			document.getElementById("totalpay").value = <%=totalPay%> -  $("#reserves").val();
		}
	}
});

</script>