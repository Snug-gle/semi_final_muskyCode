<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("utf-8");

	String muskygroup = request.getParameter("muskygroup");
	if(muskygroup==null) {
		muskygroup="/muskycode/main";
	}
	
	String musky = request.getParameter("musky");
	if(musky==null) {
		musky="content";
	}
	
	String headerPath="header.jsp";
	if(muskygroup.equals("admin")) {//관리자 페이지를 요청한 경우
		headerPath="/muskycode/admin/header.jsp";
	}
	
	//반환받은 전달값을 이용하여 Content영역에 포함될 JSP문서의 경로를 생성하여 저장
	String contentFilePath = muskygroup + "/" + musky + ".jsp";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>머스키 코드</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link href="<%=request.getContextPath() %>/muskycode/design/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%-- Header 영역 : 회사로고,메뉴 등 --%>
	<div id="header">
		<jsp:include page="<%=headerPath %>" />
	</div>

	<%-- Content 영역 : 요청에 대한 결과 출력 --%>
	<div id="content">
		<jsp:include page="<%=contentFilePath %>"></jsp:include>
	</div>

	<%-- Footer 영역 : 저작권,약관,개인정보 보호정책,회사주소등 --%>
	<div id="footer">
		<jsp:include page="footer.jsp" />
	</div>


</body>
</html>

