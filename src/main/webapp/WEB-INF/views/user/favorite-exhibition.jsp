<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

<jsp:include page="/WEB-INF/views/include/head.jsp"></jsp:include>
<style>
.myreservation{
	margin-top: 200px;
	height: 1000px
}
.listTitle{

font-weight: bold;

}
.uiName{
font-size: 30px;
font-weight: bold;
}
.poster{
width:80px;
height:80px;

}

.favoriteList{

}
</style>

</head>

<body>
	<div class="container myreservation">
		<p class ="uiName">${userInfo.uiName}님의 찜목록</p>
		<label for="allCheck">모두 선택</label>
		<input class="allCheck" type="checkbox" name="allCheck" id = "allCheck"/>
		
		<button class="delBtn" type="button" class="selectDelete_btn">선택 삭제</button>
				<div>
			<table class="table" id="myreservation">
				<thead>
				<tr>
				<th>포스터</th>
				<th>전시회명</th>
				<th>전시관명</th>
				<th>개장날짜</th>
				<th>폐장날짜</th>
				<th>선택</th>
				</tr>
				</thead>
				<tbody id="favoriteList">
				<tbody>
				</tbody>
			</table>
		</div>
	</div>

<script>




var url = '/favorite-exhibitions?uiNum=${userInfo.uiNum}';
window.onload = function(){
	var xhr = new XMLHttpRequest();
	xhr.open('GET',url);
	xhr.onreadystatechange = function(){
		if(xhr.readyState==4 && xhr.status==200){
			var res = JSON.parse(xhr.responseText);
			console.log(res);
			var table = '';
			for(var favoriteExhibition of res){
				
				table += '<tr class="listTitle"">';
				table += '<td><img class="poster" src="/resources/assets/img/exhibition/' + favoriteExhibition.exhibitionInfo.fileInfo.fiPath + '">';
				table += '<td>' + favoriteExhibition.exhibitionInfo.eiName +'</td>'; 
				table += '<td>' + favoriteExhibition.exhibitionInfo.galleryInfo.giName +'</td>';
				table += '<td>' + favoriteExhibition.exhibitionInfo.eiStartDate +'</td>';
				table += '<td>' + favoriteExhibition.exhibitionInfo.eiEndDate +'</td>';
				table += '<td><input type="checkbox" name="chBox" class="chBox"><td>';
				table += '</tr>';				
				
				}
					document.querySelector('#favoriteList').innerHTML = table;
			}
		}
	xhr.send();
}

$('#allCheck').on('click', function() {
	 var chk = $("#allCheck").prop("checked");
	 if(chk) {
	  $(".chBox").prop("checked", true);
	 } else {
	  $(".chBox").prop("checked", false);
	 }
	 $(".chBox").on('click',function(){
		  $("#allCheck").prop("checked", false);
		 });
	});
	

</script>

<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>