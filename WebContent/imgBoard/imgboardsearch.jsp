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
<style type="text/css">
#table_search {
	margin: auto;
	width: 50%;
}

#table_search input {
	padding: 5px;
	width:100%;
	font-size: 18px;
}

#paging {
	text-align: center;
	font-size: 2em;
	font-style: normal;
	margin: 1em;
	
}
</style>
	
<%
//한글처리 
	request.setCharacterEncoding("utf-8");
	//search 가져오기 
	String search = request.getParameter("search");

	//게시판 목록 검색해오기 
	ImgDAO dao = new ImgDAO();

	//전체 글 개수 얻기 
	int count = dao.getImgBoardCount();

	//하나의 화면(한 페이지)마다 보여줄 글 개수 10개로 정함
	int pageSize = 6;

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
		list = dao.getSearchFileList(startRow, pageSize, search);
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
							<%
								if(count > 0){
									for(int i = 0; i < list.size(); i++){
							 			ImgDTO dto = list.get(i);
							%>
								<section class="4u">
								<img src="../image/<%=dto.getFileRealName() %>" style = "display: block;">
								<div class="box" style="width: 300px; padding-top: 0px; padding-bottom: 0px; margin-bottom: 30px;">
 								<a href="imgContent.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>" class="button"> <%=dto.getSubject() %></a> 
								</div>
<%-- 									<input type="button" value="<%=dto.getSubject() %>" onclick="location.href='fileContent.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'"> --%>
								</section>
							<%
								}//for문 
									
								}else{
							%>
									<section class="4u"> <a href="#" class="image featured"><img src="../images/pic01.jpg" width="50px" height="10px" alt=""></a>
									<div class="box">
										<a href="#" class="button">해당하는 글이 없습니다.</a> </div>
									</section>
							<% 	
								}
							
							%>
							</div>
						</div>
					</div>

				

	<div id="paging" >
		<%	
			if(count > 0){
				//전체 페이지수 구하기 글 20개 한 페이지에 보여줄 글 수 10개 => 2페이지 
				// 				글 25개 한 페이지에 보여줄 글 수 10개 -> 3페이지 
				//조건 삼항 연산자 조건 ? 참 : 거짓 
				//전체 페이지수 = 전체 글 개수 한 페이지에 보여줄 글 수 + (전체글수를 한페이지에 보여줄 글수로 나눈 나머지 값)
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
				//한 블럭에 묶여질 페이지번호수 설정 
				int pageBlock = 1;
				
				//시작페이지 번호 구하기 
				// 1 ~ 10 => 1 , 11~ 20 =>11 , 21 ~ 30 => 21 
				//((선택한 페이지번호/ 한 블럭에 보여지는 페이지번호 수) - 
				//(선택한 페이지번호를 한 화면에 보여줄 페이지수로 나눈 나머지 값)) * 한 블럭에 보여줄 페이지수 + 1;
		int startPage = 
		((currentPage/pageBlock) - (currentPage % pageBlock == 0 ? 1 : 0 )) * pageBlock + 1; 
		
				//끝페이지 번호 구하기 1 ~ 10 => 10 , 11 ~ 20 => 20, 21 ~ 30 => 30 
				//시작페이지번호 + 현재블럭에 보여줄 페이지수 - 1	
				int endPage = startPage + pageBlock -1;
				
				//끝페이지 번호가 전체페이지수보다 클때 
				if(endPage > pageCount){
					//끝페이지 번호를 전체페이지수로 저장 
					endPage = pageCount;
				}
				
				//[이전] 시작페이지 번호가 한 화면에 보여줄 페이지수보다 클때...
				if(startPage > pageBlock){
		%>
					<a href="imgboardsearch.jsp?pageNum=<%=startPage-pageBlock%>&search=<%=search%>"> [<%=startPage-pageBlock%>]</a>
		<% 			
				}
				//[1][2][3]...[10]
				for(int i = startPage; i <=endPage; i++){
		%>
				<a href="imgboardsearch.jsp?pageNum=<%=i%>&search=<%=search%>">[<%=i%>]</a>
		<% 
				}
				//[다음] 끝페이지 번호가 전체 페이지수보다 작을때..
				if(endPage < pageCount){
		%>
				<a href="imgboardsearch.jsp?pageNum=<%=startPage + pageBlock%>&search=<%=search%>"> [<%=startPage + pageBlock%>]</a>
		<% 
				}
			
			}
		
		%>
		</div>			
	<div id="table_search">
	<form action= "imgboardsearch.jsp">
	<input type="text" name="search" class="input_box">
	<input type="submit" value="search" class="btn">
	</form>
	<br>

	
	
	<%
	//각각페이지에서 이동을 했을떄.. 하나의 웹브라우저가 닫기기전까지 session영역이 유지되므로 
	//session영역에 값이 저장되어 있다면 로그인이 된 상태로 아래에... 글쓰기 버튼이 보이게 만들자.
	
	String id = (String)session.getAttribute("id");

	if(id != null){	//셰션영역에 id값이 저장되어 있다면
%>
		<input type="button" value="글쓰기" class="btn" onclick="location.href='imgWrite.jsp'">
	</div>
<% 
	}
%>
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