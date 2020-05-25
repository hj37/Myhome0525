<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1.join.jsp에서 입력한 데이터 한글처리 
	request.setCharacterEncoding("UTF-8");
%>
   <%--
  	//2. join.jsp에서 입력한 가입할 회원내용을 request 객체영역에서  꺼내와서
  	//MemberBean객체의 각 변수에 저장 
  	//액션 태그 사용
    --%>
    
    
    <jsp:useBean id="memberbean" class="member.MemberBean"></jsp:useBean>
    <jsp:setProperty property="*" name="memberbean"/>
    
    
<%
	//3. MemberDAO객체를 생성하여 insertMember()메서드 호출!(입력한 회원정보를 DB에 insert 명령)
	//그 전에 먼저 해야할일? MemberDAO 클래스 내부에 InsertMember()메소드 추가 
 	MemberDAO memberdao =  new MemberDAO();
	memberdao.insertMember(memberbean);
	
	//4.회원가입에 성공(DB에 새로운 회원정보 추가에 성공)하면?
	//login.jsp페이지를  리다이렉트 방식으로 재요청해 이동
	response.sendRedirect("login.jsp");
	/* 같은 경로에 있어서 */
%>