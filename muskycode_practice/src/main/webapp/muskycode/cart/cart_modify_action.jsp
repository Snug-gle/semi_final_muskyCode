<%@page import="muskycode.dao.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/muskycode/security/login_check.jspf"%>
<%	
	
	// 버튼 스위치를 위한 정보 ( 1 = 증가, 2 = 감소)
	int status = Integer.parseInt(request.getParameter("status"));
	System.out.println("status = "+status);
	int stock = Integer.parseInt(request.getParameter("stock"));
	System.out.println("stock = "+stock);
	int cno=Integer.parseInt(request.getParameter("cno"));
	System.out.println("cno = "+cno);
	int quantity=Integer.parseInt(request.getParameter("quantity"));
	System.out.println("quantity = "+quantity);
	
	// 상품 수량이 재고량 보다 많은 경우 장바구니로 이동
	if(quantity > stock){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=cart&musky=cart_list';");
		out.println("</script>");
	
	}
	else { //상품 수량 < 재고량
		// 상품 수량 증가
		if(status == 1  ){
			
			quantity++;
					
			CartDAO.getDAO().updateCart(quantity, cno);
		}
		
		else { //상품 수량 감소
			
			//수량이 1일 경우 감소하지 못하게 장바구니 이동
			if(quantity<2) {
				out.println("<script type='text/javascript'>");
				out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=cart&musky=cart_list';");
				out.println("</script>");
			}
			//수량이 2개 이상일 경우만 수량 감소 가능
			else {
			
			quantity--;
			
			CartDAO.getDAO().updateCart(quantity, cno);
			}
		} 
	
		//페이지 이동		
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=cart&musky=cart_list';");
		out.println("</script>");
	}

%>