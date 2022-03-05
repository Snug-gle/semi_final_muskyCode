<%@page import="muskycode.dto.MemberDTO"%>
<%@page import="muskycode.dto.QnaDTO"%>
<%@page import="muskycode.dao.QnaDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	//검색 관련 전달값을 반환받아 저장
	String search=request.getParameter("search");
	if(search==null) {//전달값이 없는 경우
		search="";
	}
	
	String keyword=request.getParameter("keyword");
	if(keyword==null) {
		keyword="";
	}

	//JSP 문서를 요청하여 전달된 페이지 번호를 반환받아 저장
	// => 페이지 번호 전달값이 없는 첫번째 페이지의 게시글 목록 응답
	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {//전달값이 있는 경우
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	System.out.println("pageNum = "+ pageNum);
	
	//하나의 페이지에 검색될 게시글의 갯수 설정 - 전달값 이용 가능 
	int pageSize=10;
	
	
	//QNA 테이블에 저장된 게시글 중 검색어 포함된 게시글의 갯수를 검색하여 반환하는 DAO 클래스의 메소드 호출
	// => 검색 기능 구현
	int totalQna=QnaDAO.getDAO().selectQnaCount(search, keyword);
	
	//전체 페이지의 갯수를 계산하여 저장
	//int totalPage=totalBoard/pageSize+totalBoard%pageSize==0?0:1;
	int totalPage=(int)Math.ceil((double)totalQna/pageSize);

	//요청 페이지에 출력될 게시글에 대한 글번호 시작값을 계산하여 저장
	//ex) 검색 게시글의 갯수 : 100 >> 1Page : 100~91, 2Page : 90~81, 3Page : 80~71,
	int number=totalQna-(pageNum-1)*pageSize;

	//요청 페이지 번호에 대한 검증
	if(pageNum<=0 || pageNum>totalPage) {//전달된 페이지 번호가 비정상적인 경우
		pageNum=1;
	}
	
	//요청 페이지 번호에 대한 게시글 시작 행번호를 계산하여 저장
	//ex) 1Page : 1, 2Page : 11, 3Page : 21, 4Page : 31, ...
	int startRow=(pageNum-1)*pageSize+1;
	
	//요청 페이지 번호에 대한 게시글 종료 행번호를 계산하여 저장
	//ex) 1Page : 10, 2Page : 20, 3Page : 30, 4Page : 40, ...
	int endRow=pageNum*pageSize;

	//마지막 페이지에 대한 게시글 종료 행번호를 전달 게시글의 갯수로 변경
	if(endRow>totalQna) {
		endRow=totalQna;
	}
	
	//요청 페이지에 대한 게시글 시작 행번호와 게시글 종료 행번호를 전달받아 BOARD 테이블에 저장된
	//해당 행범위의 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	List<QnaDTO> qnaList=QnaDAO.getDAO().SelectQnaList(startRow, endRow, search, keyword);
	
	//세션에 저장된 권한 관련 정보(회원정보 - MemberDTO)를 반환받아 저장
	// => 로그인 사용자에게만 글쓰기 권한 제공
	// => 비밀 게시글인 경우 로그인 사용자가 게시글 작성자 또는 관리자인 경우에만 접근 권한 제공
	 MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	
	//시스템의 현재 날짜를 반환받아 저장
	// => 게시글 작성일을 현재 날짜와 비교하여 구분 출력
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
%>

<hr class="layout"/>

	<div id="board_list" class="titleArea" >
		<div id="board_title"><h2>Q&A</h2>
		</div>
	</div>
<div class="ec-base-table typeList gBorder">
					<% if(loginMember!=null) {//로그인 사용자인 경우 %>
					<div id="btn">
						<button type="button" class="btn_black" style="position: relative; left: 430px; top:20px;"
							onclick="location.href='<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=board&musky=qna_write';">글쓰기</button>
					</div>
					<% } %>
        <table border="1" summary="" style="width: 1000px; position: relative; left: 15%; top:10px;">

			<thead class="xans-element- xans-board xans-board-listheader-1002 xans-board-listheader xans-board-1002 ">
				<tr style=" ">				
					<th width="100">번호</th>
					<th width="500">제목</th>
					<th width="100">답변여부</th>
					<th width="150">카테고리</th>
					<th width="100">작성자</th>
					<th width="200">작성일</th>
					<th width="100">조회수</th>
				</tr></thead>
			<tbody class="xans-element- xans-board xans-board-list-1002 xans-board-list xans-board-1002 center">
				<% if(totalQna==0) { %>
				<tr>
					<td colspan="7">검색된 게시글이 하나도 없습니다.</td>
				</tr>
				<% } else { %>
				<%-- 검색된 게시글 목록에서 게시글을 하나씩 제공받아 응답 - 반복 --%>
				<% for(QnaDTO qna:qnaList) { %>
				<tr>
					<%-- 글번호 : QNA 테이블에 저장된 글번호가 아닌 계산된 글번호 출력 --%>
					<td><%=number %></td>
		
		
					<%-- 제목 --%>
					<td class="qtitle" style="text-align: left ;text-indent: 20px;" >
						<% if(qna.getQREF_STEP()!=0) {//답글인 경우 %> <%-- 답글의 깊이에 따라 왼쪽 여백을 다르게 설정하여 출력 --%>
						<span style="margin-left: <%=qna.getQREF_LEVEL()*20%>px;">└[답글]</span>
						
						<% } %> <%-- 게시글 상태를 구분하여 제목과 링크를 다르게 설정 --%> 
						<% if(qna.getQSTATUS()==1) {//일반 게시글인 경우 %>
						<a href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=board&musky=qna_detail&num=<%=qna.getQNO() %>&pageNum=<%=pageNum %>&search=<%=search%>&keyword=<%=keyword%>"><%=qna.getQTITLE() %></a>
							
						<% } else if(qna.getQSTATUS()==0) {//삭제 게시글인 경우 %> <span
						class="remove">삭제글</span> 작성자 또는 관리자에 의해 삭제된 게시글입니다. <% }%>
					</td>
		
					<% if(qna.getQSTATUS()!=0) {//삭제 게시글이 아닌 경우 %>
						<%-- 답변여부 --%>
						<%if(qna.getQANSWER().equals("N")) {%>
						<td>미답변</td>
						<%} else { %>
						<td>답변완료</td>
						<%} %>
						
						<%--카테고리 --%>
<!-- 						!qna.getQCATEGORY().equals("교환") || !qna.getQCATEGORY().equals("환불") || !qna.getQCATEGORY().equals("일반 문의") || !qna.getQCATEGORY().equals("배송"))  -->
<%-- 						<% if(qna.getQCATEGORY()==null || qna.getQREF_STEP()!=0) { %> --%>
						<% if(qna.getQCATEGORY()==null) { %>
							<td>-</td>
						<%} else if(qna.getQCATEGORY().equals("교환")) {%>
							<td>교환</td>
						<%} else if(qna.getQCATEGORY().equals("환불")) {%>
							<td>환불</td>
						<%} else if(qna.getQCATEGORY().equals("일반 문의")) { %> 
							<td>일반 문의</td>
						<% } else if(qna.getQCATEGORY().equals("배송")) {%>
							<td>배송</td>
						<% } %>
						
						<%-- 작성자 --%>
						<% if(qna.getMID()!=null) { %>
							<td><%=qna.getMID() %></td>
						<%} else { %>
							<td>-</td>
						<% } %>
			
						<%-- 작성일 : 오늘 날짜에 작성된 게시글은 시간만 출력하고 오늘 날짜가  
									아닌 날짜에 작성된 게시글은 날짜와 시간 출력  --%>
						<td>
							<%-- 게시글 작성날짜와 시스템 날짜가 같은 경우 --%> <% if(currentDate.equals(qna.getQDATE().substring(0, 10))) { %>
							<%=qna.getQDATE().substring(11) %> <% } else { //게시글 작성날짜와 시스템 날짜가 다른 경우 %>
							<%=qna.getQDATE() %> <% } %>
						</td>
			
						<%-- 조회수 --%>
						<td><%=qna.getQHIT() %></td>
			
						 <% } else {//삭제 게시글인 경우  %>
						
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					 <% } %> 
				</tr>
		
				<%-- 출력 글번호의 변수값 1 감소 --%>
				<% number--; %>
				<% } %>
				<% } %>
			</tbody>
		</table>
	<br><br>
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

	<% if(startPage>blockSize) {//시작 페이지 번호가 blockSize 변수값을 초과한 경우 링크 설정 %>
	<a
		href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=board&musky=qna&pageNum=1&search=<%=search%>&keyword=<%=keyword%>">[처음]</a>
	<a
		href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=board&musky=qna&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[이전]</a>
	<% } else {//시작 페이지 번호가 blockSize 변수값을 초과하지 않을 경우 링크 미설정 %>
	[처음][이전]
	<% } %>

	<% for(int i=startPage;i<=endPage;i++) { %>
	<% if(pageNum!=i) {//요청 페이지 번호와 출력 페이지 번호가 같지 않은 경우 링크 설정 %>
	<a
		href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=board&musky=qna&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>">[<%=i%>]
	</a>
	<% } else {//요청 페이지 번호와 출력 페이지 번호가 같을 경우 링크 미설정 %>
	[<%=i %>]
	<% } %>
	<% } %>

	<% if(endPage!=totalPage) {//종료 페이지 번호와 전체 페이지 갯수가 같지 않은 경우 링크 설정 %>
	<a
		href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=board&musky=qna&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[다음]</a>
	<a
		href="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=board&musky=qna&pageNum=<%=totalPage%>&search=<%=search%>&keyword=<%=keyword%>">[마지막]</a>
	<% } else {//종료 페이지 번호와 전체 페이지 갯수가 같은 경우 링크 미설정 %>
	[다음][마지막]
	<% } %>
	<br><br>
	<%-- 게시글 검색 기능 제공 --%>
	<form
		action="<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=board&musky=qna"
		method="post">
		<%-- select 태그에 의해 입력되어 전달되는 값은 비교 컬럼명과 동일하게 설정 --%>
		<select name="search">
			<option value="qtitle" selected="selected">&nbsp;제목&nbsp;</option>
			<option value="qcontent">&nbsp;내용&nbsp;</option>
			<option value="mid">&nbsp;작성자&nbsp;</option>
		</select> <input type="text" name="keyword">
		<button type="submit" class="btn_black">검색</button>
	</form>
</div>














