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
		//join.jsp(작은 창인? 현재 join_IDCheck.jsp를 오픈해준 창)
		//아이디 중복확인을 위해 입력한 아이디가 한글이라면 한글이 깨지므로 인코딩 방식을 UTF-8로 설정
		request.setCharacterEncoding("UTF-8");
	
	//1.join.jsp에서 입력한 아이디를 request영역에서 꺼내오기(요청값 얻기)
	//2.밑의 중복확인 버튼을 눌렀을때 <form>태그로부터 전달받은 uesrid값 가져오기
	
	String id = request.getParameter("userid");
	
	//3.MemberDAO클래스에.. 아이디중복 체크 유무값 가져오기 DB작업을 위한 idCheck() 메소드 추가 
	
	//4. 입력받은 id값이 db에 존재하는지 중복체크를 위한 idCheck()메소드호출 시 .. 매개변수로 전달
    MemberDAO mdao = new MemberDAO();
		int check = mdao.idCheck(id);
		
	//5. check== 1 "사용중인 ID입니다." //아이디 중복
	// check==0 "사용가능한 ID입니다." //아이디 중복아님 
		
	if(check == 1){
		out.println("사용중인 ID입니다.");
	}else{
		out.println("사용가능한 ID입니다.");
		//사용가능한ID이면 사용함버튼을 눌러서 부모창(join.jsp)에서 사용가능한 ID를 출력해주기 
	%>
	
		<input type="button" value="사용함" onclick="result();"/>
	<% 	
	
		}	
	
	%>
	
	
	<form action="join_IDCheck.jsp" method="post" name="nfr">
		아이디 : <input type="text" name="userid" value="<%=id%>">
		<input type="submit" value="중복확인">	
	</form>
	
	
	<script type="text/javascript">
		function result(){
				//join.jsp <---- opener 부모를 찾음
				//작은 창(join_IDCheck.jsp)에 입력된 아이디를 부모창인 join.jsp의 <input>에 출력 
				opener.document.f.id.value = document.nfr.userid.value;
				
				//작은 창 닫기
				window.close();
		}
	</script>
	
	

</body>
</html>