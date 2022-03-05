<%@page import="java.text.DecimalFormat"%>
<%@page import="muskycode.dao.ProductDAO"%>
<%@page import="muskycode.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	// 상품 번호 받기
	int no = Integer.parseInt(request.getParameter("no"));
	ProductDTO product = ProductDAO.getDAO().selectNumProduct(no);

%>

<style type="text/css">

.error {
	color: red;
	position: relative;
	left: 160px;
	display: none;
}

thead {
	margin-bottom: 30px;
}
</style>

<div id="allDetailForm">
	<div class="xans-element- xans-product xans-product-addimage listImg">
		<ul>
			<li class="xans-record-">
			<img src="<%=request.getContextPath()%>/muskycode/product_images/<%=product.getPIMGURL() %>" class="ThumbImage" alt="" />
			</li>
		</ul>
	</div>
	
	<div class="color displaynone"></div>
	
	<div class="infoArea">
		<div class="xans-element- xans-product xans-product-detaildesign">
			<table border="1" summary="">
				<caption>기본 정보</caption>
				<tbody>
					<tr class=" display상품명 xans-record-">
						<th scope="row"><span style="font-size: 20px; color: #555555;"
							data-i18n=PRODUCT.PRD_INFO_PRODUCT_NAME></span></th>
						<td><span style="font-size: 20px; color: #555555;"><%=product.getPNAME() %></span></td>
					</tr>
					<tr class=" display판매가 xans-record-">
						<th scope="row"><span
							style="font-size: 20px; color: #e51623; font-weight: bold;"
							data-i18n=PRODUCT.PRD_INFO_PRODUCT_PRICE></span></th>
						<td><span
							style="font-size: 20px; color: #e51623; font-weight: bold;"><strong
								id="span_product_price_text"><%=DecimalFormat.getInstance().format(product.getPPRICE()) %>원 </strong><input
								id="product_price" name="product_price" value="" type="hidden" /></span></td>
					</tr>
				</tbody>
			</table>
			<br>
		</div>
		<hr style="width: 70%;"><br>
	
	
		<div id="totalProducts" class="">
		<form action="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=order&musky=order_action2" method="post">
			<table border="1" summary="" style="text-align: center;">
				<caption>상품 목록</caption>
				<caption><input type="hidden" name = "pno" value="<%=product.getPNO()%>"></caption>
				<colgroup>
					<col style="width: 200px; height: 100px;" />
				</colgroup>
				<thead >
					<tr id="column">
						<th scope="col" style="position: relative; left: 200px;">상품명</th>
						<th scope="col" style="position: relative; left: 20px;">상품수</th>
						<th scope="col" style="position: relative; right: 200px;">가격</th>
					</tr>
				</thead>
				<tbody class="">
					<tr id="values">
						<td style="position: relative; left: 200px;"><%=product.getPNAME() %></td>
						<td class="bseq_ea" style="position: relative; left: 20px;">
							<button type ="button" id="plus" class="btn1">＋</button>
							<input id="result" value="1" type="text" name = "qty" readonly="readonly"/>
				        	<button type ="button" id="minus" class="btn1">－</button>
							<div id="qtyMsg" class="error"></div>
						</td>
						<td class="right" style="position: relative; right: 200px;"><span class="quantity_price"><%=DecimalFormat.getInstance().format(product.getPPRICE()) %>원</span>
						</td>
					</tr>
				</tbody>
			</table>
			
			<br><hr style="width: 70%;">
			
			<div class="xans-element- xans-product xans-product-action ">
			<div class="ec-base-button">
				<% if(product.getPSTOCK()!=0) { %>
				<button id="buy" class="btn_black" type="submit">구매하기</button>
				<button id="cart_add" class="btn_black" type="button">장바구니</button>
				<% } else { %>
				<button id="soldout" class="btn_black" type="button" onclick="alert('품절되었습니다')">품절</button>				
				<% } %>
			</div>
		</div>
		</form>
		</div>

		
	</div>
</div>

<script type="text/javascript">
	var maxVal = <%=product.getPSTOCK()%>;
	var minVal = 0;
	
	<%-- 증감소 버튼 --%>
	$("#plus").click( function() {
		var qtyCount = document.getElementById("result").value;
		qtyCount++;
		
		if(qtyCount > maxVal){
			return;
		}
		document.getElementById("result").value=qtyCount;
		
	});
	
	$("#minus").click( function() {
		var qtyCount = document.getElementById("result").value;
		qtyCount--;
		
		if(qtyCount== minVal){
			return false;
		}
		document.getElementById("result").value=qtyCount;
	});
	
	
	<%-- 장바구니 클릭시 이동 --%>
	$("#cart_add").click( function() {
		if(confirm("장바구니에 추가하시겠습니까?")) {
			var qty= document.getElementById("result").value;
			var productNo = <%=no%>;
			location.href = "<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=cart&musky=cart_add_action&pno="+productNo+"&qty="+qty;
		}
	});

	</script>
