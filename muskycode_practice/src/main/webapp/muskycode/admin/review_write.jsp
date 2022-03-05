<%@page import="muskycode.dao.ProductDAO"%>
<%@page import="muskycode.dto.MemberDTO"%>
<%@page import="muskycode.dao.ReviewDAO"%>
<%@page import="muskycode.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="muskycode.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/muskycode/security/admin_check.jspf" %>
<%
	//상품테이블 객체 생성
	ProductDTO product = new ProductDTO();
	
	MemberDTO member = new MemberDTO();
	
	//로그인한 회원의 아이디를 전달받아 구매한 상품의 정보를 검색하는 메소드
	
	// 	for(ProductDTO productList : memberProductList) {
	// 		product.setPNAME(productList.getPNAME());
	// 	}
	
	// 주문 그룹 넘버 쿼리스트링 값 받기
	int orderGroupNo = Integer.parseInt(request.getParameter("orderGroupNo"));
	// 해당 상품 번호 쿼리스트링 값 받기
	int pno = Integer.parseInt(request.getParameter("pno"));
	
	int pageNum = 1;
	
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
		<h2>리뷰 작성</h2>
	</div>
	
<div id="AllForm">
	<form action="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=review_write_action"
	 method="post" enctype="multipart/form-data" id="reviewForm">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<table>
			<tr>
				<th>상품이름</th>
				<td>
					<input type="text" readonly="readonly" value="<%=ProductDAO.getDAO().selectNumProduct(pno).getPNAME()%>">
				</td>
			</tr>
			<tr>
				<th>제목</th>
				 <td>
					<input type="text" name="rtitle" id="mid" size="40">
				</td> 
			</tr>
			<tr>
				<th>이미지</th>
				 <td>
					<input type="file" name="rimage" id="rimage">
				</td> 
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="7" cols="60" name="rcontent" id="rcontent"></textarea>
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<br><br>
					<button type="submit" class="btn_black">저장하기</button>
					<button type="reset" id="resetBtn" class="btn_black">다시쓰기</button>
				</th>
			</tr>
		</table>
	</form>
</div>
<div id="message" style="color: red;"></div>

<script type="text/javascript">
$("#rtitle").focus();

$("#reviewForm").submit(function() {
	if($("#rtitle").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#qtitle").focus();
		return false;
	}
	
	if($("#rcontent").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#rcontent").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#rtitle").focus();
	$("#message").text("");	
});
</script>


