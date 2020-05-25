<%@page import="java.util.List"%>
<%@page import="img.ImgDTO"%>

<%@page import="img.ImgDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	Phase Shift by TEMPLATED
	templated.co @templatedco
	Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
-->
<html>
	<head>
		<title>Giants 커뮤니티게시판</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
		<script src="../js/jquery.min.js"></script>
		<script src="../js/jquery.dropotron.min.js"></script>
		<script src="../js/skel.min.js"></script>
		<script src="../js/skel-layers.min.js"></script>
		<script src="../js/init.js"></script>
			<link rel="stylesheet" href="../css/skel.css" />
			<link rel="stylesheet" href="../css/style.css" />
			<link rel="stylesheet" href="../css/style-wide.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
	
<%
	//게시판 목록 검색해오기 
	ImgDAO dao = new ImgDAO();

	//전체 글 개수 얻기 
	int count = dao.getImgBoardCount();

	//하나의 화면(한 페이지)마다 보여줄 글 개수 10개로 정함
	int pageSize = 10;

	//아래의 페이지 번호 중 선택한 페이지 번호 얻기 

	String pageNum = request.getParameter("pageNum");
%>
	<script>
		console.log(<%=pageNum%>);
	</script>
		
	<%	
	//아래의 페이지번호 중 선택한 페이지번호가 없으면, 첫 notice.jsp 화면은 1페이지로 지정 
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	//위의 pageNum 변수의 값을 정수로 변환해서 저장 
	int currentPage = Integer.parseInt(pageNum); //현재 선택한 페이지 번호를 정수로 변환해서 저장 
	
	//각 페이지마다 가장 첫 번째로 보여질 시작 글 번호 구하기 
	//(현재 보여지는 페이지번호 - 1) * 한페이지당 보여줄 글 개수 10
	int startRow = (currentPage - 1) * pageSize;
	
	//board게시판 테이블의 글 정보들을 검색하여 가져와서 저장할 ArrayList객체를 저장할 변수 선언
	List<ImgDTO> list = null;
	
	//만약 게시판에 글이 존재한다면
	if(count > 0){
		//글정보 검색해오기 
		//getBoardList(각 페이지마다 첫 번째로 보여지는 시작 글 번호,한 페이지당 보여줄 글개수)
		list = boardDAO.getBoardList(startRow, pageSize);
	}


	%>
	
	
	
	
	
	
	
	
	
	
	
	
	</head>
	<body>

		<!-- Wrapper -->
			<div class="wrapper style1">

				<!-- Header -->
					<jsp:include page="header.jsp"/>

			

				<!-- Extra -->
					<div id="extra">
						<div class="container">
							<div class="row no-collapse-1">
								<section class="4u"> <a href="#" class="image featured"><img src="../images/pic01.jpg" alt=""></a>
									<div class="box">
										<a href="#" class="button">Read More</a> </div>
								</section>
								<section class="4u"> <a href="#" class="image featured"><img src="../images/pic02.jpg" alt=""></a>
									<div class="box">
										<a href="#" class="button">Read More</a> </div>
								</section>
								<section class="4u"> <a href="#" class="image featured"><img src="../images/pic03.jpg" alt=""></a>
									<div class="box">
										<a href="#" class="button">Read More</a> </div>
								</section>
							</div>
							<div class="row no-collapse-1">
								<section class="4u"> <a href="#" class="image featured"><img src="../images/pic01.jpg" alt=""></a>
									<div class="box">
										<a href="#" class="button">Read More</a> </div>
								</section>
								<section class="4u"> <a href="#" class="image featured"><img src="../images/pic02.jpg" alt=""></a>
									<div class="box">
										<a href="#" class="button">Read More</a> </div>
								</section>
								<section class="4u"> <a href="#" class="image featured"><img src="../images/pic03.jpg" alt=""></a>
									<div class="box">
										<a href="#" class="button">Read More</a> </div>
								</section>
							</div>
						</div>
					</div>

				

	</div>

	<!-- Footer -->
	
		<!-- Copyright -->
		<jsp:include page="bottom.jsp"/>

    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
</html>