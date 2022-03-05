<%@page import="muskycode.dao.MemberDAO"%>
<%@page import="muskycode.dao.ProductDAO"%>
<%@page import="muskycode.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="muskycode.dao.OrderDAO"%>
<%@page import="muskycode.dto.OrderDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 그룹정보를 전달받아 ORDER 테이블에 저장된 제품정보를 변경하고 제품정보 출력페이지
(ORDER_detail.jsp)로 이동하는 JSP 문서 --%>
<%-- => 관리자만 JSP 문서를 요청하여 처리되도록 권한 설정 --%>
<%@include file="/muskycode/security/admin_check.jspf"%>  

<%
	
	//주문 그룹 번호 받기~
	int orderGroupNo = Integer.parseInt(request.getParameter("orderGroupNo"));
	
	//주문 번호 받기
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	
	  // 그룹번호를 전달받아 ORDER 테이블에 저장된 제품 정보 배열을 검색하여
    // 반환하는 DAO 메소드 호출
    List<OrderDTO> orderList = OrderDAO.getDAO().selectGroupList(orderGroupNo);
	  
	  // 주문 번호 전달받아 주문 객체 반환
	OrderDTO orderMan = OrderDAO.getDAO().selectAllOrder(orderNo);
	  
    //검색된 주문건이 없는 경우 => 비정상적인 요청에 대한 응답 처리
    if (orderList == null) {
    	out.println("<script type='text/javascript'>");
    	out.println(
    	"location.href='" + request.getContextPath() + "/muskycode/index.jsp?muskygroup=error&musky=error400';");
    	out.println("</script>");
    	return;
    }

%>

<hr class="layout"/>

<div id = "review_title"  class="titleArea">
		<h2 style="color: blue;">[<%=orderGroupNo %>]번 주문 건 수정</h2>
</div>

<div class="ec-base-table typeList gBorder">
	<form action="<%=request.getContextPath() %>/muskycode/index.jsp?muskygroup=admin&musky=order_modify_action"
		method= "post" id="modifyForm">
		<input type="hidden" name ="orderGroupNo" value="<%=orderGroupNo%>">
		<input type="hidden" name ="orderNo" value="<%=orderNo%>">
	<table border="1" summary="" style="width: 1400px; position: relative; left: 3%; bottom:20px;">
		<thead class="xans-element- xans-board xans-board-listheader-1002 xans-board-listheader xans-board-1002 ">
		<tr id="ReviewColumn">
			<th width="100">주문 상태</th>
			<th width="200">결제 방식</th>
			<th width="250">전화 번호</th>
			<th width="200">우편 번호</th>
			<th width="200">배송 주소</th>
			<th width="200">상세 주소</th>
		</tr></thead>
		<tbody class="xans-element- xans-board xans-board-list-1002 xans-board-list xans-board-1002 center">

		<tr>
			<td>
				<input type="hidden" id="statval" name="statval" value="<%= orderMan.getOSTATUS()%>">
				<select id="orderStatus" name ="orderStatus">
					<option value="1" selected="selected">&nbsp;입금 대기&nbsp;</option>
					<option value="2" >&nbsp;배송 대기&nbsp;</option>
					<option value="3" >&nbsp;배송 중&nbsp;</option>
					<option value="4" >&nbsp;배송 완료&nbsp;</option>
					<option value="5" >&nbsp;환불 요청&nbsp;</option>
					<option value="6" >&nbsp;환불 완료&nbsp;</option>
				</select>
			</td>
			
			<%-- 결제 방식 출력 --%>
			<td><%=orderMan.getOPAYMENT() %></td>	
			
			<%-- 주문자 전화 번호 변경 텍스트 --%>
			<td>
			<input type="hidden" id="phoneval" name="phoneval" value="<%= orderMan.getOPHONE().substring(0, 3)%>">
				<select id="mobile" name="mobile1">
					<option value="010" selected="selected" >&nbsp;010&nbsp;</option>
					<option value="011">&nbsp;011&nbsp;</option>
					<option value="016">&nbsp;016&nbsp;</option>
					<option value="017">&nbsp;017&nbsp;</option>
					<option value="018">&nbsp;018&nbsp;</option>
					<option value="019">&nbsp;019&nbsp;</option>
				</select>
				- <input type="text" placeholder ="<%=orderMan.getOPHONE().substring(4,8) %>" style="border: 0;" name="mobile2" id="mobile2" size="4" maxlength="4"
					value ="<%=orderMan.getOPHONE().substring(4,8) %>">
				- <input type="text" placeholder ="<%=orderMan.getOPHONE().substring(9) %>" style="border: 0;" name="mobile3" id="mobile3" size="4" maxlength="4"
					value ="<%=orderMan.getOPHONE().substring(9) %>">
			</td>
			
			<%-- 우편번호 --%>
			<td>
				<input type="text" name="zipcode" id="zipcode" size="7" readonly="readonly"  value="<%= orderMan.getOZIP()%>" style="border: 0; text-align: right;">
				<span id="postSearch" id="postSearch" style="background: black; color: white; border-radius: 15px;" >우편번호 검색</span>
			</td>

			<%-- 배송 주소 --%>
			<td>
				<input type="text" name="address1" id="address1" size="50" readonly="readonly" style="border: 0; text-align: center;" value="<%= orderMan.getOADDRESS1()%>">
			</td>

			<%-- 상세 주소 --%>
			<td>
				<input type="text" name="address2" id="address2" size="50" style="border: 0; text-align: center;" value="<%= orderMan.getOADDRESS2()%>">
			</td>

		</tr>
		</tbody>
	</table>
	<br><br>
	<div>
		<button type="submit" class="btn_black">주문 정보 변경</button>
		<button type="reset" id="resetBtn" class="btn_black">다시쓰기</button>
	</div>
	<br>
	<div>그룹 번호 [<%=orderGroupNo %>]</div>
	</form>
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

// 넘어온 배송상태대로 셀렉트 기본 값.
$("#orderStatus").val($("#statval").val()).prop("selected",true);
 
// 넘어온 폰 상태로 셀렉트 기본 값.
$("#mobile").val($("#phoneval").val()).prop("selected",true);

// 우편 번호 버튼 눌렀을 때
$("#postSearch").click(function() {
	new daum.Postcode({
		oncomplete: function(data) {
			var addr = ''; // 주소 변수
			
			if (data.userSelectedType === 'R' || data.userSelectedType === 'J') {
				addr = data.roadAddress;
			
			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById("zipcode").value = data.zonecode;
			document.getElementById("address1").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("address2").focus();
			}
		}
	}).open();
});
</script>
	
