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

//글번호를 전달받아 NOTICE 테이블에 저장된 해당 글번호의 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
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

//글번호를 전달받아 NOTICE 테이블에 저장된 해당 글번호의 게시글에 조회수를 증가하는 DAO 클래스의 메소드 호출
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
			<input id="no" name="no" value="21203" type="hidden" /> <input
				id="bulletin_no" name="bulletin_no" value="21164" type="hidden" />
			<input id="board_no" name="board_no" value="1" type="hidden" /> <input
				id="member_id" name="member_id" value="cs08" type="hidden" /> <input
				id="list_url" name="list_url"
				value="/board/free/list.html?board_no=1" type="hidden" /> <input
				id="bdf_modify_url" name="bdf_modify_url"
				value="/board/free/modify.html?board_act=edit&amp;no=21203&amp;board_no=1"
				type="hidden" /> <input id="bdf_del_url" name="bdf_del_url"
				value="/exec/front/Board/del/1" type="hidden" /> <input
				id="bdf_action_type" name="bdf_action_type" value="" type="hidden" />
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
		<%-- 로그인 사용자가 게시글 작성자이거나 관리자인 경우에만 글삭제와 글변경 권한 제공 --%>
		<% if(loginMember!=null && loginMember.getMGRADE()==9) { %>
			<button type="button" id="removeBtn" class="btn_black">글삭제</button>
			<button type="button" id="modifyBtn" class="btn_black">글변경</button>
		<% } %>
		<button type="button" id="listBtn" class="btn_black">글목록</button>
	</div>
	
	<form id="noticeForm" method="post">
		<%-- [글삭제]와 [글변경]을 클릭한 경우 요청 JSP 문서에 전달되는 값 --%>
		<input type="hidden" name="num" value="<%=notice.getNNO()%>">
		
		<%-- [글목록]을 클릭한 경우 요청 JSP 문서에 전달되는 값 --%>
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="search" value="<%=search%>">
		<input type="hidden" name="keyword" value="<%=keyword%>">
	</form>
</div>

<script type="text/javascript">
$("#removeBtn").click(function() {
	if(confirm("게시글을 삭제 하시겠습니까?")) {
		$("#noticeForm").attr("action", "<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=notice_remove_action");
		$("#noticeForm").submit();
	}
});

$("#modifyBtn").click(function() {
	$("#noticeForm").attr("action", "<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=notice_modify");
	$("#noticeForm").submit();
});

$("#listBtn").click(function() {
	$("#noticeForm").attr("action", "<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=admin&musky=notice_manage");
	$("#noticeForm").submit();
});
</script>