<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//1.한글처리
	request.setCharacterEncoding("UTF-8");
	//2.요청값 전달받기(로그인을 위해 입력한 아이디와 비밀번호) 
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	//3.요청값과 DB에 저장된 아이디와 비밀번호를 비교하기 위해 DB작업 명령 
	MemberDAO memberdao = new MemberDAO();
	//check == 1 -> 아이디, 비밀번호 맞음
	// == 0 -> 아이디맞음, 비밀번호 틀림
	// -1 -> 아이디 틀림 
	
	int check = memberdao.userCheck(id,passwd);
	
	if(check == 1){//사용자가 입력한 아이디, 비밀번호가? DB에 저장되어 있는 아이디, 비밀번호와 동일할때
			//로그인 처리를 위해 입력한 아이디를 세션영역에 저장
			session.setAttribute("id", id);
		 	//index.jsp 메인페이지로 포워딩.
		 	response.sendRedirect("index.jsp");
	}else if(check == 0){	//아이디 동일, 비밀번호 틀
%>		
	<script type="text/javascript">
	
			window.alert("비밀번호틀림");
			history.back(); //이전 페이지(login.jsp)로 되돌아가서 비밀번호 다시 작성 유도 	
	</script>
<% 
	}else{//아이디 틀
	
%>
	<script type="text/javascript">
			window.alert("아이디 틀림");
			history.back(); 
	</script>
<% 
	}
%>  