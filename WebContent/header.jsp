<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
		<script src="js/jquery.min.js"></script>
		<script src="js/jquery.dropotron.min.js"></script>
		<script src="js/skel.min.js"></script>
		<script src="js/skel-layers.min.js"></script>
		<script src="js/init.js"></script>
			<link rel="stylesheet" href="css/skel.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/style-wide.css" />
<title>Insert title here</title>
</head>
<body>
<div id="header" class="skel-panels-fixed">
						<div id="logo">
							<h1><a href="index.jsp">Giants</a></h1>
							<span class="tag">커뮤니티게시판</span>
						</div>
						<nav id="nav">
							<ul>
								<li class="active"><a href="index.jsp">Homepage</a></li>
								<li><a href="./imgBoard/imgboard.jsp">갤러리</a></li>
								<li><a href="board.jsp">커뮤니티 게시판</a></li>
								<li><a href="./file/fileBoard.jsp">자료실</a></li>
								<%
									if("".equals(session.getAttribute("id")) || session.getAttribute("id") == null){
							
								%>
								<li><a href="login.jsp">Login</a></li>
								<%
									}else{
										%>
								<li><a href="logout.jsp">Logout</a></li>
										<% 
									}
								%>
								<li><a href="mypage.jsp">Mypage</a></li>
								
							</ul>
						</nav>
					</div>
</body>
</html>