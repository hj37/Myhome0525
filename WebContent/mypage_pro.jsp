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
<jsp:useBean id="mb" class = "member.MemberBean"/>
<jsp:setProperty property="*" name="mb"/> 
<%
	/* MemberBean mb = new MemberBean();
	mb.setId(request.getParameter("id"));
	mb.setPasswd(request.getParameter("passwd"));
	mb.setName(request.getParameter("name"));
	mb.setEmail(request.getParameter("email"));
	mb.setAddress(request.getParameter("address"));
	 */
	String id = (String)session.getAttribute("id");
	MemberDAO memberDAO = new MemberDAO();
	memberDAO.updateMember(mb,id);
	session.setAttribute("id",mb.getId());
%>
<script type="text/javascript">
	alert("회원정보 수정이 완료되었습니다.");
	location.href = "index.jsp";
</script>



<body>

</body>
</html>