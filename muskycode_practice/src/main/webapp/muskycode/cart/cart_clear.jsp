<%@page import="java.util.Arrays"%>
<%@page import="muskycode.dao.CartDAO"%>
<%@page import="muskycode.dao.MemberDAO"%>
<%@page import="muskycode.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="/muskycode/security/login_check.jspf"%>


<!-- 상품 삭제 페이지(전체삭제, 선택삭제 모두 가능) -->
<%

// 비정상적인 페이지 요청 시 페이지 이동
if (request.getMethod().equals("GET")) {
	out.println("<script type='text/javascript'>");
	out.println(
	"location.href='" + request.getContextPath() + "/muskycode/index.jsp?muskygroup=cart&musky=cart_list';");
	out.println("</script>");
	return;
}

//로그인 회원 정보
String mid = loginMember.getMID();

//장바구니 화면 체크박스 체크 된 카트 번호 문자열로 받아 형 변환
String[] cartNo = request.getParameterValues("checkName");
int[] cartList = new int[cartNo.length];

for (int i = 0; i < cartNo.length; i++) {
	cartList[i] = Integer.parseInt(cartNo[i]);

	for (int cno : cartList) {

		CartDAO.getDAO().deleteCart(cno, mid);//삭제 DAO 메소드 호출
	}


}
// 페이지 이동
out.println("<script type='text/javascript'>");
out.println("location.href='" +request.getContextPath()+"/muskycode/index.jsp?muskygroup=cart&musky=cart_list';");
out.println("</script>");
%>