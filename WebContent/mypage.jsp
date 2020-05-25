<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  	<meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!--     <meta name="viewport" content="width=device-width, initial-scale=1"> -->
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
<script src="js/jquery.min.js"></script>
		<script src="js/jquery.dropotron.min.js"></script>
		<script src="js/skel.min.js"></script>
		<script src="js/skel-layers.min.js"></script>
		<script src="js/init.js"></script>
			<link rel="stylesheet" href="css/skel.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/style-wide.css" />

<title>Insert title here</title>
<style>
	table{border-style:solid; border-width:1px; border-color:purple; width:300px}
	th{background-color:#ff6600}
	th,td{border-bottom-width:1px; border-bottom-color:#ff6600; border-bottom-style:dotted;}
</style>
</head>
<body>
	<!-- Header -->
											<jsp:include page="header.jsp"/>

<%
	if("".equals(session.getAttribute("id")) || session.getAttribute("id") == null){
%>
	<script type="text/javascript">
		alert("로그인 해주세요!");
		location.href = "login.jsp";
	</script>

<% 
	}else{
		String id = (String)session.getAttribute("id");
		MemberDAO memberdao = new MemberDAO();
		MemberBean memberBean = memberdao.Memberinfo(id);
%>
<%--7.
수정할 직원정보 뿌려 주면서...
수정할 정보가 있으면 입력 후 실제 직원정보 수정을 위한 DB작업을 할 ? modifyproc.jsp페이지에 요청 --%>
	<div id="footer" class="wrapper style2">
		<div class="container">
			<section>
				<header class="major">
					<h2>회원정보 수정</h2>
					<span class="byline">Integer sit amet pede vel arcu aliquet
						pretium</span>
				</header>
				<form method="post"  action="mypage_pro.jsp">
									<div class="row half">
							<div class="12u">
								<label>User ID</label>
								<input class="id" type="text" name="id" value=<%=memberBean.getId() %> placeholder="ID"/>	<br>
							</div>
						</div>
						<div class="row half">
							<div class="12u">
								<label>Password</label>
								<input type="password" name="passwd" value=<%=memberBean.getPasswd() %> placeholder="Password" />
							</div>
						</div>
					
						
						<div class="row half">
							<div class="12u">
								<label>Name</label>
								<input type="text" name="name" value=<%=memberBean.getName() %> placeholder="Name" />
							</div>
						</div>
						
						<div class="row half">
							<div class="12u">
								<label>가입날짜</label>
								<input type="text" name="name" value=<%=memberBean.getReg_date()%> readonly  />
							</div>
						</div>
						
						<div class="row half">
							<div class="12u">
								<label>E-Mail</label>
								<input type="email" name="email" value=<%=memberBean.getEmail() %> placeholder="Email" />
							</div>
						</div>
						
						<div class="row half">
							<div class="12u">
								<label>Address</label>
								<input type="text" name="address" value=<%=memberBean.getAddress()%> />
							</div>
						</div>
						
						
						<div class="row half">
							<div class="12u">
								<ul class="actions">
									<li>
										<input type="submit" value="Update" class="button alt" />
										<input type="reset" value="Reset" class="button alt" />										
									</li>
								</ul>
							</div>
						</div>
					</form>
				</section>
			</div>
		</div>
<% 
	}
%>
<!-- Copyright -->
				<jsp:include page="bottom.jsp"/>


</body>
</html>