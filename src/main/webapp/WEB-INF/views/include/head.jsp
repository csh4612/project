<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<style>
.center {
width: 200px;
  position: absolute;
  top: 75%;
  left: 52%;
  height: 100px;
  margin-top: -40px;
  margin-left: -200px;
  border-radius: 2px;
  
}
.headsearchInput {
  height: 2em;
  width: 200px;
  padding: 0 10px;
  border-color: black;
  border-radius: 6px;

}

.headPlacholder {
	color: #d2d2d2;
}
#suggestListDiv {
	width: 200px;
	margin-top: 2px;
	position: absolute;
	background: white;
	padding: 0 2px;
	border-radius: 5px;
}

.item {
	height: 1.8em;
	width: 200px;
	outline: none;
}

.item:hover {
	color: #black;
	background: #dcdcdc;
	
}
.text {
	font-weight: bold;
}

</style>
<jsp:include page="/WEB-INF/views/include/css.jsp"></jsp:include>
</head>

<body>
	<!-- ======= Header ======= -->
	<header id="header" class="fixed-top ">
		<div class="container">

			<!--검 색 창   -->
			<form action="/search" method="get" name="frm">
				<div>
					<div>
						<div class="container d-flex align-items-center"">
							<input autocomplete="off" type=text name="keyword" id="headPlacholder" placeholder="전시관,전시회 검색"
								class="headsearchInput" id="searchInput"
								onkeyup="headSuggest(this);">
							<div id="divBtnDelete" style="display: none;">
								<button id="btn_search">검색</button>
							</div>
							<div id="suggestListDiv"></div>
						</div>
					</div>
				</div>
			</form>

			<a href="/views/login" style="float: right"
				class="get-started-btn ml-auto">로그인/회원가입</a>


		</div>
		<script>
function headSuggest(target){
	console.log(target.value);
	if(!target.value.trim()) return;
var tKeyword ='?eiName='+ target.value;
var encodeWord = encodeURI(tKeyword);
var xhr = new XMLHttpRequest();
xhr.open('GET','/exhibition-list'+tKeyword);
xhr.onreadystatechange = function(){
	if(xhr.readyState==4&& xhr.status==200){
		var res = JSON.parse(xhr.responseText);
		console.log(res);
		html = '';
		for(var exhibition of res){
			html +=	'<div class="item">';
			html += exhibition.eiName;
			html +=	'<span class="text"></span>';
			html += '</div>';
		}
		document.querySelector('#suggestListDiv').innerHTML = html;
		}
	}
	xhr.send();
}
</script>
    <div class="container d-flex align-items-center">
    
      <div onclick="location.href='/'">
      <h1 class="logo" style="cursor: pointer"><img src="/resources/assets/img/logo.png" class="img-fluid" ></h1>
      </div>
      <!-- Uncomment below if you prefer to use an image logo -->
      <!-- <a href="index.html" class="logo"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

      <nav class="nav-menu d-none d-lg-block">

        <ul>          
          <li class="drop-down"><a href="#">전시회 목록</a>
            <ul>                           
              <li><a href="/views/exhibition/openingList">진행중인 전시회</a></li>
              <li><a href="/views/exhibition/closeList">종료된 전시회</a></li>            
              <li><a href="/views/exhibition/futureList">진행 예정 전시회</a></li>   
            </ul>
          </li>
          
          <li class="active"><a href="/views/gallery/list">전시관 목록</a></li>

          <li class="drop-down"><a href="#">커뮤니티 목록</a>
            <ul>
              <li class="drop-down"><a href="#">공지사항</a>
                <ul>
                  <li><a href="#">공지사항</a></li>
                  <li><a href="#">예매/취소 방법</a></li>
                  <li><a href="#">이용방법</a></li>
                </ul>
              </li>              
              <li><a href="#">후기/추천</a></li>
              <li><a href="#">Q&A</a></li>              
            </ul>
          </li>
          
          <li class="drop-down"><a href="#">전시회 등록 및 수정</a>
            <ul>                           
              <li><a href="/views/exhibition/insert">전시회 등록</a></li>
              <li><a href="/views/exhibition/exhibition-update">전시회 수정</a></li> 
              <li><a href="/views/reservation/reservation-insert">전시회 예약 등록</a></li>             
            </ul>
          </li>
        </ul>

      </nav><!-- .nav-menu -->
     </div>
	</header>
	<!-- End Header -->
</body>
</html>