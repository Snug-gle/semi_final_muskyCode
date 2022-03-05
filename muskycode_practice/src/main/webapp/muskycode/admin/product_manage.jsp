<%@page import="muskycode.dao.ProductDAO"%>
<%@page import="muskycode.dto.ProductDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 카테고리를 전달받아 PRODUCT 테이블에 저장된 해당 카테고리의 제품정보를 검색하여 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 관리자만 JSP 문서를 요청하여 처리되도록 권한 설정 --%>
<%-- => [카테고리]의 입력값이 변경되면 제품목록 출력페이지(product_manage.jsp)로 이동 - 카테고리 전달 --%>
<%-- => [제품등록]을 클릭한 경우 제품정보 입력페이지(product_add.jsp)로 이동 --%>
<%-- => [제품명]을 클릭한 경우 제품정보 출력페이지(product_detail.jsp)로 이동 - 제품번호 전달 --%>
<%@include file="/muskycode/security/admin_check.jspf"%>     
<%
		//검색 관련 정보를 반환받아 저장
		String search = request.getParameter("search");
		if (search == null)
			search = ""; // 값이 없으면 검색안함
	
		String keyword = request.getParameter("keyword");
		if (keyword == null)
			keyword = ""; //값이 없으면 검색안함
	
		String category=request.getParameter("category");
		if(category==null) {//전달값이 없는 경우
			category="ALL";
		}
		
		//페이지 번호 반환받아 저장
		int pageNum = 1; // 전달값 없으면 1페이지
		if (request.getParameter("pageNum") != null) { // 전달값이 있는 경우 해당 페이지 
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		
		//하나의 페이지에 출력될 게시글 갯수 설정
		int pageSize = 10;
		
		//테이블 전체 게시물수 반환
		int totalProduct = ProductDAO.getDAO().selectProductCount(search, keyword, category);
		//페이지 갯수 계산
		int totalPage = (int) Math.ceil((double) totalProduct / pageSize);
	
		//요청 페이지 번호에 대한 검증
		if(pageNum<=0 || pageNum>totalPage) {//전달된 페이지 번호가 비정상적인 경우
			pageNum=1;
		}
		
		//요청 페이지 번호에 대한 게시글 시작 행번호를 계산하여 저장
		//ex) 1Page : 1, 2Page : 11, 3Page : 21, 4Page : 31, ...
		int startRow=(pageNum-1)*pageSize+1;
		
		//요청 페이지 번호에 대한 게시글 종료 행번호를 계산하여 저장
		//ex) 1Page : 10, 2Page : 20, 3Page : 30, 4Page : 40, ...
		int endRow=pageNum*pageSize;

		//마지막 페이지에 대한 게시글 종료 행번호를 전달 게시글의 갯수로 변경
		if(endRow>totalProduct) {
			endRow=totalProduct;
		}
		
		//게시글 시작 글번호 
		int number = totalProduct - (pageNum - 1) * pageSize;
		
	//카테고리를 전달받아 PRODUCT 테이블에 저장된 해당 카테고리의 제품정보를 검색하여 
	//반환하는 DAO 클래스의 메소드 호출
	List<ProductDTO> productList=ProductDAO.getDAO().selectProductList(startRow, endRow, search, keyword, category);
%>

<hr class="layout"/>

<div id="board_list" class="titleArea" >
		<div id="board_title"><h2 style="color: blue;">PRODUCT MANAGE</h2></div>

<form name="memberForm" id="memberForm">
<div class="ec-base-table typeList gBorder">
	<div id="btnDiv">
		<button type="button" id="addBtn" class="btn_black" style="position: relative; left: 430px; top:5px;">제품등록</button>
	</div>
	
		 <table border="1" summary="" style="width: 1000px; position: relative; left:15%;">
			<thead class="xans-element- xans-board xans-board-listheader-1002 xans-board-listheader xans-board-1002 ">
				<tr style=" ">
					<td width="100">제품번호</td>
					<td class="pname" width="500">제품명</td>
					<td width="100">제품수량</td>
					<td width="150">제품가격</td>
					<td width="150">상태</td>
				</tr></thead>
		<tbody class="xans-element- xans-board xans-board-list-1002 xans-board-list xans-board-1002 center">
			<% if(productList.isEmpty()) { %>
			<tr>
				<td colspan="5">등록된 제품이 하나도 없습니다.</td>
			</tr>	
			<% } else { %>
				<% for(ProductDTO product:productList) { %>
				<tr>
					<td><%=number%></td>
					<% if(product.getPSTATUS() == 0) { // 삭제 상품 일경우%> 
					<td id = "getstatus"><a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=product_detail&num=<%=product.getPNO()%>">
							<%=product.getPNAME() %>[삭제 상품]</a></td>
					<% } else { // 일반 상품일 경우%>
						<td id = "getstatus"><a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=product_detail&num=<%=product.getPNO()%>">
							<%=product.getPNAME() %></a></td>
					<% } %>
					<!-- DecimalFormat : 숫자값을 원하는 형식으로 변환하기 위한 패턴정보를 저장하는 클래스
					DecimalFormat.getInstance() : 기본 패턴이 저장된 DecimalFormat 인스턴스를 반환하는 메소드
					DecimalFormat.format(Object number) : 숫자값을 전달받아 DecimalFormat 인스턴스에 저장된
					패턴의 문자열로 변환하여 반환하는 메소드 -->
					<td><%=DecimalFormat.getInstance().format(product.getPSTOCK()) %></td>
						<td><%=DecimalFormat.getCurrencyInstance().format(product.getPPRICE()) %></td>
						<td class ="product_status">
						<select class = "status" name ="<%=product.getPNO()%>">
							<option value = "0" <%if (product.getPSTATUS() == 0) { %>
							selected = "selected" <% } %>>삭제상품</option>
							<option value = "1" <%if (product.getPSTATUS() == 1) { %>
							selected = "selected" <% } %>>판매상품</option>
						</select>
					</td>
				</tr>
				<% number--;%>
				<% } %>
			<% } %>
		</tbody>
	</table>
	</div>
	</form>
	
<!-- 	</form> -->
	
	<%-- 페이지 번호 출력 및 링크 설정 - 블럭화 처리 --%>
	<%
	//페이지 블럭에 출력될 페이지의 갯수 설정
	int blockSize = 5;

	//페이지 블럭에 출력될 시작 페이지 번호를 계산하여 저장
	//ex) 1Block : 1, 2Block : 6, 3Block : 11, 4Block : 16,...
	int startPage = (pageNum - 1) / blockSize * blockSize + 1;

	//페이지 블럭에 출력될 종료 페이지 번호를 계산하여 저장
	//ex) 1Block : 5, 2Block : 10, 3Block : 15, 4Block : 20,...
	int endPage = startPage + blockSize - 1;

	//마지막 페이지 블럭의 종료 페이지 번호 변경
	if (endPage > totalPage) {
		endPage = totalPage;
	}
	%>
	<br><br>
	<%if (startPage > blockSize) {//시작 페이지 번호가 blockSize 변수값을 초과한 경우 링크 설정%>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=product_manage&pageNum=1&search=<%=search%>&keyword=<%=keyword%>">[처음]</a>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=product_manage&pageNum=<%=startPage - blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[이전]</a>
	<% } else {//시작 페이지 번호가 blockSize 변수값을 초과하지 않을 경우 링크 미설정 %>
	[처음][이전]
	<% } %>

	<%for (int i = startPage; i <= endPage; i++) {%>
	<%if (pageNum != i) {//요청 페이지 번호와 출력 페이지 번호가 같지 않은 경우 링크 설정 %>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=product_manage&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>">[<%=i%>]
	</a>
	<% } else {//요청 페이지 번호와 출력 페이지 번호가 같을 경우 링크 미설정%>
	[<%=i%>]
	<% } %>
	<% } %>

	<% if (endPage != totalPage) {//종료 페이지 번호와 전체 페이지 갯수가 같지 않은 경우 링크 설정 %>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=product_manage&pageNum=<%=startPage + blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[다음]</a>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=product_manage&pageNum=<%=totalPage%>&search=<%=search%>&keyword=<%=keyword%>">[마지막]</a>
	<% } else {//종료 페이지 번호와 전체 페이지 갯수가 같은 경우 링크 미설정 %>
	[다음][마지막]
	<% } %>
	
	<br><br>
		
	<form method="post" id="categoryForm" >
		<select id="category" name="category">
			<option value="ALL" <% if(category.equals("ALL")) { %> selected="selected" <% } %>>전체(ALL)</option>
			<option value="SOLID" <% if(category.equals("SOLID")) { %> selected="selected" <% } %>>고체(SOLID)</option>		
			<option value="BODY" <% if(category.equals("BODY")) { %> selected="selected" <% } %>>바디(BODY)</option>		
			<option value="HAIR" <% if(category.equals("HAIR")) { %> selected="selected" <% } %>>헤어(HAIR)</option>				
		</select>
	</form>
	
	<br>
	
	<%-- 게시글 검색 기능 제공 --%>
	<form action="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=product_manage" method="post">
		<%-- select 태그에 의해 입력되어 전달되는 값은 비교 컬럼명과 동일하게 설정 --%>
		<select name="search">
			<option value="pname" selected="selected">&nbsp;제품명&nbsp;</option>
			<option value="pcontent">&nbsp;상세설명&nbsp;</option>
		</select> 
		<input type="text" name="keyword">
		<button type="submit" class="btn_black">검색</button>
	</form>
</div>

<script type="text/javascript">

$("#addBtn").click(function() {
	location.href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=product_add";
});


$(".status").change(function () {
	//이벤트가 발생된 엘리먼트의 속성값을 반환받아 저장	
	var pno=$(this).attr("name");//식별자 >> 아이디
	//이벤트가 발생된 엘리먼트의 입력값을 반환받아 저장	
	var status=$(this).val();//입력값 >> 상품상태
	//alert(id+" = "+status);
	location.href = "<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=product_status_action&pno="+pno+"&status="+status;
});

$("select[name=category]").change(function() {
	$("#categoryForm").submit();
});
</script>









