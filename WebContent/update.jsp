<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
 <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
<!--     <meta name="viewport" content="width=device-width, initial-scale=1"> -->
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>로그인 화면</title>

      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>로그인 화면</title>

    <!-- 부트스트랩 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
 
 
  		<script src="js/jquery.min.js"></script>
		<script src="js/jquery.dropotron.min.js"></script>
		<script src="js/skel.min.js"></script>
		<script src="js/skel-layers.min.js"></script>
		<script src="js/init.js"></script>
			<link rel="stylesheet" href="css/skel.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/style-wide.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
		
				 
	<style type="text/css">
#tb{	width: 100%;
	margin-left: auto;
	margin-right: auto;
	
/* 	table-layout: fixed; */
}
#table_search {
	margin-left: auto;
	margin-right: auto;
	width:50%
}

#tb td,#tb th{
	padding-top: 1.25em;
	padding-bottom: 1.25em;
	border:1px solid grey;
	font-size: 18px;
}


</style>
		
		
</head>

<%
/* 글수정페이지를 위한 글 상세보기 */

//세션값 가져오기
String id=(String)session.getAttribute("id");
//세션값이 없으면 login.jsp
if(id == null){
	response.sendRedirect("login.jsp");
}

	//content.jsp페이지서 글수정버튼을 클릭해서 전달하여 넘어온 num,pageNum 한글처리
	request.setCharacterEncoding("UTF-8");
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	//BoardDAO 객체 생성 bdao
	BoardDAO dao = new BoardDAO();
	
	//글 수정 상세내용을 볼 글에 대한 글번호를 넘겨서 DB로부터 글정보(BoardBean객체)가져오기
	BoardBean boardBean = dao.getBoard(num);
	
	int DBnum = boardBean.getNum();//글번호
	String DBName = boardBean.getName(); //작성
	String DBSubject= boardBean.getSubject(); //글제목
	String DBContent = "";	//글내용
	//글 내용이 존재한다면 // 내용 엔터 처리 
	if(boardBean.getContent() != null){
		DBContent = boardBean.getContent().replace("\r\n", "<br/>");
	}


%>

<!-- Wrapper -->
			<div class="wrapper style1">
				<!-- Header -->
										<jsp:include page="header.jsp"/>

							<!-- Banner -->
					<div id="banner" class="container">
						<section>
							<p>롯데 자이언츠 커뮤니티 게시판</p>
						</section>
					</div>
<div class="container">
	<div class="row">
	<form action="update_pro.jsp?pageNum=<%=pageNum %>" method="post" name="fr">
	
	<input type="hidden" name="num" value="<%=num%>">
	<table class="table table-hover" id="tb" style="text-align:center; border: 1px solid white;" bgcolor = "white">
	<thead>
				<tr>
					<th colspan="3" style="background-color:#eeeeee; text-align: center;">게시판 수정 </th>
				</tr>
	</thead>
	<tbody>	
	<tr>
		<td>이름</td>
		<td><input type="text" name="name" value="<%=DBName %>"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="passwd"></td>
	</tr>
	<tr>
		<td style="width:20%;">제목</td>
		<td><input type="text" name="subject" value="<%=DBSubject %>"></td>
	</tr>
	<tr>
		<td>글내용</td>
		<td colspan="2" style="min-height: 200px; text-align: left"><textarea name= "content" rows="5" cols= "40"><%=DBContent %></textarea></td>
	</tr>
	
</tbody>
</table>
<div id="table_search" style="text-align:center">
	<input type="submit" value="글수정" class="btn">
	<input type="reset" value="다시작성 " class="btn">
	<input type="button" value="목록보기" class="btn" onclick="location.href='board.jsp?pageNum<%=pageNum%>'">
</div>
</form>
</div>
</div>
</div>
<!-- Copyright -->
						<jsp:include page="bottom.jsp"/>


    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
</html>