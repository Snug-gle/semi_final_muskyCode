<%@page import="muskycode.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/muskycode/security/admin_check.jspf"%>

<link rel="stylesheet"
	href="//cdn.jsdelivr.net/gh/xpressengine/xeicon@2.3.1/xeicon.min.css">
<link
	href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400,500,700,900&amp;display=swap&amp;subset=korean"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&amp;display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,600;0,700;0,800;1,300;1,400;1,600;1,700;1,800&amp;display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,600;0,700;0,800;1,300;1,400;1,600;1,700;1,800&amp;display=swap"
	rel="stylesheet" />
<%-- <link rel="stylesheet"
	href="<%=request.getContextPath()%>/muskycode/design/swiper.min.css" />
<script
	src="<%=request.getContextPath()%>/muskycode/design/swiper.min.js"></script> --%>
<script
	src="<%=request.getContextPath()%>/muskycode/design/jquery-1.11.2.min.js"></script>
<script
	src="<%=request.getContextPath()%>/muskycode/design/jquery.bpopup-0.10.0.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/muskycode/design/cid.generatecade.js?vs=a8107c4e63cb45f5d57f4101a2b2ef0e"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/muskycode/design/wcslog.js"></script>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/muskycode/design/froala_style_ec.min.css"
	charset="utf-8" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/muskycode/design/optimizerd7b0.css?filename=nZBBCkIxEEP3xa3nCHoEj-ANpnXUD-2kTKegt9edbgTpNuTlQXBnUxyOju68uTS4Dk4vijIGrk4LFLZG272DPf7pa0mDdcZGS5mPRXBGrEqrPNXX0JBcdRFlT3UzTVnMfvqld5wofsH5e-7z8Qs&amp;type=css&amp;k=a052fbc291df183c9caddf6aefc2c6be24ab00a6&amp;t=1635315871" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/muskycode/design/optimizer87c7.css?filename=tdVLbgMhDAbgfei253ArJVGP0EUXlXoCxuMMbgEjDHncvuTRLqruAqthYPRh_TIMOAkEhKYqZYVPjtv1Zrt5eoFUJ89oXAkedCYzk_ISQb84Pq8BVSHIXD2BtyepBdAWWiSfHtrSI3RjQ_WF1Ul6Yy2dbSWb0b2SnSn3olNuT_yxzU5yuIu-lTpZZbzsgxKCxL7mdaKvSbhqL7SqPMYtIq0z0hjckR8k3_pjEG4Xju0cDkrcTmPgqZbSu6V_bTkOS8MPCrp9hnfJBzoPDIckufQ64f9ccpIKS3zPtGc6dK44k7dnfUzEbaHfnf_3V_XhOCWOS2cfJe4b0TJJl_b4Bg&amp;type=css&amp;k=faa19c5b2f2b5f3dc7661027f8e072a4cdad707d&amp;t=1625719215&amp;user=T" />

<div
	style="width: 100%; height: 40px; background-color: #252525; position: fixed; top: 0; z-index: 9999; font-size: 15px;">
	<a href="#"
		style="color: #fff; display: inline-block; width: 100%; text-align: center; line-height: 39px;">MuskiMusky
		관리자 페이지</a>
</div>

<div id="wrap">
	<!----------------------------------------------------------------------
    ** 상단 메뉴 **
    ----------------------------------------------------------------------->
	<div id="header">
		<!-- * CATEGORY SECTION * -->
		<div class="top_fixed">
			<!-- 상단고정 -->
			<div class="cate_section">
				<div class="contents">
					<!-- * LOGO SECTION * -->
					<div class="logo_section">
						<div class="logo_show">
							<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=member_manage"><img
								src="<%=request.getContextPath()%>/muskycode/images/logo.ver1.png" alt="" style="position: relative; left:20px; bottom:12px; width: 110px; height: auto;" /></a>
						</div>
					</div>
					<div class="leftCategory">
						<div id="category"
							class="xans-element- xans-layout xans-layout-category category top_cate sub-category -hover">
							<ul class="position">

								<li class="cate1"><a href="index.jsp?muskygroup=admin&musky=member_manage">회원관리</a></li>

								<li class="cate1 xans-record-"><a href="index.jsp?muskygroup=admin&musky=product_manage">제품관리</a></li>

								<li><a
									href="index.jsp?muskygroup=admin&musky=order_manage">주문관리</a></li>

								<li class="cate1 top_board"><a href="index.jsp?muskygroup=admin&musky=notice_manage"
									class="cateList">게시글관리</a>
									<div
										class="xans-element- xans-layout xans-layout-boardinfo sub-category -hover">
										<ul>
											<li class="xans-record-"><a
												href="index.jsp?muskygroup=admin&musky=notice_manage">공지사항 관리</a></li>
											<li class="xans-record-"><a
												href="index.jsp?muskygroup=admin&musky=review_manage">후기 관리</a></li>
											<li class="xans-record-"><a
												href="index.jsp?muskygroup=admin&musky=qna_manage">상품 Q&A 관리</a></li>
										</ul>
									</div></li>
							</ul>
						</div>
					</div>

					<div class="rightCategory">
						<div class="inner">
							<div class="top_section">
								<div class="contents" style="position: fixed; left:75%;">
									 <ul 
										class="xans-element- xans-layout xans-layout-statelogoff right off ">
										<li style="font-size: 1.2em;">관리자[<%=loginMember.getMNAME()%>]님, 환영합니다.&nbsp;&nbsp;</li>
										<li><a href="index.jsp?muskygroup=member&musky=logout_action" style=" font-size: 1.2em;">로그아웃</a>&nbsp;&nbsp;</li>
										<li><a href="index.jsp" style="font-size: 1.2em;">쇼핑몰</a>&nbsp;&nbsp;</li>
									</ul> 
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- //상단고정 -->
	</div>
	<hr class="layout" />
	<div id="container">
		<div id="contents1"></div>
	</div>

