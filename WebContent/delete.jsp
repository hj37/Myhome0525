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


<%
	String pageNum = request.getParameter("pageNum");
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDAO boardDAO = new BoardDAO();
	boardDAO.deleteBoard(num);
%>

<script type="text/javascript">
	alert("삭제가 완료되었습니다.");
	location.href = "board.jsp?pageNum=<%=pageNum%>";
</script>
<body>

</body>
</html>