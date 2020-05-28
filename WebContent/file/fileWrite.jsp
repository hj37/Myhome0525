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
#container table{
/* 	width: 80%; */
/* 	margin-left: auto; */
/* 	margin-right: auto; */
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
	//session값 얻기
	//session값 얻는  이유: 글쓰기 화면에 글을 작성하는 사람이름 출력 
	String id = (String)session.getAttribute("id");
	
	//session영역에 저장된 값이 없으면
	if(id == null){
		response.sendRedirect("../login.jsp");
	}

%>

<!-- Wrapper -->
			<div class="wrapper style1">
				<!-- Header -->
										<jsp:include page="header.jsp"/>
							<!-- Banner -->
					<div id="banner" class="container">
						<section>
							<p>롯데 자이언츠 자료실 게시판</p>
						</section>
					</div>

<div class="container">
	<div class="row">
	<form action="uploadAction.jsp" method="post" enctype="multipart/form-data">
	<table class="table table-hover" id="tb" style="text-align:center; border: 1px solid white;" bgcolor = "white">
	<thead>
				<tr>
					<th colspan="3" style="background-color:#eeeeee; text-align: center;">자료실 글 작성 </th>
				</tr>
	</thead>
	<tbody>	
	
	<tr>
			<td>이름</td>
			<td colspan="2"><input type="text" name="name"></td>
	</tr>
	<tr>
			<td>비밀번호</td>
			<td colspan="2"><input type="password" name="pwd"></td>
	</tr>
	
	<tr>
			<td>제목</td>
			<td colspan="2"><input type="text" name="subject"></td>
	</tr>
	<tr>
			<td>글내용</td>
			<td  colspan="2"><textarea name="content" rows="13" cols="40"></textarea></td>
	</tr>
	<tr>
			<td>파일</td>
			<td  colspan="2"><input type="file" name="file"></td>
	</tr>
	<tr>
			<td>파일</td>
			<td  colspan="2"><input type="file" name="file2"></td>
	</tr>
	<tr>
			<td>파일</td>
			<td  colspan="2"><input type="file" name="file3"></td>
	</tr>
	
	
</tbody>
</table>
<div id = "table_search" style="text-align: center">
<input type="submit" value="업로드" class="btn">
			<input type="reset" value="다시작성" class="btn">
			<input type="button" value="글목록" class="btn" onclick="location.href='fileBoard.jsp'">
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