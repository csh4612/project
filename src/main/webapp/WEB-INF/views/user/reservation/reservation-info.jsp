<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

<jsp:include page="/WEB-INF/views/include/head.jsp"></jsp:include>
<style>
.myReservation{
	margin-top: 200px;
	height: 700px;
}
.card-text{
	font-size: small;
	margin-bottom: 5px;
}
.eiName{
	display:block;
    overflow: hidden; 
	text-overflow: ellipsis;
    white-space: nowrap; 
	width: 239.5px;

}
</style>
</head>

<body>
	<div class="container myReservation">
      	<div class="row">
      		<div class="col-lg-6" style="text-align: center;">
      		 	<div class="section-title">
		          <p>진행중 예약</p>
		        </div>
          	</div>
          	<div class="col-lg-6" style="text-align: center;">
          		 <div class="section-title">
		          <p>지난 예약</p>
		        </div>
          	</div>
   		</div>
		<div class="row">
			<div class="col-lg-6" id="leftDiv">
				<table class="table" style="text-align: center">
					<thead>
						<tr>
							<th>예약번호</th>
							<th>전시회명</th>
							<th>예약일</th>
							<th>상세보기</th>
						</tr>
					</thead>
					<tbody id="leftReservation">
					</tbody>
				</table>
          	</div>
			<div class="col-lg-6" id="rightDiv">
				<table class="table" style="text-align: center">
					<thead>
						<tr>
							<th>예약번호</th>
							<th>전시회명</th>
							<th>예약일</th>
							<th>상세보기</th>
						</tr>
					</thead>
					<tbody id="rightReservation">
					</tbody>
				</table>
         	</div>
		</div>
		<div class="row">
			<div class="col-lg-6"></div>
			<div class="col-lg-6">
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center" id="pastPageList">
					</ul>
				</nav>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-1" id="leftModal">
      		</div>
      		<div class="col-lg-1" id="rightModal">
          	</div>
		</div>
	</div>
