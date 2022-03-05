<%@page import="muskycode.dto.MemberDTO"%>
<%@page import="muskycode.dao.NoticeDAO"%>
<%@page import="muskycode.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//비정상적인 요청에 대한 응답 처리
if (request.getParameter("num") == null) {
	out.println("<script type='text/javascript'>");
	out.println(
	"location.href='" + request.getContextPath() + "/muskycode/index.jsp?muskygroup=error&musky=error400';");
	out.println("</script>");
	return;
}

//전달값을 반환받아 저장
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
String search = request.getParameter("search");
String keyword = request.getParameter("keyword");

//글번호를 전달받아 Notice 테이블에 저장된 해당 글번호의 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
NoticeDTO notice = NoticeDAO.getDAO().selectNumNotice(num);

//검색된 게시글이 없는 경우 => 비정상적인 요청에 대한 응답 처리
if (notice == null) {
	out.println("<script type='text/javascript'>");
	out.println(
	"location.href='" + request.getContextPath() + "/muskycode/index.jsp?muskygroup=error&musky=error400';");
	out.println("</script>");
	return;
}

//세션에 저장된 권한 관련 정보(회원정보)를 반환받아 저장
MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");

//글번호를 전달받아 Notice 테이블에 저장된 해당 글번호의 게시글에 조회수를 증가하는 DAO 클래스의 메소드 호출
NoticeDAO.getDAO().updateReadcount(num);
%>

<hr class="layout"/>

	<div class="titleArea" >
		<h2>NOTICE</h2>
	</div>


<div id="container" style="position: relative; bottom:100px; width: 1000px;">
	<div id="container_sub">
		<form id="BoardDelForm" name="" action="/exec/front/Board/del/1"
			method="post" target="_self" enctype="multipart/form-data">
			<div class="xans-element- xans-board xans-board-read-1002 xans-board-read xans-board-1002">
				<div class="ec-base-table typeWrite ">
					<table border="1" summary="">
						<caption>게시판 상세</caption>
						<colgroup>
							<col style="width: 130px;" />
							<col style="width: auto;" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">제목</th>
								<td style="text-align: left; text-indent: 20px;"><%=notice.getNTITLE() %>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<strong style="text-align: right;">작성일</strong>&nbsp;<%=notice.getNDATE() %>&nbsp;&nbsp;&nbsp;&nbsp;
										<strong>조회수</strong>&nbsp;<%=notice.getNHIT()+1 %>
								</td>
							</tr>
							<tr>
								<th scope="row" style="line-height: 50%;">내용</th>
								<td>
									<div class="detail">
										<div class="fr-view fr-view-article">
											<p style="margin: 0px; padding: 0px; box-sizing: border-box; font-family: NanumSquare, sans-serif; letter-spacing: -0.5px; display: block; line-height: 1.5; color: rgb(51, 51, 51); font-size: 15px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; orphans: 2; text-align: start; text-indent: 20px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
												<span style="font-size: 12px;"><%=notice.getNCONTENT().replace("\n", "<br>") %></span>
											</p>
										</div>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</form>
	</div>
	
	<br><br>
	<div id="notice_menu">
		<button type="button" id="listBtn" class="btn_black">글목록</button>
	</div>
	
	<form id="noticeForm" method="post">
		<%-- [글목록]을 클릭한 경우 요청 JSP 문서에 전달되는 값 --%>
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="search" value="<%=search%>">
		<input type="hidden" name="keyword" value="<%=keyword%>">
	</form>
</div>

<script type="text/javascript">

$("#listBtn").click(function() {
	$("#noticeForm").attr("action", "<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=notice&musky=notice_list");
	$("#noticeForm").submit();
});
</script>

