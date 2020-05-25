<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>writePro.jsp</h1>
	<%
		//session영역에 저장된 값 가져오는 이유: 
		//로그인 하지 않고 글쓰기 작업 시 다시 로그인 처리하기 위해..
		//login.jsp페이지로 이동시킬 목적 
		
		//session영역에 저장된 값 얻기 
		String id = (String)session.getAttribute("id");
		
		if(id == null){
			response.sendRedirect("login.jsp");
		}
		
		//write.jsp에서 쓴 글의 내용을 전달받아 한글처리 
		request.setCharacterEncoding("UTF-8");
		
		//write.jsp에서 쓴 글의 내용을 request객체영역에서 꺼내와서 변수에 각각 저장 
		String passwd = request.getParameter("passwd");//비밀번호
		String subject = request.getParameter("subject");//글제목
		String content = request.getParameter("content");//글내용
		String ip = request.getRemoteAddr(); //글쓴이의 IP주소 
		
		//BoardBean객체를 생성하여 각 변수에 저장 
		BoardBean bBean = new BoardBean();
		bBean.setName(id);
		bBean.setPasswd(passwd);
		bBean.setSubject(subject);
		bBean.setContent(content);
		bBean.setIp(ip);
		
		//쓴 글 내용들(BoardBean객체의 각 변수에 저장된 값들)을 DB의 jspbeginner데이터베이스의 borad테이블에
		//INSERT추가하기 위해 BoardDAO객체의 insertBoard(BoardBean bean)메소드 호출시 
		//매개변수로 전달하여 insert구문을 만들어서 실행해야함.
		BoardDAO bdao = new BoardDAO();
		bdao.insertBoard(bBean);	//insert명령!
		
		//notice.jsp를 재요청(포워딩)해 이동
		response.sendRedirect("board.jsp");		
	%>
	


</body>
</html>