</div>
</div>

<%-- 
<script
	src="<%=request.getContextPath()%>/muskycode/design/optimizer.php?filename=08_Iz03VNzQq0i8oyk8vSszVLy8v18_MS-EqTi7KLCjRz0oFY57czDyerGIA&type=js&k=f8c449ff82a3977059c3195db755507c2666c339&t=1625595315" />
 --%><%-- <script
	src="<%=request.getContextPath()%>/muskycode/design/optimizer.php?filename=zVnbcts2EH23-drvYN12On21pLjN1Ko1lpM8Q-BSggliUVwsM1_fBaU4VmTeQHqm47FEgjgHy8VZ7AJKd1hCevWLSXPDStijKVIDFr3hkD7aVFz9oZJH-1Pa1s8LzXiRPv7rwVTHr1-T35OfByLh2YFRTNpjQ8IRCwFjWbyRUa-QAE9yFQ1VyFHlUnAXRXGV_EZ_UYPTU4fmB79pg1vCn8xuxhw4QR1K6qVcCnxZX3wRbvfwdcEcS0qhBvBIsSEUPNB1N8pqI5TLe9Aj98GsGzTlHJUzKCWYbtxKenut9cyIbNvDHu-E7O6VG6w9dWFREgLVhUN9IYWCiw1Tqo9dBwqOZYmqb-9npigaFUlbG3D9R6lxDkotaV7eBjGt0yVuhIT0_hX-YF-LVxpwJWaemuxe6GED5l7x4NDQL_MUNmWjiPsytBhBUk0_HaLnNYVkXyuJLBsEKr1jYdy7jQXz1DQ5DWCNssqF7C29DHLmpQsusCUzbtaiutBpvUN9MuBNTfM3KximRfhciWeQbVHSQjOvVfKpVSRNUFLkFk11K6wbDL6HHAwoDnNvwne1MoK3mD9DZrITHmpNNqF18NhLcr-w9Ozc8uHZabMVNej_kSszWrmVJSnbsUzArFDbsSwlOJaFPDR0jiwww3eDAtGxPK_OE16n0Vr6raBV9olJQbai-Wb8S0NCF8yOpg3eUZk9pycGTVMG7zfCDqSGd3-PHVPZWWafcgBamwXN8bvx0zruJnOTRM4owRXYnRm-WzA0Tv6BffhfHRLmnQ5pbA0SuIuiOnrk0TZVNgPwb3ix_wvdSVVEYQ8uSD88O8Nqovq-vl2jzNC7qWk7Mlcc6ceSbScnXQhLdWQlqJ6ckPoj0a0pV0g4CE9EaqfVcEPEM2YLmHz6brzKzjLdMNoXwnnLnmAwlbKTEM2EyiYhWsTk8beIPh9Wu0adNOT3b5ViGkq3S90cdb3w_Hh3mdOulLmxlkxF42Mq8dMkEFWPn1Jcx0fxd5K1Qx63ht-KAtKZwT1tx-aM7yCeZUREvsIf32gwzRGXLqgMFjKd-VAfUWOJ0f69hycBe8dkcbyco1cubuPkOY8DyiCxst7ANxOsUHv9w1aZWhLU0PLqS6Yo853A9rCRuO2uonaulKCccALsoAGYrRQ_fEbjSig3bdv4DvidycDwtonsIDgkx_EMur2a6cXRGS4dLCRp2g-NeZclKbO1gOrAL0CjFfHjfxF2174O9yDg7ZHdwUAVE4yA39fwB6SVZj7KjlrZ8YICBbkYK-pbVo2w4U_DsngpXXuHVBkIXtPQyr6PV3U4uKqX1XiKKqS1Y4COm9gTqlFivxVPIIUqUI1T2V8i_HBSTaDXI9MD20zCE7ZIkR7SzO0MSrjscUbQ5ebGc_EGsI5Yxw958JIStmiZzQHg8LT4-6yKHHlhuh3UB0OMNOr0PxpIHXv7TkrC2TvUlyErhav1SP_wE&type=js&k=0e47ff33070ce8a47ef956f01594f400f387c2c2&t=1640155876"></script> --%>
<%-- <script
	src="<%=request.getContextPath()%>/muskycode/design/optimizerbcc4.php?filename=rdBBDoIwEIXhA9St5xhNgHgPTwBl0g50OpVpIdxeMG7cCrt_9b3kgRdGQGuK4qQwUGyquqlvD0ilC2SNzxxAezQ9KrkIOlK8VzAosPQlIIR2lZLBthmdTOtl0Cv8iX6prlWy-8InjoAL7mGIk0z5FHEzrDBLPIj8nvcqZEczEy6nslxCJvWSnp5Soug2_Q0&amp;type=js&amp;k=4fb711b20c2f4a79133dbb50994a2b5e0477bb44&amp;t=1617079217&amp;user=T"></script> --%>