<script>
const size = 5;
window.addEventListener('load', getProgressTickets());
window.addEventListener('load', getPastTickets(1));
function getProgressTickets(){
	var xhr = new XMLHttpRequest();
	xhr.open('GET', '/ticket/progress');
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var res = JSON.parse(xhr.responseText);
			var table = '';
			if(res.length === 0){
				table += '<tr>';
				table += '<td colspan="4" align="center">진행중인 예약이 없습니다.</td>';
				table += '</tr>';
				document.querySelector('#leftReservation').innerHTML = table;
				return;
			}
			
			var modal= '';
			for(var ticket of res){
				//진행중 테이블 
				table += '<tr>';
				table += '<td>' + ticket.tiNum + '</td>';
				table += '<td class="eiName">' + ticket.eiName + '</td>';
				table += '<td>' + ticket.tiDate + '</td>';
				table += '<td><button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#leftReserv' + ticket.tiNum +'">상세보기</button></td>';
				table += '</tr>';
				//진행중 상세보기 모달
				modal += '<div class="modal fade" id="leftReserv' + ticket.tiNum + '" tabindex="-1" aria-hidden="true">'; 
				modal += '<div class="modal-dialog">'; 
				modal += '<div class="modal-content" style="width: 380px">'; 
				modal += '<div class="modal-header">'; 
				modal += '<button type="button" class="close" data-dismiss="modal" aria-label="Close">'; 
				modal += '<span aria-hidden="true">&times;</span>'; 
				modal += '</button>'; 
				modal += '</div>'; 
				modal += '<div class="modal-body">'; 
				modal += '<div class="card mb-3">';
				modal += '<img src="/upload/'+ ticket.imgPath + '" class="card-img-top" style="width: 344px; height: 200px">';
				modal += '<div class="card-body">';
				modal += '<h5 class="card-title">' + ticket.eiName + '</h5>';
				modal += '<hr>';
				modal += '<p class="card-text">주문번호 : <span>' + ticket.piMerchantId + '</span></p>';
				modal += '<p class="card-text">장소 : <span>' + ticket.giName + '</span></p>';
				modal += '<p class="card-text">관람일시 : <span>' + ticket.tiDate + '</span> <span>' + ticket.tiTime +'</span></p>';
				modal += '<p class="card-text">예매수 : <span>'+ ticket.tiNumber + '</span>장</p>';
				modal += '<hr>';
				modal += '<button type="button" class="btn btn-outline-danger" style="width: 300px; height: 38px" data-tiNum="' + ticket.tiNum + '" onclick="cancel(this)">예매취소</button>';
				modal += '</div>';
				modal += '</div>';
				modal += '</div>'; 
				modal += '</div>'; 
				modal += '</div>'; 
				modal += '</div>'; 
			}	
			document.querySelector('#leftReservation').innerHTML = table;
			document.querySelector('#leftModal').innerHTML = modal;
		}
	}
	xhr.send();
}
function getPastTickets(page){
	var xhr = new XMLHttpRequest();
	var url = '/ticket/past/?size=' + size + '&page='+ (page-1);
	xhr.open('GET', url);
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var res = JSON.parse(xhr.responseText);
			var table = '';
			console.log(res);
			if(res.content.length === 0){
				table += '<tr>';
				table += '<td colspan="4" align="center">지난 예약이 없습니다.</td>';
				table += '</tr>';
				document.querySelector('#rightReservation').innerHTML = table;
				return;
			}
			var modal= '';
			for(var ticket of res.content){
					//지난 테이블 
					table += '<tr>';
					table += '<td>' + ticket.tiNum + '</td>';
					table += '<td class="eiName">' + ticket.eiName + '</td>';
					table += '<td>' + ticket.tiDate + '</td>';
					table += '<td><button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#leftReserv' + ticket.tiNum +'">상세보기</button></td>';
					table += '</tr>';
					//지난 상세보기 모달
					modal += '<div class="modal fade" id="leftReserv' + ticket.tiNum + '" tabindex="-1" aria-hidden="true">'; 
					modal += '<div class="modal-dialog">'; 
					modal += '<div class="modal-content" style="width: 380px">'; 
					modal += '<div class="modal-header">'; 
					modal += '<button type="button" class="close" data-dismiss="modal" aria-label="Close">'; 
					modal += '<span aria-hidden="true">&times;</span>'; 
					modal += '</button>'; 
					modal += '</div>'; 
					modal += '<div class="modal-body">'; 
					modal += '<div class="card mb-3">';
					modal += '<img src="/upload/'+ ticket.imgPath + '" class="card-img-top" style="width: 344px; height: 200px">';
					modal += '<div class="card-body">';
					modal += '<h5 class="card-title">' + ticket.eiName + '</h5>';
					modal += '<hr>';
					modal += '<p class="card-text">주문번호 : <span>' + ticket.piMerchantId + '</span></p>';
					modal += '<p class="card-text">장소 : <span>' + ticket.giName + '</span></p>';
					modal += '<p class="card-text">관람일시 : <span>' + ticket.tiDate + '</span> <span>' + ticket.tiTime +'</span></p>';
					modal += '<p class="card-text">예매수 : <span>'+ ticket.tiNumber + '</span>장</p>';
					modal += '<hr>';
					if(ticket.rviNum != null){
						modal += '<button type="button" class="btn btn-success" onclick="alert(\'이미 작성하신 리뷰가 있습니다. \')" style="width: 300px; height: 38px">리뷰작성 완료</button>';
					}else{
						modal += '<button type="button" class="btn btn-outline-primary" onclick="goReview(' + ticket.tiNum + ')" style="width: 300px; height: 38px">리뷰작성</button>';
					}
					modal += '</div>';
					modal += '</div>';
					modal += '</div>'; 
					modal += '</div>'; 
					modal += '</div>'; 
					modal += '</div>'; 
			}
			var disable = '';
			var clickEvent = 'onclick="getPastTickets(' + res.number + ')"';
			if(res.first){
				disable = 'disabled';
				clickEvent = '';
			}
			
			var li = '<li class="page-item ' + disable + '" ' + clickEvent +'>';
			li += '<a class="page-link" tabindex="-1">이전</a>';
			li += '</li>';
			
			var startPage = Math.floor((((Number(res.number) + 1) - 1) / size)) * size + 1;
			var endPage = startPage + size - 1;
			if(endPage > res.totalPages){
				endPage = res.totalPages;
			}
			for(startPage; startPage<=endPage; startPage++){
				if(startPage === page){
					li += '<li class="page-item active" onclick="getPastTickets(' + startPage + ')"><a class="page-link">'+ startPage +'</a></li>';
					continue;
				}
				li += '<li class="page-item" onclick="getPastTickets(' + startPage +')"><a class="page-link">'+ startPage +'</a></li>';
			}
			
			disable = '';
			clickEvent = 'onclick="getPastTickets(' + (Number(res.number)+2) + ')"';
			
			if(res.last){
				disable = 'disabled';
				clickEvent = '';
			}
			
			li += '<li class="page-item ' + disable +'" ' + clickEvent + '>';
		    li += '<a class="page-link">다음</a>';
		  	li += '</li>';
			
			
			document.querySelector('#rightReservation').innerHTML = table;
			document.querySelector('#rightModal').innerHTML = modal;
			document.querySelector('#pastPageList').innerHTML = li;
		}
	}
	xhr.send();
}
function cancel(obj){
	if(confirm("정말 취소 하시겠습니까 ?")){
		var tiNum = obj.getAttribute('data-tiNum')
		
		var xhr = new XMLHttpRequest();
		
		xhr.open('DELETE', '/ticket/cancel/' + tiNum );
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				var res = JSON.parse(xhr.responseText);
				if(res){
					alert('예매가 취소 되었습니다.');
					window.location.reload();
				}else{
					alert('예매취소에 실패하였습니다.');
				}
			}
		}
		xhr.send();
	}
	else{
		return;
	}
}
function goReview(tiNum){
	location.href = '/views/user/review/review-save/?tiNum=' + tiNum;
}
</script>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>