<%@page import="java.text.DecimalFormat"%>
<%@page import="muskycode.dto.ProductDTO"%>
<%@page import="muskycode.dao.ProductDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 카테고리별 상품의 list를 상품페이지에 출력--%>
<%
	
	//JSP문서를 요청하여 전달된 페이지 번호를 반환받아 저장
	//-> 페이지 번호 전달값이 없는 경우 첫번째 페이지의 게시글 목록이 출력되도록 초기값 1 설정
	int pageNum = 1;
	if(request.getParameter("pageNum")!=null) { //전달값이 있는 경우
		pageNum = Integer.parseInt(request.getParameter("pageNum"));
	}
	
	//하나의 페이지에 검색될 제품의 개수 설정 - 전달값 이용 가능
	int productSize = 8;
	
	//PRODUCT테이블에 저장된 카테고리별 판매 상품 개수를 검색하여 반환하는 DAO클래스의 메소드 호출
	int totalProduct = ProductDAO.getDAO().selectStatusProductCount("BODY");

	//전체 페이지 번호
	int totalPage = (int)Math.ceil((double)totalProduct/productSize);
	
	
	//JSP문서를 요청할 때 전달된 페이지 번호에 대한 검증
	if(pageNum<=0 || pageNum>totalPage) { //전달된 페이지 번호가 비정상적인 경우
		pageNum = 1; //에러페이지로 보내지 않고 1페이지가 보여지게 설정
	}
	
	//요청 페이지 번호에 대한 게시글 시작 행번호를 계산하여 저장
	int startRow = (pageNum-1)*productSize+1;
	
	//요청 페이지 번호에 대한 게시글 종료 행번호를 계산하여 저장
	int endRow = pageNum*productSize;
	
	//마지막 페이지에 대한 게시글 종료 행번호를 전달 게시글의 개수로 변경
	if(endRow>totalProduct) {
		endRow = totalProduct;
	}
	
	List<ProductDTO> productList = ProductDAO.getDAO().selectProductList(startRow, endRow, "BODY");
	
	//요청 페이지에 출력될 게시글에 대한 글번호 시작값을 계산하여 저장
	//1페이지 : 1 /  2페이지 : 9 / 3페이지 : 17
	int number = (pageNum-1)*productSize + 1;

%>


<style type="text/css">
#productList {
	width: 100%;
}

.prd {
	margin: 10px;
	width: 350px;
	height: 350px;
	display: inline;
	float: left;
}

.description {
	text-align:center;
	position: relative;
	top: 230px;
	width: 200px;
	display: 
}

#product_image {
	position: absolute;
	width: 100%;
	height: 100%;
	bottom: 20px;
	right: 0;
}

</style>

<hr class="layout"/>

	<div class="titleArea" >
		<div id="product_title"><h2>BODY</h2>
	</div>
	<br><hr><br>
	현재 상품의 개수는 <%=totalProduct %> 개 입니다<br>
	</div>

<div id="productList">
	<% for(ProductDTO product : productList) { %>
		<div class="prd">
			<a style="display: none;"><%=number %></a>
				<div class="xans-element- xans-product xans-product-listmain-5 xans-product-listmain xans-product-5 ec-base-product">
					<ul class="prdList grid3">
						<li id="anchorBoxId_144" class="xans-record-" style="width: 300px; height: 300px;">
							<div class="discount" data-custom="26900" data-price=""></div>
							<div class="thumbnail">
								<div class="prdImg">
									<a href="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=product&musky=product_detail&no=<%=product.getPNO()%>">
									<span id="product_image">
									<img src="<%=request.getContextPath()%>/muskycode/product_images/<%=product.getPIMGURL()%>"
									id="eListPrdImage144_6" alt=<%= product.getPNAME() %>/>
									</span>
									</a>
								</div>
							<div class="icon">
	
	<!-- 장바구니 페이지  -->							
								<%-- <img src="<%=request.getContextPath() %>/muskycode/images/icon_201906041141583700.png"
								 onClick="category_add_basket('144','1', '6', 'A0000', false, '1', 'P00000FO', 'A', 'F', '0');"
									alt="장바구니 담기" class="ec-admin-icon cart" /> --%>
	
								
								<a href="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=cart&musky=cart_add_action&pno=<%=product.getPNO()%>" >
								<img src="<%=request.getContextPath() %>/muskycode/images/icon_201906041141583700.png" style="position: relative; top:220px;"
								<%--  onclick="location.href='"+request.getContextPath()"+"/muskycode/index.jsp?muskygroup=cart&musky=cart_add_action&pno=<%=product.getPNO()%>';" --%>
									alt="장바구니 담기" class="ec-admin-icon cart" /> </a> 
								
	<!-- 장바구니 페이지 -->					
							
							
							</div>
							</div>
							
							<div class="description">
								<strong class="name">
									<a href="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=product&musky=product_detail&no=<%=product.getPNO()%>"
										class="">
									<span class="title displaynone">
										<span style="font-size: 15px; color: #555555; font-weight: bold;"
											data-i18n=PRODUCT.PRD_INFO_PRODUCT_NAME>상품명
										</span> :
									</span>
									<span style="font-size: 15px; color: #555555; font-weight: bold;"> <%= product.getPNAME() %> </span>
									</a>
								</strong>
								
								<ul class="xans-element- xans-product xans-product-listitem-5 xans-product-listitem xans-product-5 spec">
									<li class=" display판매가 xans-record-">
									<strong class="displaynone">
										<span style="font-size: 17px; color: #333333; font-weight: bold;"
											data-i18n=PRODUCT.PRD_INFO_PRODUCT_PRICE>판매가
										</span> :
									</strong> 
									<span style="font-size: 17px; color: #333333; font-weight: bold;">
									<% if(product.getPSTOCK()!=0) { %>
									<%=DecimalFormat.getInstance().format(product.getPPRICE()) %>원
									<% } else { %>
									품절
									<% } %>
									</span>
									<span id="span_product_tax_type_text" style=""> </span>
									</li>
								</ul>
								<div class="promotion"></div>
							</div> 
						</li>
					</ul>
				</div>
			</div>
		<a style="display: none;"><% number++; %></a>
	<% } %>
