<%@page import="board.BoardDAO"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<jsp:useBean id="Bb" class = "board.BoardBean"/>
<jsp:setProperty property="name" name="Bb"/> 
<jsp:setProperty property="passwd" name="Bb"/> 
<jsp:setProperty property="subject" name="Bb"/> 
<jsp:setProperty property="content" name="Bb"/> 
<jsp:setProperty property="num" name="Bb"/>

<%
	String pageNum = request.getParameter("pageNum");
	BoardDAO boardDAO = new BoardDAO();
	int check = boardDAO.updateBoard(Bb);
	if(check != 0){
%>

<script type="text/javascript">
	alert(" 수정이 완료되었습니다.");
	location.href = "board.jsp?pageNum=<%=pageNum%>";
</script>
<%}else{ %>
<script type="text/javascript">
	alert("비밀번호가 틀렸습니다.");
	history.back();
</script>
<% } %> 
<body>

</body>
</html>