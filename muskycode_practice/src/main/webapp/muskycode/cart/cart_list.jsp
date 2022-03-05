<%@page import="muskycode.dao.ProductDAO"%>
<%@page import="muskycode.dto.ProductDTO"%>
<%@page import="muskycode.dao.CartDAO"%>
<%@page import="muskycode.dto.CartDTO"%>
<%@page import="java.util.List"%>
<%@page import="muskycode.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="/muskycode/security/login_url.jspf"%>

<%
// 해당 아이디의 Cart 정보 List를 반환
List<CartDTO> cartList = CartDAO.getDAO().selectCart(loginMember.getMID());

int totalPrice = 0;

for (CartDTO cart : cartList) {
	// 상품 번호를 전달받아 해당 상품 객체 반환
	ProductDTO product = ProductDAO.getDAO().selectNumProduct(cart.getPNO());
	
	totalPrice += cart.getCQUANTITY() * product.getPPRICE();

}
%>

<!-- styleSheet  -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/muskycode/design/optimizer2260.css?filename=nc1LCoAwDIThfXHrOYLeqC3xAU2mpCno7RW8gHQ7zMdPB4RpWY2qYbcoZNzQLTPl1mgzqFOGCHR6h5n-_DmHhtL9hIaEaxB299FoiTfbGPWYCg9S1FBO5ZCi6td_AA&amp;type=css&amp;k=37c9481ac0212340e132f81eba4d1049fee7f18e&amp;t=1635315871" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/muskycode/design/optimizer9791.css?filename=tdXBTsQgEAbg-9arz4EmuxsfQRMPJvsEdJgt4wJDGHDt20tjNSZ7s3ArtPlK_swMyrJHhTAUwSTqncJxfzgeHp5ULKMjGGz2TonBwaDQFJRcKDzuldMzl6xGLQQKRCqxqwvc1ReY7urOvfonvWieTXGoOBlMy08umN80XPSEbWkDL-HMrUw_i-WoriTWkeRN7E3AwN5zaGt-b7Q1fwqhUB83M7tMsQ9u0XWSY6o1Ap2yjnqioDN2SlyPfeCx5Ny6pH9t_uyWhusUdP0MNslXXB4G8pFTbtXhfwbcenJfagcuo-5kKUYKU2MfOHxUgjhEaE3XLpk4zb0Sed06929tQZ3APqM27S7WdRqt9nDm5Bf6Cw&amp;type=css&amp;k=899870d76c61b596c54a4411d07ebf68cba37d43&amp;t=1625719215&amp;user=T" />

<!-- contents -->
<div class="titleArea">
	<h2>CART</h2>
</div>

