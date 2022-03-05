<%@page import="muskycode.dao.ProductDAO"%>
<%@page import="muskycode.dao.MemberDAO"%>
<%@page import="muskycode.dto.OrderDTO"%>
<%@page import="java.util.List"%>
<%@page import="muskycode.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/muskycode/security/admin_check.jspf"%>   
    <%
  //검색 관련 정보를 반환받아 저장
  	String search = request.getParameter("search");

  	if (search == null)
  		search = ""; // 값이 없으면 검색안함
  	
  	String keyword = request.getParameter("keyword");
  	if (keyword == null) {
  		keyword = ""; //값이 없으면 검색안함
  	}

	// 상품명을 전달받아 상품번호로 바꿔주기
  	if(search.equals("pno")){
  		keyword = String.valueOf(ProductDAO.getDAO().selectNameProduct(keyword).getPNO());
  	
  	}
  	
 	// 구매자 명을 전달받아 구매자 아이디로 바꿔주기 
   	if(search.equals("mid")){
  		keyword = MemberDAO.getDAO().selectNameMember(keyword).getMID();

   	}
  	
  	//페이지 번호 반환받아 저장
  	int pageNum = 1; // 전달값 없으면 1페이지
  	if (request.getParameter("pageNum") != null) { // 전달값이 있는 경우 해당 페이지 
  		pageNum = Integer.parseInt(request.getParameter("pageNum"));
  	}
  	
  //하나의 페이지에 출력될 게시글 갯수 설정
  	int pageSize = 10;
  
  	// 테이블 전체 주문 건수 반환
  	int totalOrder = OrderDAO.getDAO().selectOrderCount(search, keyword);

  	//페이지 갯수 계산
  	int totalPage = (int) Math.ceil((double) totalOrder / pageSize);
  	
  	//게시글 시작 글번호 
  	int number = totalOrder - (pageNum - 1) * pageSize;
  	
 	//전달된 페이지 번호에 검증
  	if (pageNum <= 0 || pageNum > totalPage) { // 페이지 번호가 잘못되면 1페이지로 이동
  		pageNum = 1;
  	}

  	//페이지 시작행번호
  	int startRow = (pageNum - 1) * pageSize + 1;

  	// 페이지 종료 행번호
  	int endRow = pageNum * pageSize;

  	//페이지 종료 행번호 게시글 갯수로 변경
  	if (endRow > totalOrder) {
  		endRow = totalOrder;
  	}
  	
 	 //카테고리를 전달받아 NOTICE 테이블에 저장된 해당 카테고리의 주문정보를 검색하여 
  	//반환하는 DAO 클래스의 메소드 호출
  	List<OrderDTO> orderList = OrderDAO.getDAO().selectOrderList(startRow, endRow, search, keyword);

    %>


<hr class="layout"/>

<div id="board_list" class="titleArea" >
		<div id="board_title"><h2 style="color: blue;">ORDER MANAGE</h2></div>
</div>
<div class="ec-base-table typeList gBorder">
		 <table border="1" summary="" style="width: 1300px; position: relative; left:6%; top:10px;">
			<thead class="xans-element- xans-board xans-board-listheader-1002 xans-board-listheader xans-board-1002 ">
				<tr style=" ">
					<th width="100">번호</th>
					<th width="100">주문 상태</th>
					<th width="100">주문 번호</th>
					<th width="150">주문자</th>
					<th width="150">주문자 아이디</th>
					<th width="300">주문 일자</th> 
					<th width="300">결제 방식</th>
					<th width="200">주문 그룹</th>
					<th width="150">주문 세부 정보</th>
				</tr></thead>
		<tbody class="xans-element- xans-board xans-board-list-1002 xans-board-list xans-board-1002 center">
			<% if (totalOrder == 0) { %>
			<tr>
				<td colspan="9">검색된 주문 정보가 존재하지 않습니다.</td>
			</tr>
			<% } else { %>
			<%-- 검색된 주문 정보 목록에서 게시글을 하나씩 제공 받아 응답 (반복)--%>
			<% for (OrderDTO order : orderList) {
				MemberDTO member = MemberDAO.getDAO().selectIdMember(order.getMID()); // 아이디 통해서 해당 멤버 객체 받기%>					
			<tr>
				<%-- 글번호 : ORDER 테이블에 저장된 글번호가 아닌 계산된 글번호 출력 --%>
				<td><%=number%></td>
				
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
				
				<%-- 주문 번호 출력 : 주문 테이블 번호--%>
				<td><%=order.getONO() %></td>
				
				<%-- 주문자 이름 출력 : 멤버 객체 이용--%>
				<td><%=member.getMNAME() %></td>
				
				<%-- 주문자 아이디 출력--%>
				<td><%=order.getMID() %></td>
				
				<%-- 주문 일자 출력 : 주문 테이블 날짜 데이터--%>
				<td><%=order.getODATE() %></td>
				
				<%-- 주문 결제 방식 출력 : 주문 테이블 결제 방식--%>
				<td><%=order.getOPAYMENT() %></td>
							
				<%-- 주문 그룹 번호 출력 : 주문 테이블 그룹 번호--%>
				<td><%=order.getOGROUP() %></td>
				
				<%-- 세부 정보 버튼으로 그룹번호와 주문번호를 쿼리 스트링으로 넘김. --%>
				<td class="order_info">
					<button type="button" id="infoBtn" class="" style="background: black; color: white; border-radius: 15px;"
					onclick="location.href='<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=order_detail&orderGroupNo=<%=order.getOGROUP()%>&orderNo=<%=order.getONO()%>';">세부 정보</button>
				</td>
			</tr>
			<%-- 출력 글번호의 변수값 1 감소 --%>
			<% number--;%>
			<% } %>
			<% } %>
		</tbody>
	</table>	
 </div>
 
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
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=order_manage&pageNum=1">[처음]</a>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=order_manage&pageNum=<%=startPage - blockSize%>">[이전]</a>
	<% } else {//시작 페이지 번호가 blockSize 변수값을 초과하지 않을 경우 링크 미설정 %>
	[처음][이전]
	<% } %>

	<%for (int i = startPage; i <= endPage; i++) {%>
	<%if (pageNum != i) {//요청 페이지 번호와 출력 페이지 번호가 같지 않은 경우 링크 설정 %>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=order_manage&pageNum=<%=i%>">[<%=i%>]
	</a>
	<% } else {//요청 페이지 번호와 출력 페이지 번호가 같을 경우 링크 미설정%>
	[<%=i%>]
	<% } %>
	<% } %>

	<% if (endPage != totalPage) {//종료 페이지 번호와 전체 페이지 갯수가 같지 않은 경우 링크 설정 %>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=order_manage&pageNum=<%=startPage + blockSize%>">[다음]</a>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=order_manage&pageNum=<%=totalPage%>">[마지막]</a>
	<% } else {//종료 페이지 번호와 전체 페이지 갯수가 같은 경우 링크 미설정 %>
	[다음][마지막]
	<% } %>
	
	<%-- 게시글 검색 기능 제공 --%>
	<form action="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=order_manage" method="post">
		<%-- select 태그에 의해 입력되어 전달되는 값은 비교 컬럼명과 동일하게 설정 --%>
		<select name="search">
			<option value="pno" selected="selected">&nbsp;상품명&nbsp;</option>
			<option value="mid">&nbsp;주문자&nbsp;</option>
		</select> 
		<input type="text" name="keyword">
		<button type="submit" class="btn_black">검색</button>
	</form>