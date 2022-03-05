<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/muskycode/security/admin_check.jspf"%>
<style type="text/css">
#product {
	width: 800px;
	margin: 0 auto;
}

table {
	margin: 0 auto;
}

td {
	text-align: left;
}
</style>
     
<div id="product">
	<h2>제품등록</h2>
	
	<%-- 파일을 입력받아 전달하기 위해 form 태그의 method 속성값을 [POST]로 설정하고 
	enctype 속성값을 [multipart/form-data]로 설정 --%>
	<form action="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=product_add_action"
		method="post" enctype="multipart/form-data" id="productForm">
	<table>
		<tr>
			<td>카테고리</td>
			<td>
				<select name="category">
					<option value="SOLID">고체(SOLID)</option>
					<option value="BODY">바디(BODY)</option>
					<option value="HAIR">헤어(HAIR)</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>제품명</td>
			<td><input type="text" name="name" id="name"></td>
		</tr>
		<tr>
			<td>제품이미지</td>
			<td><input type="file" name="image" id="image"></td>
		</tr>
		<tr>
			<td>상세정보</td>
			<td><textarea rows="7" cols="60" name="detail" id="detail"></textarea></td>
		</tr>
		<tr>
			<td>제품수량</td>
			<td><input type="text" name="qty" id="qty"></td>
		</tr>
		<tr>
			<td>제품가격</td>
			<td><input type="text" name="price" id="price"></td>
		</tr>
		<tr>
			<br><br>
			<td colspan="2"><button type="submit" class="btn_black">제품등록</button></td>
		</tr>
	</table>		
	</form>
	
	<div id="message" style="color: red;"></div>	
</div>

<script>
$("#productForm").submit(function() {
	if($("#name").val()=="") {
		$("#message").text("제품명을 입력해 주세요.");
		$("#name").focus();
		return false;
	}
	
	if($("#image").val()=="") {
		$("#message").text("제품이미지를 입력해 주세요.");
		$("#image").focus();
		return false;
	}
	
	if($("#detail").val()=="") {
		$("#message").text("상세정보를 입력해 주세요.");
		$("#detail").focus();
		return false;
	}
	
	if($("#qty").val()=="") {
		$("#message").text("제품수량을 입력해 주세요.");
		$("#qty").focus();
		return false;
	}
	
	if($("#price").val()=="") {
		$("#message").text("제품가격을 입력해 주세요.");
		$("#price").focus();
		return false;
	}
});
</script>







