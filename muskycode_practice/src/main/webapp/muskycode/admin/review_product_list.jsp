<%@page import="muskycode.dao.ProductDAO"%>
<%@page import="java.util.List"%>
<%@page import="muskycode.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/muskycode/security/login_check.jspf" %>

<%
	// 쿼리 스트링으로 넘겨받은 주문 그룹 번호
	int orderGroupNo = Integer.parseInt(request.getParameter("orderGroupNo"));
	
	// 주문 번호로 해당 주문 상품 번호 리스트 출력하는 메소드
	List<Integer> pnoList = OrderDAO.getDAO().selectGroupNoPnoList(orderGroupNo);
	
	//전달된 페이지 번호를 반환받아 저장 => 전달값이 존재하지 않을 경우 첫번째 페이지 검색
	int pageNum = 1;
	if (request.getParameter("pageNum") != null) {//전달값이 있는 경우
		pageNum = Integer.parseInt(request.getParameter("pageNum"));
	}
	
	//하나의 페이지에 출력될 게시글 갯수 설정
	int pageSize = 10;
%>

<style type="text/css">
#order_list {
	width: 1000px;
	margin: 0 auto;
	text-align: center;
}

#order_title {
	font-size: 1.2em;
	font-weight: bold;
	font-color : blue;
}

#btn {
	font-style:inherit;
	font-weight:bold;
	text-align: right;
	font-color: blue;
}

button {
	color:white;
	font-style:inherit;
	font-weight:bold;
	background-color: black;
}

table {
	margin: 5px auto;
	border: 1px solid red;
	border-collapse: collapse;
}

th {
	border: 1px solid black;
	background-color: red;
	color: black;
}

td {
	border: 1px solid black;
	text-align: center;
}


#order_list a:hover {
	text-decoration: none;
	color: blue;
}
img {
	width: 100px;
	height: auto;

}
</style>

<div id="order_list">
<div id="order_title">
	<h1>주문 상품 리스트</h1>
</div>
<br><br>
<div>
	<table border="1">
		<tr>
			<th>상품 번호</th>
			<th>상품 이미지</th>
			<th>구매 수량</th>
			<th>결제 금액</th>
			<th>결제 방식</th>
			<th>주문 상태</th>
			<th>리뷰 작성</th>
		</tr>
		<% for(int pno : pnoList) {%>
		<tr>
			<td><%=pno %></td>
			
			<td><img src="<%=request.getContextPath() %>/muskycode/product_images/<%=ProductDAO.getDAO().selectNumProduct(pno).getPIMGURL()%>">
			</td>
			
			<td>
			<%=OrderDAO.getDAO().selectOrderPno(pno, orderGroupNo).getOQUANTITY()%>
			</td>
			
			<td>
			<%=ProductDAO.getDAO().selectNumProduct(pno).getPPRICE()*OrderDAO.getDAO().selectOrderPno(pno, orderGroupNo).getOQUANTITY() %>
			</td>
			
			<%-- 결제 방식 --%>
			<% if(OrderDAO.getDAO().selectOrderPno(pno, orderGroupNo).getOPAYMENT().equals("card")){%>
			<td>card</td>
			<% } else if(OrderDAO.getDAO().selectOrderPno(pno, orderGroupNo).getOPAYMENT().equals("account")){ %>
			<td>account</td>
			<% } else if(OrderDAO.getDAO().selectOrderPno(pno, orderGroupNo).getOPAYMENT().equals("deposit")){ %>
			<td>deposit</td> <%} %>

			<%--주문 상태 : ㄹㅇ 주문 상태 출력 이프문 돌려서 출력 --%>
			<% if(OrderDAO.getDAO().selectOrderPno(pno, orderGroupNo).getOSTATUS() == 1 ) { %>
			<td>입금 대기</td>
			<% } else if(OrderDAO.getDAO().selectOrderPno(pno, orderGroupNo).getOSTATUS() == 2) { %>
			<td>배송 준비</td>
			<% } else if(OrderDAO.getDAO().selectOrderPno(pno, orderGroupNo).getOSTATUS() == 3) { %>
			<td>배송 중</td>
			<% } else if(OrderDAO.getDAO().selectOrderPno(pno, orderGroupNo).getOSTATUS() == 4) { %>
			<td>배송 완료</td>
			<% } else if(OrderDAO.getDAO().selectOrderPno(pno, orderGroupNo).getOSTATUS() == 5) { %>
			<td>환불 요청</td>
			<% } else if(OrderDAO.getDAO().selectOrderPno(pno, orderGroupNo).getOSTATUS() == 6) { %>
			<td>환불 완료</td> <%} %>
			
			<%-- 배송 완료된 상품만 쓸 수 있게 --%>
			<%if((OrderDAO.getDAO().selectOrderPno(pno, orderGroupNo).getOSTATUS() == 4)) {%>
			<td>
				<button class="" onclick="location.href='<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=review_write&orderGroupNo=<%=orderGroupNo%>&pno=<%=pno%>';">리뷰 작성</button>
			</td>
			<%}else { %>
			<td>
				작성 불가	
			</td>	
			<%} %>
		<%} %>
	</table>
</div>
</div>