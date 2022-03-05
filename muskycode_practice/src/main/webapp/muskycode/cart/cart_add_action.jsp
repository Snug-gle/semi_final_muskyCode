<%@page import="muskycode.dto.CartDTO"%>
<%@page import="muskycode.dao.CartDAO"%>
<%@page import="muskycode.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/muskycode/security/login_url.jspf"%>
	<%

	// 로그인된 회원의 아이디
	String mid= loginMember.getMID();

	//상품 번호 받기 (상품 카테고리 페이지에서 아이콘 눌렀을 때)
	int pno = Integer.parseInt(request.getParameter("pno"));
	// 카트번호 시퀀스 번호 받기
	int cno = CartDAO.getDAO().cartNextNum();
	
	
	// 상품 페이지 버튼 클릭 시 기본 수량 = 1
	int quantity = 1;
	
	// 얘는 상품 디테일 페이지에서 넘겨짐
	if(request.getParameter("qty") != null && request.getParameter("qty") != "") {
		quantity = Integer.parseInt(request.getParameter("qty"));
	}
	 
	System.out.println(quantity);
	// 카트 객체 
	CartDTO cart = CartDAO.getDAO().selectNumCart(pno, mid);
	
	if(cart!=null) { // 카트가 널이 아니면 
		
		quantity += cart.getCQUANTITY(); // 더하깅
		cno = cart.getCNO();
		CartDAO.getDAO().updateCart(quantity, cno);
	} else { // 카트가 널이면 새로운 객체 생성해서 속성값 넣기.
	
	cart = new CartDTO();
	cart.setCNO(cno);
	cart.setPNO(pno);
	cart.setMID(mid);
	cart.setCQUANTITY(quantity);
	
	// 카트 객체를 매개변수로 CART DB에 추가!
	CartDAO.getDAO().insertCart(cart); 
	}

	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=cart&musky=cart_list';");
	out.println("</script>");
	
%>
