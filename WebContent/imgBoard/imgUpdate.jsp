<%@page import="img.ImgDTO"%>
<%@page import="img.ImgDAO"%>
<%@page import="java.io.File"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="file.FileDAO"%>
<%@page import="file.FileDTO"%>
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
    
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>로그인 화면</title>

    <!-- 부트스트랩 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
 
    <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
    <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
 
  	<script src="../js/jquery.min.js"></script>
		<script src="../js/jquery.dropotron.min.js"></script>
		<script src="../js/skel.min.js"></script>
		<script src="../js/skel-layers.min.js"></script>
		<script src="../js/init.js"></script>
			<link rel="stylesheet" href="../css/skel.css" />
			<link rel="stylesheet" href="../css/style.css" />
			<link rel="stylesheet" href="../css/style-wide.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
		
				 
	<style type="text/css">
#container {
	width: 80%;
	margin-left: auto;
	margin-right: auto;
	table-layout: fixed;
	
}
#table_search {
	margin: auto;
	width: 50%;
}

#tb td,#tb th{
	padding-top: 1.25em;
	padding-bottom: 1.25em;
}


</style>
		
		
</head>

<%

	//세션값 가져오기
	String id=(String)session.getAttribute("id");
	//세션값이 없으면 login.jsp
	if(id == null){
		response.sendRedirect("login.jsp");
	}
	/*글 상세보기 페이지 */
	//notice.jsp페이지에서 글제목을 클릭해서 전달하여 넘어온 num,pageNum 한글처리 
	request.setCharacterEncoding("UTF-8");

	//notice.jsp페이지에서 글제목을 클릭해서 전달하여 넘어온 num, pageNum 가져오기
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	//BoardDAO 객체 생성 bdao
	ImgDAO dao = new ImgDAO();
	
	
	//상세내용을 볼 글에 대한 글번호를 넘겨서 DB로부터 글정보(BoardBean객체) 가져오기
	ImgDTO dto = dao.getFileBoard(num);
	
	int DBnum = dto.getNum();
	String DBName = dto.getName(); //작성자
	Timestamp DBDate = dto.getDate();	//작성일
	String FileName = dto.getFileName();
	String DBSubject = dto.getSubject(); // 글제목 
	String DBContent = "";	//글내용 
	//글내용이 존재 한다면  // 내용 엔터 처리 
	if(dto.getContent() != null){
		DBContent = dto.getContent().replace("\r\n","<br/>");
	}
	

	
%>

<!-- Wrapper -->
			<div class="wrapper style1">
				<!-- Header -->
						<jsp:include page="header.jsp"/>
					
					
							<!-- Banner -->
					<div id="banner" class="container">
						<section>
							<p><a href="imgboard.jsp">롯데 자이언츠 갤러리</a></p>
						</section>
					</div>

<div class="container">
	<div class="row">
	<form action="updateAction.jsp?pageNum=<%=pageNum %>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="num" value="<%=num%>">
	<table class="table table-hover" id="tb" style="text-align:center; border: 1px solid white;" bgcolor = "white">
	<thead>
				<tr>
					<th colspan="3" style="background-color:#eeeeee; text-align: center;">갤러리 글 수정  </th>
				</tr>
	</thead>
	<tbody>	
	<tr>
		<td>이름</td>
		<td><input type="text" name="name" value="<%=DBName %>"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="pwd"></td>
	</tr>
	<tr>
		<td style="width:20%;">글제목</td>
		<td><input type="text" name="subject" value="<%=DBSubject %>"></td>
	</tr>
	<tr>
		<td>글내용</td>
		<td colspan="2" style="min-height: 200px; text-align: left"><textarea name= "content" rows="5" cols= "40"><%=DBContent %></textarea></td>
	</tr>
	
	<tr>
	<td>
	<input type="hidden" name="original" value="<%=FileName%>">
	</td>
	</tr>
	
	<tr>
		<td>이미지 수정</td>
		<td  colspan="2"><input type="file" name="file" ></td>
	</tr>
	
	<tr>
	</tr>
	

</tbody>
</table>
<div id="table_search" style="text-align:center">
	<input type="submit" value="이미지수정" class="btn">
	<input type="reset" value="다시작성 " class="btn">
	<input type="button" value="목록보기" class="btn" onclick="location.href='imgboard.jsp?pageNum<%=pageNum%>'">
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