<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//세션영역에 저장되어 있는 값 모두 제거 
	session.invalidate();
	
	//index.jsp메인페이지로 재요청
// 	response.sendRedirect("../index.jsp");
%>

<script type="text/javascript">
	alert("로그아웃 되었습니다!");
	location.href = "index.jsp";
</script>
    
    
    
    