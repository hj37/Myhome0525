<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
<!--     <meta name="viewport" content="width=device-width, initial-scale=1"> -->
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>로그인 화면</title>

    <!-- 부트스트랩 -->
<!--     <link href="css/bootstrap.min.css" rel="stylesheet"> -->

    <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
    <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
 
  		<script src="js/jquery.min.js"></script>
		<script src="js/jquery.dropotron.min.js"></script>
		<script src="js/skel.min.js"></script>
		<script src="js/skel-layers.min.js"></script>
		<script src="js/init.js"></script>
			<link rel="stylesheet" href="css/skel.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/style-wide.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
		
		
		
<script type="text/javascript">
 	function winopen(){//아래의 아이디중복체크 버튼 눌렀을때 호출되는 함수 
 		//1. 아이디를 입력했는지 검사
 		//아이디를 입력하지 않았다면
 		if(document.f.id.value == ""){
 			alert("아이디를 입력하세요.");
 			//아이디 입력 <input>태그에 포커스깜빡
 			document.f.id.focus();
 			return;
 		}
 		//아이디를 입력 했다면
 		//입력한 아이디를 얻는다.
 		var fid = document.f.id.value;
 		
 		//새 창을 join_IDCheck.jsp로 띄우며 전달값으로 바로위에 입력한 아이디를 전달함
 		// 새 창의 width와 height를 크기를 지정
 		window.open("join_IDCheck.jsp?userid="+fid, "","width=400,height=200");
 		
 	
 	}
 

 	function openmail(){//아래의 아이디중복체크 버튼 눌렀을때 호출되는 함수 
 		//1. 아이디를 입력했는지 검사
 		//아이디를 입력하지 않았다면
 		if(document.f.email.value == ""){
 			alert("이메일을 입력하세요.");
 			//아이디 입력 <input>태그에 포커스깜빡
 			document.f.email.focus();
 			return;
 		}
 		//아이디를 입력 했다면
 		//입력한 아이디를 얻는다.
 		var femail = document.f.email.value;
 		var check = -1;
 		
 		//새 창을 join_IDCheck.jsp로 띄우며 전달값으로 바로위에 입력한 아이디를 전달함
 		// 새 창의 width와 height를 크기를 지정
 		window.open("join_IDCheck2.jsp?email="+femail+"&check="+check,"","width=400,height=200");
 		
 	
 	}
 
 

  function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
</script>


	</head>
	<body>

		<!-- Wrapper -->

				<!-- Header -->
										<jsp:include page="header.jsp"/>

				


 
    
    
    	<!-- Footer -->
		<div id="footer" class="wrapper style2">
			<div class="container">
				<section>
					<header class="major">
						<h2>Mauris vulputate dolor</h2>
						<span class="byline">Integer sit amet pede vel arcu aliquet pretium</span>
					</header>
					<form method="post" action="joinPro.jsp" id="join" method="post" name="f">
						<div class="row half">
							<div class="12u">
								<label>User ID</label>
								<input class="id" type="text" name="id"  placeholder="ID"/>	<br>
								<input type="button" value="ID_CHECK" class="button alt" onclick="winopen()"><br>			
							</div>
							
							
						</div>
						<div class="row half">
							<div class="12u">
								<label>Password</label>
								<input type="password" name="passwd"  placeholder="Password" />
							</div>
						</div>
						<div class="row half">
							<div class="12u">
							<label>Retype Password</label>
								<input type="password" name="passwd2" placeholder="Retype Password" />
							</div>
						</div> 
						
						<div class="row half">
							<div class="12u">
								<label>Name</label>
								<input type="text" name="name" placeholder="Name" />
							</div>
						</div>
						
						<div class="row half">
							<div class="12u">
								<label>E-Mail</label>
								<input type="email" name="email"  placeholder="Email" />
								<input type="button" value="이메일인증" class="button alt" onclick="openmail()"><br>			
							</div>
						</div>
						<div class="row half">
							<div class="12u">
								<label>Address</label>
								<input type="text" id="sample6_postcode" name="address" placeholder="우편번호" >
								<br>
								<input type="button" class="button alt" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" id="postcode_btn"><br>
								<input type="text" id="sample6_address" name="addr1" placeholder="주소" >
								<input type="text" id="sample6_address2" name="addr2" placeholder="상세주소">
								<br>
							</div>
						</div>
						
						
						
	
						
						<div class="row half">
							<div class="12u">
								<ul class="actions">
									<li>
										<input type="submit" value="Register" class="button alt" />
										<input type="reset" value="Reset" class="button alt" />
										
									</li>
								</ul>
							</div>
						</div>
					</form>
				</section>
			</div>
		</div>
    
    	<!-- Copyright -->
				<jsp:include page="bottom.jsp"/>

    
    
  </body>
</html>