</div>
<div style="clear: both;"></div>
<br><br>

	<%
		//페이지 블럭에 출력될 페이지의 개수 설정
		int blockSize = 5;
	
		//페이지 블럭에 출력될 시작 페이지 번호를 계산하여 저장
		int startPage = (pageNum-1)/blockSize*blockSize+1;
		
		//페이지 블럭에 출력될 종료 페이지 번호를 계산하여 저장
		int endPage = startPage+blockSize-1;
		
		//마지막 페이지 블럭의 종료 페이지 번호 변경
		if(endPage>totalPage) {
			endPage=totalPage;
		}
		

	%>
	
	<%-- 페이징 처리 --%>
	

	<div class="xans-element- xans-product xans-product-normalpaging ec-base-paginate" style="display: block;">
	
	<% if(startPage>blockSize) { //시작페이지 번호가 5페이지(blockSize)를 초과할 경우 링크 설정 %>
		<a href="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=product&musky=product_body&pageNum=1" class="first"><img src="<%=request.getContextPath() %>/muskycode/images/btn_page_first.gif" alt="첫 페이지"/></a>
		<a href="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=product&musky=product_body&pageNum=<%=startPage-blockSize %>"><img src="<%=request.getContextPath() %>/muskycode/images/btn_page_prev.gif" alt="이전 페이지"/></a>
	<% } else { //시작페이지 번호가 5페이지(blockSize)을 초과하지 않을 경우 링크 미설정%>
		<a class="first"><img src="<%=request.getContextPath() %>/muskycode/images/btn_page_first.gif" alt="첫 페이지"/></a>
		<a ><img src="<%=request.getContextPath() %>/muskycode/images/btn_page_prev.gif" alt="이전 페이지"/></a>
	<% } %>
	
	<ol style="display: inline-block;">
	<% for(int i=startPage; i<=endPage; i++) { %>
		<% if(pageNum!=i) { //요청페이지 번호와 출력페이지 번호가 같지 않은 경우 링크 설정 %>
		<li><a style="position:relative; display: block;" class="other" href="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=product&musky=product_body&pageNum=<%=i %>">&nbsp;<%=i %>&nbsp;</a></li>
		<% } else { //요청페이지 번호와 출력페이지 번호가 같을 경우 링크 미설정 %>
			<li><%=i %></li>
		<% } %>
	<% } %>
	</ol>
	
	<% if(endPage!=totalPage) { //종료페이지 번호와 전체페이지 개수가 같지 않은 경우 링크 설정 %>
		<a href="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=product&musky=product_body&pageNum=<%=startPage+blockSize %>"><img src="<%=request.getContextPath() %>/muskycode/images/btn_page_next.gif" alt="다음 페이지"/></a>
		<a href="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=product&musky=product_body&pageNum=<%=totalPage %>" class="last"><img src="<%=request.getContextPath() %>/muskycode/images/btn_page_last.gif" alt="마지막 페이지"/></a>
	<% } else { //종료페이지 번호와 전체페이지 개수가 같은 경우 링크 미설정 %>
		<a ><img src="<%=request.getContextPath() %>/muskycode/images/btn_page_next.gif" alt="다음 페이지"/></a>
		<a class="last"><img src="<%=request.getContextPath() %>/muskycode/images/btn_page_last.gif" alt="마지막 페이지"/></a>

	<% } %>
	

	</div>
