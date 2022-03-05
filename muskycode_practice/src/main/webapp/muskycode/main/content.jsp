<%@page import="java.text.DecimalFormat"%>
<%@page import="muskycode.dao.ProductDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="muskycode.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/* 임의의 상품을 넣었습니다.  */
	ProductDTO product1 = ProductDAO.getDAO().selectNumProduct(70); //solid제품
	ProductDTO product42 = ProductDAO.getDAO().selectNumProduct(106); //body제퓸
	ProductDTO product4 = ProductDAO.getDAO().selectNumProduct(89); //hair제품
%>

<!-- <div class="rolling_banner"> -->
	<div class="taR">
		<div>
			<video muted autoplay loop style="position: relative; width: 1500px; bottom: 90px; right: 5px;">
				<source src="<%=request.getContextPath()%>/muskycode/images/main_video.mp4"></source>
			</video>
		<br><br><br><br>
		</div>
		
	</div>

<div id="container">
	<div id="contents">
		<!-------------------------- 추천 상품 -------------------------->
		<div class="prd_tab">     
			<div class="title">
				<h2 class="prd_tit">
					MUKSY's PICK <span>
					</span>
				</h2>
				<ul class="tab_menu">
					<li>SOLID</li>
					<li>BODY</li>
					<li>HAIR</li>
				</ul>
			</div>

			<div class="prd_container">
			<!-------------------------- SOLID -------------------------->
				<div class="prd">
				<form>
					<div
						class="xans-element- xans-product xans-product-listmain-5 xans-product-listmain xans-product-5 ec-base-product">

						<ul class="prdList grid3">
							<li id="anchorBoxId_144" class="xans-record-">
								<div class="discount" data-custom="26900" data-price=""></div>
								<div class="thumbnail">
									<div class="prdImg">
										<a href="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=product&musky=product_detail&no=<%=product1.getPNO()%>">
											<img src="<%=request.getContextPath() %>/muskycode/product_images/<%=product1.getPIMGURL()%>"/></a>
									</div>
								</div>
								<div class="description">
									<strong class="name"><a
										href="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=product&musky=product_detail&no=<%=product1.getPNO()%>"
										class=""><span class="title displaynone"><span
												style="font-size: 15px; color: #555555; font-weight: bold;"
												data-i18n=PRODUCT.PRD_INFO_PRODUCT_NAME>상품명</span> :</span> <span
											style="font-size: 15px; color: #555555; font-weight: bold;"><%=product1.getPNAME() %></span></a></strong>
									<ul class="xans-element- xans-product xans-product-listitem-5 xans-product-listitem xans-product-5 spec">
										<li class=" display판매가 xans-record-"><strong
											class="displaynone"><span
												style="font-size: 17px; color: #333333; font-weight: bold;"
												data-i18n=PRODUCT.PRD_INFO_PRODUCT_PRICE>판매가</span> :</strong> <span
											style="font-size: 17px; color: #333333; font-weight: bold;"><%=DecimalFormat.getInstance().format(product1.getPPRICE()) %>원</span><span
											id="span_product_tax_type_text" style=""> </span></li>
										<li class=" display xans-record-"><strong
											class="displaynone"> :</strong></li>
									</ul>
								</div>
							</li>
						</ul>
					</div>
					</form>
				</div>
				<!-------------------------- BODY -------------------------->
				<div class="prd">
				<form>
					<div class="xans-element- xans-product xans-product-listmain-6 xans-product-listmain xans-product-6 ec-base-product">
						<ul class="prdList grid3">
							<li id="anchorBoxId_125" class="xans-record-">
								<div class="discount" data-custom="38000" data-price=""></div>
								<div class="thumbnail">
									<div class="prdImg">
										<a
											href="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=product&musky=product_detail&no=<%=product42.getPNO()%>"
											name="no"><img
											src="<%=request.getContextPath() %>/muskycode/product_images/<%=product42.getPIMGURL() %>"
											id="no" /></a>
									</div>
								</div>
								<div class="description">
									<strong class="name"><a
										href="product/%eb%a6%ac%ec%96%bc-%ed%8d%bc%ed%93%b8-%ec%83%b4%ed%91%b8-%eb%8b%a4%eb%a7%88%ec%8a%a4%ed%81%ac-%eb%a1%9c%ec%a6%88-1000ml/125/category/1/display/7/index.html"
										class=""><span class="title displaynone"><span
												style="font-size: 15px; color: #555555; font-weight: bold;"
												data-i18n=PRODUCT.PRD_INFO_PRODUCT_NAME>상품명</span> :</span> <span
											style="font-size: 15px; color: #555555; font-weight: bold;"><%=product42.getPNAME()%></span></a></strong>
									<ul
										class="xans-element- xans-product xans-product-listitem-6 xans-product-listitem xans-product-6 spec">
										<li class=" display판매가 xans-record-"><strong
											class="displaynone"><span
												style="font-size: 16px; color: #333333; font-weight: bold;"
												data-i18n=PRODUCT.PRD_INFO_PRODUCT_PRICE>판매가</span> :</strong> <span
											style="font-size: 16px; color: #333333; font-weight: bold;"><%=DecimalFormat.getInstance().format(product42.getPPRICE()) %>원</span><span
											id="span_product_tax_type_text" style=""> </span></li>
										<li class=" display xans-record-"><strong
											class="displaynone"> :</strong></li>
									</ul>
								</div>
							</li>
						</ul>
					</div>
					</form>
				</div>
				<!-------------------------- HAIR -------------------------->
				<div class="prd">
					<form>
					<div class="xans-element- xans-product xans-product-listmain-6 xans-product-listmain xans-product-6 ec-base-product">
						<ul class="prdList grid3">
							<li id="anchorBoxId_125" class="xans-record-">
								<div class="discount" data-custom="38000" data-price=""></div>
								<div class="thumbnail">
									<div class="prdImg">
										<a
											href="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=product&musky=product_detail&no=<%=product4.getPNO() %>"
											name="no"><img
											src="<%=request.getContextPath() %>/muskycode/product_images/<%=product1.getPIMGURL() %>"
											id="no" /></a>
									</div>
								</div>
								<div class="description">
									<strong class="name"><a
										href="product/%eb%a6%ac%ec%96%bc-%ed%8d%bc%ed%93%b8-%ec%83%b4%ed%91%b8-%eb%8b%a4%eb%a7%88%ec%8a%a4%ed%81%ac-%eb%a1%9c%ec%a6%88-1000ml/125/category/1/display/7/index.html"
										class=""><span class="title displaynone"><span
												style="font-size: 15px; color: #555555; font-weight: bold;"
												data-i18n=PRODUCT.PRD_INFO_PRODUCT_NAME>상품명</span> :</span> <span
											style="font-size: 15px; color: #555555; font-weight: bold;"><%=product4.getPNAME()%></span></a></strong>
									<ul
										class="xans-element- xans-product xans-product-listitem-6 xans-product-listitem xans-product-6 spec">
										<li class=" display판매가 xans-record-"><strong
											class="displaynone"><span
												style="font-size: 16px; color: #333333; font-weight: bold;"
												data-i18n=PRODUCT.PRD_INFO_PRODUCT_PRICE>판매가</span> :</strong> <span
											style="font-size: 16px; color: #333333; font-weight: bold;"><%=DecimalFormat.getInstance().format(product4.getPPRICE()) %>원</span><span
											id="span_product_tax_type_text" style=""> </span></li>
										<li class=" display xans-record-"><strong
											class="displaynone"> :</strong></li>
									</ul>
								</div>
							</li>
						</ul>
					</div>
					</form>
				</div>
			</div>
		</div>

	<img src="<%=request.getContextPath() %>/muskycode/images/sub_1.png" style="position:relative; left: 90px;"><br><br>
	</div>
</div>
