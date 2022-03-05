<%@page import="muskycode.dao.MemberDAO"%>
<%@page import="muskycode.util.Utility"%>
<%@page import="muskycode.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=error&musky=error400';");
		out.println("</script>");
		return;
	}

	//전달값을 반환받아 저장
	String id = request.getParameter("id");
	String passwd = Utility.encrypt(request.getParameter("passwd"));


	MemberDTO member = MemberDAO.getDAO().selectIdMember(id);

	if(member==null || member.getMGRADE()==0 ) { 
		session.setAttribute("id", id);
		session.setAttribute("message", "입력한 아이디가 존재하지 않습니다");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=member&musky=login';");
		out.println("</script>");
		return;
	}
	
	if(!member.getMPW().equals(passwd)) { 
		session.setAttribute("id", id);
		session.setAttribute("message", "입력한 아이디가 존재하지 않거나, 비밀번호가 맞지 않습니다");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=member&musky=login';");
		out.println("</script>");
		return;
	}
	
	//세션에 권한 관련 정보(회원정보 - MemberDTO인스턴스)를 저장
	session.setAttribute("loginMember", MemberDAO.getDAO().selectIdMember(id));


	String url = (String)session.getAttribute("url"); 
	
	if(url == null) { 
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp';");
		out.println("</script>");
	} else { 
		session.removeAttribute("url");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp';");
		out.println("</script>");		
	}
%>