<div class="xans-element- xans-order xans-order-basketpackage ">
	<div
		class="xans-element- xans-order xans-order-tabinfo ec-base-tab typeLight ">
		<ul class="menu">
			<li class="selected "><a>장바구니 내역</a></li>
		</ul>
	</div>

	<!-- 장바구니 비어있을 때 -->
	<% if (cartList.isEmpty()) { %>
	<div class="xans-element- xans-order xans-order-empty ">
		<p>장바구니가 비어 있습니다.</p>
	</div>
	<% } else { %>

	<!-- 1. cartForm 시작  -->
	<div class="orderListArea ec-base-table typeList">

		<form id="cartForm" name="cartForm" method="post"
			action="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=order&musky=order_action">

			<table border="1"
				class="xans-order xans-order-normnormal xans-record-">
				<thead>
					<tr>
						<th style="width: 10px"></th>
						<th style="width: 27px"><input type="checkbox"
							id="allChecked" name="allChecked" checked></th>
						<th style="width: 100px">상품 이미지</th>
						<th style="width: 10px"></th>
						<th style="width: 100px">상품정보</th>
						<th style="width: 87px">판매가</th>
						<th style="width: 110px">수량</th>
						<th style="width: 98px">합계</th>
						<th style="width: 90px">삭제</th>
					</tr>
				</thead>



				<tbody class="xans-order xans-order-list center">

					<% for (CartDTO cart : cartList) {
					// 상품 번호를 전달받아 해당 상품 객체 반환
					ProductDTO product = ProductDAO.getDAO().selectNumProduct(cart.getPNO()); %>
					
					<tr class="xans-record-">

						<!-- 카트 번호 -->
						<td><input type="hidden" id="cartNo_<%=product.getPNO() %>" 
							name="cartNo" value="<%=cart.getCNO() %>"></td>

						<!-- 체크박스 -->
						<td><input type="checkbox" id="checkId" name="checkName"
							class="checkClass" value=<%=cart.getCNO() %>
							checked></input></td>
						
						<!-- 상품이미지 -->
						<td class="image"><a
							href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=product&musky=product_detail&no=<%=product.getPNO()%>">
								<img
								src="<%=request.getContextPath()%>/muskycode/product_images/<%=product.getPIMGURL()%>"
								style="width: 80px; height: 90px;" />
						</a></td>

						<!-- 재고 수량 -->
						<td><input type="hidden" id="productNo_<%=product.getPNO() %>"
						name="productNo" value="<%=product.getPSTOCK()%>"></td>

						<!-- 상품정보 -->
						<td><a
							href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=product&musky=product_detail&no=<%=product.getPNO()%>">
								<strong><%=product.getPNAME()%></strong>
						</a></td>

						<!-- 상품판매가 -->
						<td>
							<div class="">
								<input type="hidden" id="productPrice" name="productPrice" onclick="sum(i)"
									value="<%=product.getPPRICE()%>" readonly="readonly" /> <strong><%=product.getPPRICE()%></strong>
								<strong>원</strong>
							</div>
						</td>

						<!-- 수량 -->
						<td style="user-select: auto;"><span class=""
							style="user-select: auto;"> <span class="ec-base-qty"
								style="user-select: auto;"> <input
									id="result_<%=product.getPNO() %>" name="qty"
									value="<%=cart.getCQUANTITY() %>" type="text"
									readonly="readonly">
							</span>
								<button type="button" id="qtyUp" class="btn_white"
									value="<%=product.getPNO() %>" name ="qtyUp" >
									&nbsp;&nbsp;+&nbsp;&nbsp;</button>
								<button type="button" id="qtyDown" class="btn_white"
									value="<%=product.getPNO() %>" name="qtyDown">&nbsp;&nbsp;-&nbsp;&nbsp;</button>
						</span></td>

						<!-- 합계 -->
						<td><input type="hidden" id="totPrice" class="totPrice" name="totPrice" value="<%=cart.getCQUANTITY() * product.getPPRICE()%>"></input>
						<strong id="totPrice" ><%=cart.getCQUANTITY() * product.getPPRICE()%></strong><strong>원</strong></td>

						<!-- 삭제 -->
						<td><button type="button" id="deleteBtn" name="deleteBtn" class="btn_black" value="<%=product.getPNO() %>">&nbsp;삭제&nbsp;</button></td>
					</tr>
				</tbody>
				<% } %>
				
				<!-- 총 가격 -->
				<tfoot class="right">
					<tr>
						<td colspan="10">상품구매금액 <strong id="totCost" class="txtEm gIndent10"> <%=totalPrice %><span
								id="payPrice" class="txt18"><input type="hidden" id="payPrice" name="payPrice" value="<%=totalPrice %>" readonly="readonly"></span>원
						</strong>
						</td>
					</tr>
				</tfoot>
			</table>
			<!-- 주문 버튼 -->

			<div class="xans-order xans-order-selectorder ec-base-button ">
				<span class="gRight">
					<button id="deleteAll" type="button" class="btn_white">선택 삭제
					</button> <a href="javascript:history.back();" class="btn_white">쇼핑계속하기</a>
				</span>
			</div>
			<div
				class="xans-element- xans-order xans-order-totalorder ec-base-button justify">
				<button type="submit" id="orderBtn" class="btn_black">전체주문</button>
				<button type="button" id="selectOrderBtn" class="btn_black">선택주문</button>


			</div>
		</form>
	</div>
	
	<!-- form for UD  -->
	<form id="modifyForm" class="modifyForm" name="modifyForm"
		method="post">
		<input type="hidden" class="cno" name="cno" value=""> <input
			type="hidden" class="quantity" name="quantity" value=""> <input
			type="hidden" class="status" name="status" value=""> <input
			type="hidden" class="stock" name="stock" value="">

	<% } %>
	</form>
</div>



<script type="text/javascript">

