<%@page import="muskycode.dto.MemberDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="muskycode.dto.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@page import="muskycode.dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//검색 관련 정보를 반환받아 저장
String search = request.getParameter("search");
if (search == null)
	search = ""; // 값이 없으면 검색안함

String keyword = request.getParameter("keyword");
if (keyword == null)
	keyword = ""; //값이 없으면 검색안함

//페이지 번호 반환받아 저장
int pageNum = 1; // 전달값 없으면 1페이지
if (request.getParameter("pageNum") != null) { // 전달값이 있는 경우 해당 페이지 
	pageNum = Integer.parseInt(request.getParameter("pageNum"));
}

//하나의 페이지에 출력될 게시글 갯수 설정
int pageSize = 10;

//테이블 전체 게시물수 반환
int totalNotice = NoticeDAO.getDAO().selectNoticeCount(search, keyword);
//페이지 갯수 계산
int totalPage = (int) Math.ceil((double) totalNotice / pageSize);

//전달된 페이지 번호에 검증
if (pageNum <= 0 || pageNum > totalPage) { // 페이지 번호가 잘못되면 1페이지로 이동
	pageNum = 1;
}

//페이지 시작행번호
int startRow = (pageNum - 1) * pageSize + 1;

// 페이지 종료 행번호
int endRow = pageNum * pageSize;

//페이지 종료 행번호 게시글 갯수로 변경
if (endRow > totalNotice) {
	endRow = totalNotice;
}
//공지사항 테이블에 저장된 게시글 검색하여 반환
List<NoticeDTO> noticeList = NoticeDAO.getDAO().selectNoticeList(startRow, endRow, search, keyword);


//세션에 저장된 권한 관련 정보(회원정보 - MemberDTO)를 반환받아 저장
	// => 로그인 사용자에게만 글쓰기 권한 제공
	// => 비밀 게시글인 경우 로그인 사용자가 게시글 작성자 또는 관리자인 경우에만 접근 권한 제공
MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");

//게시글 시작 글번호 
int number = totalNotice - (pageNum - 1) * pageSize;

//시스템의 현재 날짜를 반환받아 저장
// => 게시글 작성일을 현재 날짜와 비교하여 구분 출력
String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
%>

<hr class="layout"/>

	<div id="notice_title"  class="titleArea" >
		<h2>NOTICE</h2>
<%-- 		(게시글 갯수 :<%=totalNotice%>) --%>
	</div>

<div class="ec-base-table typeList gBorder">
        <table border="1" summary="" style="width: 1000px; position: relative; left: 15%; bottom:20px;">
			<thead class="xans-element- xans-board xans-board-listheader-1002 xans-board-listheader xans-board-1002 ">
				<tr style=" ">
					<th width= "100"> 번호</th>
                    <th width= "500">제목</th>
                    <th width= "200">작성일</th>
                    <th width= "100">조회수</th>
                </tr></thead>
			<tbody class="xans-element- xans-board xans-board-list-1002 xans-board-list xans-board-1002 center">
				<% if (totalNotice == 0) { %>
					<tr style="background-color:#FFFFFF; color:#555555;" class="xans-record-">
						<td colspan="5">검색된 게시글이 하나도 없습니다.</td>
					</tr>
				<% } else { %>
				<%-- 검색된 게시글 목록에서 게시글을 하나씩 제공받아 응답 - 반복 --%>
				<% for (NoticeDTO notice : noticeList) { %>
				<tr>
					<td><%=number%></td>
					<td class="subject" style="text-align: left; text-indent: 20px;">
 						<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=notice&musky=notice_detail&num=<%=notice.getNNO()%>&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>"><%=notice.getNTITLE()%></a>
					</td>
					<td>
						<%-- 게시글 작성날짜와 시스템 날짜가 같은 경우 --%> 
						<% if (currentDate.equals(notice.getNDATE().substring(0, 10))) { %> <%=notice.getNDATE().substring(11)%>
						<% } else { //게시글 작성날짜와 시스템 날짜가 다른 경우 %> <%=notice.getNDATE()%> 
						<% } %>
					</td>
                    <td class=""><span class="txtNum"><%=notice.getNHIT()%></span></td>
                </tr>
                <% number--;%>
               	<% } %>
				<% } %>
			</tbody>
	</table>

	<%-- 페이지 번호 출력 및 링크 설정 - 블럭화 처리 --%>
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

	<%if (startPage > blockSize) {//시작 페이지 번호가 blockSize 변수값을 초과한 경우 링크 설정%>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=notice&musky=notice_list&pageNum=1&search=<%=search%>&keyword=<%=keyword%>">[처음]</a>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=notice&musky=notice_list&pageNum=<%=startPage - blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[이전]</a>
	<% } else {//시작 페이지 번호가 blockSize 변수값을 초과하지 않을 경우 링크 미설정 %>
	[처음][이전]
	<% } %>

	<%for (int i = startPage; i <= endPage; i++) {%>
	<%if (pageNum != i) {//요청 페이지 번호와 출력 페이지 번호가 같지 않은 경우 링크 설정 %>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=notice&musky=notice_list&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>">[<%=i%>]
	</a>
	<% } else {//요청 페이지 번호와 출력 페이지 번호가 같을 경우 링크 미설정%>
	[<%=i%>]
	<% } %>
	<% } %>

	<% if (endPage != totalPage) {//종료 페이지 번호와 전체 페이지 갯수가 같지 않은 경우 링크 설정 %>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=notice&musky=notice_list&pageNum=<%=startPage + blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[다음]</a>
	<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=notice&musky=notice_list&pageNum=<%=totalPage%>&search=<%=search%>&keyword=<%=keyword%>">[마지막]</a>
	<% } else {//종료 페이지 번호와 전체 페이지 갯수가 같은 경우 링크 미설정 %>
	[다음][마지막]
	<% } %>
	<br><br>
	<%-- 게시글 검색 기능 제공 --%>
	<form action="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=notice&musky=notice_list" method="post">
		<%-- select 태그에 의해 입력되어 전달되는 값은 비교 컬럼명과 동일하게 설정 --%>
		<select name="search">
			<option value="ntitle" selected="selected">&nbsp;제목&nbsp;</option>
			<option value="ncontent">&nbsp;내용&nbsp;</option>
		</select> 
		<input type="text" name="keyword">
		<button type="submit" class="btn_black">검색</button>
	</form>
</div>



