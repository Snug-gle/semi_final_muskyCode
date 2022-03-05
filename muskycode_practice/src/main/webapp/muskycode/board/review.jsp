<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="muskycode.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="muskycode.dao.ReviewDAO"%>
<%@page import="muskycode.dao.ProductDAO"%>
<%@page import="muskycode.dto.ProductDTO"%>
<%@page import="muskycode.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

String search = request.getParameter("search");
if (search == null) {
	search = ""; // 값이 없으면 검색안함
}
String keyword = request.getParameter("keyword");
if (keyword == null) {
	keyword = ""; //값이 없으면 검색안함
}	
MemberDTO loginmember = (MemberDTO) session.getAttribute("loginMember");

//전달된 페이지 번호를 반환받아 저장 => 전달값이 존재하지 않을 경우 첫번째 페이지 검색
int pageNum = 1;
if (request.getParameter("pageNum") != null) {//전달값이 있는 경우
	pageNum = Integer.parseInt(request.getParameter("pageNum"));
}

//하나의 페이지에 출력될 게시글 갯수 설정
int pageSize = 10;

//리뷰 글 갯수 반환
int totalReview = ReviewDAO.getDAO().selectCountBoard(search,keyword);

//리뷰 게시글 페이지 갯수
int totalPage = (int) Math.ceil((double) totalReview / pageSize);

//현재 페이지 게시글 목록에 출력될 시작 글번호 저장
int number = totalReview - (pageNum - 1) * pageSize;

//페이지 번호 검증
if (pageNum <= 0 || pageNum > totalPage) {
	pageNum = 1;
}

//현재 페이지에 대한 게시글 시작 번호를 계산하여 저장
int startRow = (pageNum - 1) * pageSize + 1;

// 현재 페이지에 대한 게시글 마지막 번호를 계산하여 저장
int endRow = pageNum * pageSize;

//마지막 페이지에 대한 게시글 종료 행번호를 검색 게시글의 갯수로 변경
if (endRow > totalReview) {
	endRow = totalReview;
}

List<ReviewDTO> ReviewList = ReviewDAO.getDAO().SelectAllReview(startRow, endRow, search, keyword);


String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
%>

<hr class="layout"/>

	<div id = "review_title"  class="titleArea">
		<h2>REVIEW</h2>
	</div>

<div class="ec-base-table typeList gBorder">
	<table border="1" summary="" style="width: 1000px; position: relative; left: 15%; bottom:20px;">
			<thead class="xans-element- xans-board xans-board-listheader-1002 xans-board-listheader xans-board-1002 ">		
			<tr id="ReviewColumn">
				<th width= "100">번호</th>
				<th width= "500">제목</th>
				<th width= "100">작성자</th>
				<th width= "200">작성일</th>
				<th width= "100">조회수</th>
			</tr></thead>
			<tbody class="xans-element- xans-board xans-board-list-1002 xans-board-list xans-board-1002 center">
				<% if(totalReview == 0) { %>
					<tr>
						<th colspan="5" >등록된 상품후기가 없습니다 </th>
					</tr>
				<% } else { %>
					<% for(ReviewDTO review:ReviewList) {%>
					<tr>
						<%-- 글번호 --%>
						<td><%=number %> </td>
						
						<%-- 제목 --%>
						<td class="rtitle" style="text-align: left; text-indent: 20px;">
						<% if(review.getRSTATUS()==0) {//삭제 게시글인 경우 %> <span
							class="remove">삭제글</span> 작성자 또는 관리자에 의해 삭제된 게시글입니다. 
							<% }else {%>
						<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=board&musky=review_detail&num=<%=review.getRNO()%>&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>"><%=review.getRTITLE()%></a>
							<%} %>
						</td>
						
						<% if(review.getRSTATUS()!=0) {%>
							<%-- 작성자 --%>
							<td><%=review.getMID() %></td>
							<%-- 작성일 --%>
							<td>
							<%if(currentDate.equals(review.getRDATE().substring(0,10))) { %>
							<%= review.getRDATE().substring(11) %>
							<%} else { %>
							<%=review.getRDATE() %>
							<%}  %>
							
							</td>
							<%-- 조회수 --%>
							<td><%=review.getRHIT() %></td>
						
						<%} else { %>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						
						<%} %>
					</tr>
					<%-- 출력 글 번호의 변수값 1감소 --%>
					<% number--; %>
					<%} %>
				<%} %>
			</tbody>
	</table>


	<%-- 페이지 번호 출력 및 링크 설정 - 블럭화 처리 --%>
	
	<%
	int blockSize = 5;
	
	int startPage = (pageNum -1) / blockSize * blockSize + 1;
	
	int endPage = startPage + blockSize -1;
	
	if(endPage > totalPage) {
		endPage = totalPage;
	}
	%>
	
	
<% if(startPage>blockSize) {//시작 페이지 번호가 blockSize 변수값을 초과한 경우 링크 설정 %>
	<a
		href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=board&musky=review&pageNum=1&search=<%=search%>&keyword=<%=keyword%>">[처음]</a>
	<a
		href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=board&musky=review&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[이전]</a>
	<% } else {//시작 페이지 번호가 blockSize 변수값을 초과하지 않을 경우 링크 미설정 %>
	[처음][이전]
	<% } %>

	<% for(int i=startPage;i<=endPage;i++) { %>
	<% if(pageNum!=i) {//요청 페이지 번호와 출력 페이지 번호가 같지 않은 경우 링크 설정 %>
	<a
		href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=board&musky=review&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>">[<%=i%>]
	</a>
	<% } else {//요청 페이지 번호와 출력 페이지 번호가 같을 경우 링크 미설정 %>
	[<%=i %>]
	<% } %>
	<% } %>

	<% if(endPage!=totalPage) {//종료 페이지 번호와 전체 페이지 갯수가 같지 않은 경우 링크 설정 %>
	<a
		href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=board&musky=review&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[다음]</a>
	<a
		href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=board&musky=review&pageNum=<%=totalPage%>&search=<%=search%>&keyword=<%=keyword%>">[마지막]</a>
	<% } else {//종료 페이지 번호와 전체 페이지 갯수가 같은 경우 링크 미설정 %>
	[다음][마지막]
	<% } %>
	<br><br>
	<%-- 게시글 검색 기능 제공 --%>
	<form
		action="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=board&musky=review"
		method="post">
		<%-- select 태그에 의해 입력되어 전달되는 값은 비교 컬럼명과 동일하게 설정 --%>
		<select name="search">
			<option value="rtitle" selected="selected">&nbsp;제목&nbsp;</option>
			<option value="rcontent">&nbsp;내용&nbsp;</option>
			<option value="mid">&nbsp;작성자&nbsp;</option>
		</select> <input type="text" name="keyword">
		<button type="submit" class="btn_black">검색</button>
	</form>
</div>



