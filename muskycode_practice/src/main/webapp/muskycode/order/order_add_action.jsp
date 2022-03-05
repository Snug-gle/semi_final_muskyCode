<%@page import="muskycode.dao.CartDAO"%>
<%@page import="muskycode.dto.CartDTO"%>
<%@page import="muskycode.dao.ProductDAO"%>
<%@page import="muskycode.dao.MemberDAO"%>
<%@page import="muskycode.dto.OrderDTO"%>
<%@page import="muskycode.dao.OrderDAO"%>
<%@page import="muskycode.dto.ProductDTO"%>
<%@page import="muskycode.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	    <%@include file="/muskycode/security/login_check.jspf"%>   
	
<%
// 이 페이지는 전체 주문시 요청

// 장바구니 번호 배열 반환
String[] cartNo1 = request.getParameterValues("cartNo");
// 상품 번호 배열 반환	
String[] productNo1=null;

// 상품 수량 배열 반환
String[] qty1=null;


if(cartNo1==null) { // 상세페이지 주문 시
	// 상품 번호 배열 반환
	productNo1 = request.getParameterValues("productNo");


	// 상품 수량 배열 반환
	qty1 = request.getParameterValues("qty");


} else { // 카트 주문 시 
	productNo1=new String[cartNo1.length];
	qty1=new String[cartNo1.length];
	
	for(int i=0; i<cartNo1.length; i++){
		CartDTO cart = CartDAO.getDAO().selectNoCart(Integer.parseInt(cartNo1[i]));
		productNo1[i]= String.valueOf(cart.getPNO());
		qty1[i]= String.valueOf(cart.getCQUANTITY());
	}	
}
// 지금 일단 내 계획은 주문의 상태는 같은 주문건 시 그 주문 객체의 상태는
// 같은 값으로 저장시키는 것임. 객체 가져올때 포이치 문으로 돌리면 되니.


String name = request.getParameter("name");
String phone = request.getParameter("mobile1")+"-"+request.getParameter("mobile2")+"-"+request.getParameter("mobile3");
String zipCode = request.getParameter("zipcode");
String address1 = request.getParameter("address1");
String address2 = request.getParameter("address2");
String payment = request.getParameter("payment");
int reserves = Integer.parseInt(request.getParameter("reserves"));

int ostatus = 2;

// 주문 그룹 시퀀스 넘버 가져옴
int orderGroupNo = OrderDAO.getDAO().getOrderGroupNo();

for(int i=0;i<productNo1.length;i++) {

// 상품 번호 별 객체 가져옴 	
ProductDTO product=ProductDAO.getDAO().selectNumProduct(Integer.parseInt(productNo1[i]));

// DAO로 태워 보낼 객체 생성
OrderDTO order = new OrderDTO();
order.setPNO(product.getPNO());
order.setMID(loginMember.getMID());
order.setONAME(name);
order.setOPHONE(phone);
order.setOQUANTITY(Integer.parseInt(qty1[i]));
order.setOPAYMENT(payment);
order.setOZIP(zipCode);
order.setOADDRESS1(address1);
order.setOADDRESS2(address2);
order.setOGROUP(orderGroupNo);

// 무통장 입금 결제면 배송상태는 입금대기로
if(payment.equals("deposit")){
	ostatus = 1;	
}

//주문 건 추가하는 다오로 넘김.
OrderDAO.getDAO().insertOrder(order,ostatus);

// 장바구니에서 산 놈들 장바구니에서 비워야 함.
if(cartNo1!=null) {
CartDAO.getDAO().deleteCart(Integer.parseInt(cartNo1[i]), loginMember.getMID());
}

// 상품 수량 감소 시켜야 함.
ProductDAO.getDAO().deleteOrderStock(Integer.parseInt(qty1[i]), product.getPNO());
}



// 적립금 차감해야함.
MemberDAO.getDAO().updateReserves(reserves, loginMember);



//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/muskycode/index.jsp?muskygroup=order&musky=order_complete';");
	out.println("</script>");
%>

