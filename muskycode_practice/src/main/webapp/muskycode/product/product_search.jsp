<%@page import="java.text.DecimalFormat"%>
<%@page import="muskycode.dao.ProductDAO"%>
<%@page import="muskycode.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String keyword = request.getParameter("keyword");
	List<ProductDTO> productList = ProductDAO.getDAO().selectKeywordProduct(keyword);
	
	int searchProductCount = ProductDAO.getDAO().searchProductCount(keyword);
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


<div class="item">
	<form id="searchForm" method="post" target="_self">
		<a>상품명</a>
		<input id="keyword" name="keyword" fw-filter="" fw-label="상품명/제조사"
			fw-msg="" class="inputTypeText" placeholder="" size="15" value=<%=keyword %> type="text" />
	<div class="xans-element- xans-search xans-search-hotkeyword popular">
	<br>
		<p class="button">
			<button type="submit" class="btnSubmitFix sizeM">검색</button>
		</p>
	</div>
	</form>
</div>
<div class="searchResult">
	<p class="record"><br>
		총 <strong><%=searchProductCount %></strong> 개 의 상품이 검색되었습니다.
	</p><br>
</div>
<hr>
<div id="productList">
	<% for(ProductDTO product : productList) { %>
		<div class="prd">
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
									<span style="font-size: 17px; color: #333333; font-weight: bold;"><%=DecimalFormat.getInstance().format(product.getPPRICE()) %>원</span>
									<span id="span_product_tax_type_text" style=""> </span>
									</li>
								</ul>
								<div class="promotion"></div>
							</div> 
						</li>
					</ul>
				</div>
			</div>
	<% } %>
</div>
<div style="clear: both;"></div>
<br><br>


<script type="text/javascript">

</script>