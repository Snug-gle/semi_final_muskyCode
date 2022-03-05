<%@page import="muskycode.dao.MemberDAO"%>
<%@page import="muskycode.dao.ProductDAO"%>
<%@page import="muskycode.dto.ProductDTO"%>
<%@page import="muskycode.dao.OrderDAO"%>
<%@page import="muskycode.dto.OrderDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@include file="/muskycode/security/admin_check.jspf"%>   
    
    <%
  //비정상적인 요청에 대한 응답 처리
    if (request.getParameter("orderGroupNo") == null) {
    	out.println("<script type='text/javascript'>");
    	out.println("location.href='" + request.getContextPath() + "/muskycode/index.jsp?muskygroup=error&musky=error400';");
    	out.println("</script>");
    	return;
    }
    
    if (request.getParameter("orderNo") == null) {
    	out.println("<script type='text/javascript'>");
    	out.println("location.href='" + request.getContextPath() + "/muskycode/index.jsp?muskygroup=error&musky=error400';");
    	out.println("</script>");
    	return;
    }
    
    // 그룹번호 받아 저장
    int orderGroupNo = Integer.parseInt(request.getParameter("orderGroupNo"));
    
    // 주문 번호를 받아 저장
    int orderNo = Integer.parseInt(request.getParameter("orderNo"));
    
    // 그룹번호를 전달받아 ORDER 테이블에 저장된 제품 정보 배열을 검색하여
    // 반환하는 DAO 메소드 호출
    List<OrderDTO> orderList = OrderDAO.getDAO().selectGroupList(orderGroupNo);
    
  //검색된 주문건이 없는 경우 => 비정상적인 요청에 대한 응답 처리
    if (orderList == null) {
    	out.println("<script type='text/javascript'>");
    	out.println(
    	"location.href='" + request.getContextPath() + "/muskycode/index.jsp?muskygroup=error&musky=error400';");
    	out.println("</script>");
    	return;
    }
  
  	// 머가 더 필요한지 생각해보자
  
     %>
<hr class="layout"/>

<div id = "review_title"  class="titleArea">
		<h2 style="color: blue;">ORDER INFORMATION</h2>
</div>


<div class="ec-base-table typeList gBorder">
<table border="1" summary="" style="width: 1400px; position: relative; left: 3%; bottom:20px;">
		<thead class="xans-element- xans-board xans-board-listheader-1002 xans-board-listheader xans-board-1002 ">
		<tr id="ReviewColumn">
			<th width = "100">주문 번호</th>
			<th width = "100">상품 번호</th>
			<th width = "300">상품 이미지</th>
			<th width="150">주문 상태</th>
			<th width="400">주문 일자</th>
			<th width="100">주문 수량</th>
			<th width="150">결제 방식</th>
			<th width="150">주문자</th>
			<th width="300">아이디</th>
			<th width="300">전화 번호</th>
			<th width="1000">배송 주소</th>
			
		</tr></thead>
		<tbody class="xans-element- xans-board xans-board-list-1002 xans-board-list xans-board-1002 center">
		
		<% for (OrderDTO order : orderList) { 
			ProductDTO product = ProductDAO.getDAO().selectNumProduct(order.getPNO());
			MemberDTO member = MemberDAO.getDAO().selectIdMember(order.getMID());%>
		<tr>
			<%-- 주문 번호 출력 : 주문 테이블 번호--%>
			<td><%=order.getONO() %></td>
			
			<%-- 상품 번호 출력 : ㄹㅇ 상품 번호--%>
			<td><%=order.getPNO() %>
			
			<%-- 상품 이미지 출력 하자 : 주문 번호로 얻은 객체로 --%>
			<td><img src = "<%=request.getContextPath() %>/muskycode/product_images/<%=product.getPIMGURL()%>"
			width = "200"></img></td>
			
			<%--주문 상태 : ㄹㅇ 주문 상태 출력 이프문 돌려서 출력 --%>
			<% if(order.getOSTATUS() == 1 ) { %>
			<td>입금 대기</td>
			<% } else if(order.getOSTATUS() == 2) { %>
			<td>배송 준비</td>
			<% } else if(order.getOSTATUS() == 3) { %>
			<td>배송 중</td>
			<% } else if(order.getOSTATUS() == 4) { %>
			<td>배송 완료</td>
			<% } else if(order.getOSTATUS() == 5) { %>
			<td>환불 요청</td>
			<% } else if(order.getOSTATUS() == 6) { %>
			<td>환불 완료</td> <%} %>
			
			
			<%-- 결제 일자 출력 --%>
			<td><%=order.getODATE() %></td>
			
			<%-- 주문 수량 출력 --%>
			<td><%=order.getOQUANTITY()%></td>
			
			<%-- 결제 방식 출력 --%>
			<td><%=order.getOPAYMENT() %></td>
			
			<%-- 주문자 이름 출력 --%>
			<td><%=order.getONAME() %></td>		
			
			<%-- 주문자 아이디 출력 --%>
			<td><%=order.getMID() %></td>
			
			<%-- 주문자 전화 번호 출력 --%>
			<td><%=order.getOPHONE() %></td>
			
			<%-- 배송 주소 출력 --%>
			<td><%=order.getOZIP() %>&nbsp;<%=order.getOADDRESS1()%>&nbsp;<%=order.getOADDRESS2()%></td>
		</tr>
		<%} %>
		</tbody>
	</table>
	
	<p>
	<br><br>
	<button type="button" id="modifyBtn" class="btn_black">주문 정보 변경</button>
	<button type="button" id="listBtn" class="btn_black">주문 목록</button>
	</p>
	
	<div>그룹 번호 [<%=orderGroupNo %>]</div>
</div>

<script type="text/javascript">
	$("#modifyBtn").click(function() {
		location.href = "<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=order_modify&orderGroupNo=<%=orderGroupNo%>&orderNo=<%=orderNo%> ";
	});
	
	$("#listBtn").click(function() {
		location.href = "<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=order_manage";

	});
</script>