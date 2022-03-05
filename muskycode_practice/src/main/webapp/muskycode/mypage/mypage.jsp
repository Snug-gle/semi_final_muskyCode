<%@page import="muskycode.dao.OrderDAO"%>
<%@page import="muskycode.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>cdn.jsdelivr.net/npm/xeicon%402.3.3/xeicon.min.css"/>
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400,500,700,900&amp;display=swap&amp;subset=korean" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&amp;display=swap&amp;subset=korean" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&amp;display=swap" rel="stylesheet"/>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/muskycode/design/ind-script/optimizer2260.css?filename=nc1LCoAwDIThfXHrOYLeqC3xAU2mpCno7RW8gHQ7zMdPB4RpWY2qYbcoZNzQLTPl1mgzqFOGCHR6h5n-_DmHhtL9hIaEaxB299FoiTfbGPWYCg9S1FBO5ZCi6td_AA&amp;type=css&amp;k=37c9481ac0212340e132f81eba4d1049fee7f18e&amp;t=1635315871"  />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/muskycode/design/optimizerdeb7.css?filename=tdTBUsQgDAbg-9arzxGd2d3xETx42yegabbEAmEgqH17qXa8eSrc2sJ8HX6SgBVPQDiUTCnDO4fr-XK9PL1ALKNjHKx6B3miYaLMc4C8cHg-A-YMXqbiCPyarUQYKdCd9aGuPEI71YRlFFkas5ImSjc1So1hbzgcIp1ZpWg9d2b88VG8l8bm74e2JuGpvtCpcB9XRZxy7INbcp3kmGp9YKeso5k5HC3i_xM3Yx94LKqtS_rPlq9uabhOQddteEj-pO1hYB8lafcOrwuUWs3N_S--1ObeJujNcowc5sY-SvioBEuI2JquDThLWnsl8sZZG9uZTEL7SmZqd5H7oNvt4S7Jb_Q3&amp;type=css&amp;k=bf01ee659d2189c48cce4de4d62c1c32ce478487&amp;t=1625719215&amp;user=T"  />

<%-- => 비로그인 사용자가 JSP 문서를 요청한 경우 에러페이지로 이동 --%>
<%@include file="/muskycode/security/login_check.jspf" %>
<%
	MemberDTO member = MemberDAO.getDAO().selectIdMember(loginMember.getMID());
	
%>

<style type="text/css">
#container {
	position: relative;
	bottom: 100px;
}
</style>

<hr class="layout" />
<div id="container">
	<div id="container_sub">

		<div class="titleArea">
			<h2>MY SHOP</h2>
		</div>

		<div class="xans-element- xans-layout xans-layout-logincheck ">
		</div>


		<div
			class="xans-element- xans-myshop xans-myshop-asyncbankbook ec-base-box gHalf">
			<ul>
				<li class=""><strong class="title">보유 적립금 </strong><strong class="data"><span
						id="xans_myshop_bankbook_order_price"></span>[<%=member.getMRESERVES() %><span
						id="xans_myshop_bankbook_order_count"></span>원]</strong></strong>
				</li>
				<li><strong class="title">총주문</strong> <strong class="data"><span
						id="xans_myshop_bankbook_order_price"></span>(<%=OrderDAO.getDAO().selectIdOrderCount(member.getMID(),0)%><span
						id="xans_myshop_bankbook_order_count"></span>회)</strong></li>
			</ul>
		</div>

		<div class="xans-element- xans-myshop xans-myshop-orderstate ">
			<div class="title">
				<h3>나의 주문처리 현황</h3>
			</div>

			<div class="state">
				<ul class="order">
					<li><strong>입금 대기</strong> <a
						href="#"
						class="count"><span
							id="xans_myshop_orderstate_shppied_before_count">
							<%=OrderDAO.getDAO().selectIdOrderCount(member.getMID(),1) %>
							</span></a></li>
					<li><strong>배송준비중</strong> <a
						href="#"
						class="count"><span
							id="xans_myshop_orderstate_shppied_standby_count">
							<%=OrderDAO.getDAO().selectIdOrderCount(member.getMID(),2) %>
							</span></a></li>
					<li><strong>배송중</strong> <a
						href="#"
						class="count"><span
							id="xans_myshop_orderstate_shppied_begin_count">
							<%=OrderDAO.getDAO().selectIdOrderCount(member.getMID(),3) %>
							</span></a></li>
					<li><strong>배송완료</strong> <a
						href="#"
						class="count"><span
							id="xans_myshop_orderstate_shppied_complate_count">
							<%=OrderDAO.getDAO().selectIdOrderCount(member.getMID(),4) %>
							</span></a></li>
				</ul>

				<ul class="cs">
					<li><span class="icoDot"></span> <strong>환불 요청 : </strong> <a
						href="#"
						class="count"><span
							id="xans_myshop_orderstate_order_exchange_count"><%=OrderDAO.getDAO().selectIdOrderCount(member.getMID(),5) %>
							</span></a></li>
					<li><span class="icoDot"></span> <strong>환불 완료 : </strong> <a
						href="#"
						class="count"><span
							id="xans_myshop_orderstate_order_return_count"><%=OrderDAO.getDAO().selectIdOrderCount(member.getMID(),6) %>
							</span></a></li>
				</ul>
			</div>
		</div>

		<div id="myshopMain"
			class="xans-element- xans-myshop xans-myshop-main ">
			<ul>
				<li class="shopMain order">
					<h3>
						<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=mypage&musky=my_order"><strong>Order</strong></a>
					</h3>
					<p>
						<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=mypage&musky=my_order">주문내역 조회</a>
					</p>
				</li>
				<li class="shopMain profile">
					<h3>
						<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=mypage&musky=my_modify"><strong>Profile</strong></a>
					</h3>
					<p>
						<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=mypage&musky=my_modify">회원 정보 수정</a>
					</p>
				</li>
				<li class="shopMain board ">
					<h3>
						<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=mypage&musky=my_qna"><strong>Board</strong></a>
					</h3>
					<p>
						<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=mypage&musky=my_qna">내 Q&A</a>
					</p>
				</li>

			</ul>
		</div>
	</div>
	<hr class="layout" />
</div>
<hr class="layout" />
<hr class="layout" />