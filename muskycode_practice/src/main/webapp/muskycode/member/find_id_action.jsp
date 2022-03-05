<%@page import="muskycode.dao.MemberDAO"%>
<%@page import="javax.swing.text.DefaultEditorKit.CutAction"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//비정상적인 요청일때 에러페이지로 이동
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskcode/index.jsp?muskygroup=error&musky=error400';");
		out.println("</script>");
		return;
	} 

	String mname=request.getParameter("mname");
	String memail=request.getParameter("memail");
	String mphone=request.getParameter("mphone");
	
	String mid=null;
	if(memail!=null && !memail.equals("")) {
		mid=MemberDAO.getDAO().findId_email(mname, memail);
	} else {
		mid=MemberDAO.getDAO().findId_phone(mname, mphone);
	}

%>
<style type="text/css">
#box, #yes {
	width: 1000px;
	height: 400px;
	margin: 0 auto;
}

#yes {
	margin: 0 auto;
	margin-top:150px;
	text-align: center;
	font-size: 1.3em;
}

#no { 
	margin: 0 auto;
	margin-top:150px;
	font-weight: bold;
	text-align: center;
	font-size: 1.3em;
}

</style>
<div class="row" id="box">
	
	<% if(mid!=null) { %>
		<div id="yes"><%=mname %>님의 아이디는 <b>[<%=mid %>]</b> 입니다.
		<br><br><br><br>
		<input type="button" class="btn_black" value="로그인" id="loginBtn" onclick="location.href='<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=member&musky=login';">
		<input type="button" class="btn_black" value="메인으로" id="mainBtn" onclick="location.href='<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=main&musky=content';">
		</div>
	<% } else { %>
		<div id="no">입력하신 정보의 회원이 존재하지 않습니다.
		<br><br><br><br>
			<input type="button" class="btn_black" value="회원가입" id="joinBtn" onclick="location.href='<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=member&musky=join';">
			<input type="button" class="btn_black" value="메인으로" id="mainBtn" onclick="location.href='<%=request.getContextPath()%>/muskycode/index.jsp?muskygroup=main&musky=content';">
		</div>	
	<% } %>
	

</div>
