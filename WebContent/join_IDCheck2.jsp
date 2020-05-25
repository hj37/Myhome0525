<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String pass = request.getParameter("pass");
		if("".equals(pass) || pass == null){
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < 6; i++) {
				int n = (int)(Math.random() * 10);
				sb.append(n);
			}	
			pass = sb.toString();	

		}
		String sender = "ycool37@naver.com";
		
		String receiver = request.getParameter("email");
		
		String subject = "자이언츠커뮤니티 게시판 인증번호입니다.";
		
		String content = "인증번호 = " + pass;
		
		int check = Integer.parseInt(request.getParameter("check"));
		if(check == 1){
			
			
	%>
		<form name="f">
		인증번호 : <input type="text" name="pass">
		<input type="hidden" name = "p" value="<%=pass%>">
		<input type="button"  value="확인" onclick="result()" >
		</form>
		
	<%}else if(check == 0){ %>
		메일 보내기에 실패했습니다.
	<%}%>
	<form action="mailSend" method="post" name="nfr">
		<input type="hidden" name="pass" value="<%=pass%>">		
		<input type="hidden" name="sender" value="<%=sender%>">		
		<input type="hidden" name="receiver" value="<%=receiver%>">		
		<input type="hidden" name="subject" value="<%=subject%>">
		<input type="hidden" name="content" value="<%=content%>">
		<input type="submit" value="인증번호전송">	
	</form>
	
	<script type="text/javascript">
		function result(){
				//join.jsp <---- opener 부모를 찾음
				//작은 창(join_IDCheck.jsp)에 입력된 아이디를 부모창인 join.jsp의 <input>에 출력 
				
				if(document.f.pass.value == document.nfr.pass.value){
				
				//작은 창 닫기
				window.close();
				}else{
					var a = document.f.p.value
					alert("인증번호가 틀렸습니다.");
				}
				
		}
	</script>
	
	

</body>
</html>