var price=0;
var checkClassLeng;
$(document).ready(function(){
	if($("#allChecked").is(":checked")) {
		// 요소들 길이
		var checkClassLeng=document.getElementsByClassName("checkClass").length;
		
		//장바구니 내역 있을때
		if(checkClassLeng!=0){
			for (i=0; i < checkClassLeng; i++) {
				price=$(".totPrice").eq(i).attr("value");	
				
			}
		//장바구니 비었을때 가격 = 0
		} else {
		
		}
	}
});
	
/* 체크박스 전체 선택 해제 */
  $("#allChecked").click(function() {
	 
	if($("#allChecked").is(":checked")){
		$("input[name=checkName]").prop("checked", true);
	}
	else {
		$("input[name=checkName]").prop("checked", false);
	}

});  

/*  상품 체크 박스 모두 체크 혹은  상단 체크 박스 변경*/
 $("input[name=checkName]").click(function() {
	var total = $("input[name=checkName]").length;
	var checked = $("input[name=checkName]:checked").length;

	if(total != checked) $("#allChecked").prop("checked", false);
	else $("#allChecked").prop("checked", true); 
}); 
 

 /* 선택주문 */
 $("#selectOrderBtn").click(function() {
		if($("input[name=checkName]").filter(":checked").length==0) {
			alert("선택된 상품이 없습니다.");
		} else {
			$("#cartForm").attr("method", "post");
			$("#cartForm").attr("action", "<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=order&musky=order_action2");
			$("#cartForm").submit();
		}
	}); 
	 
/* 수량 증가 */
 var idiya;
 $("button[name=qtyUp]").click(function(){
 	
 		idiya=$(this).attr("value");
 		$(".cno").attr("value", document.getElementById("cartNo_"+idiya).value);
 		$(".quantity").attr("value", document.getElementById("result_"+idiya).value);
 		$(".status").attr("value","1");
 		$(".stock").attr("value",document.getElementById("productNo_"+idiya).value);
 	 		
 		$(".modifyForm").attr("action", "<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=cart&musky=cart_modify_action");
 		$(".modifyForm").submit();
 	
 }); 
 
/* 수량 감소 */ 
var starb;
 $("button[name=qtyDown]").click(function(){
	 	
	 	starb=$(this).attr("value");
	 	$(".cno").attr("value", document.getElementById("cartNo_"+starb).value);
 		$(".quantity").attr("value", document.getElementById("result_"+starb).value);
  		$(".stock").attr("value",document.getElementById("productNo_"+starb).value);
 		$(".status").attr("value","2");
	 		
 		$(".modifyForm").attr("action", "<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=cart&musky=cart_modify_action");
 		$(".modifyForm").submit();
 }); 


/* 개별 삭제 */
var coffBean;
 $("button[name=deleteBtn]").click(function(){
 	if(confirm("정말로 삭제 하시겠습니까?")) {
 		coffBean=$(this).attr("value");
 		$(".cno").attr("value", document.getElementById("cartNo_"+coffBean).value);
 		$(".modifyForm").attr("action", "<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=cart&musky=cart_remove_action");
 		$(".modifyForm").submit();
 	}
 });
 
/* 선택 삭제 */
 $("#deleteAll").click(function() {	
	 if($("input[name=checkName]").filter(":checked").length==0) {
			alert("선택된 상품이 없습니다.");
		} else {
			$("#cartForm").attr("method", "post");
			$("#cartForm").attr("action", "<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=cart&musky=cart_clear");
			$("#cartForm").submit();
		}
}); 

 /* 상품 합계 */
 
/*   $("#allChecked").click(function() {
	 var sum = 0;
 	$("input[name=checkName]").each(function(){
 		if($(this).is(":checked")==true) {
 			var eachPrice = parseInt($(this).parents("tr").find("input[name=totPrice]").val());
 			sum = sum + eachPrice;
	
 	
 		}
 			document.getElementById("payPrice").value = sum;
 	});
 
 });  */

/*----------------------  */
 
  /*   var values = new Array(i); // 배열을 선언하여 값 불러오기
	
    for(i=0; i<chkLeng; i++){
		
	values[i] = parseInt(document.getElementsByClassName("totPrice").value);

    }
	
	
	var total = parseInt(document.getElementById('payPrice').value);

	function sum(num) {
		if(document.cartForm.elements[num].checked == true){
			total = total + values[num];
		}else{
			total = total - values[num];
		}
		document.cartForm.elements[i].value = total; 
	}*/	
	
/* -------------------------------------------- */	

</script>

