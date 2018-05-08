<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title> 입금전 관리 </title>
<!-- 달력에 필요한 js파일 불러오기 -->
	<script src="//code.jquery.com/jquery-1.12.4.js"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script> 
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css" />
<!-- 내가 만든 달력 제이쿼리 불러오기 ㅇㅅㅇ -->
	<script src="/resources/admin/ordr/js/adminOrderList.js"></script> 
<!-- 내가 쓰는 꾸밈요소 -->
	<link rel="stylesheet" href="/resources/consmr/mem/css/selectView.css?ver=2">
	<link rel="stylesheet" href="/resources/consmr/mem/css/PasswordJoin.css">
	<link rel="stylesheet" href="/resources/consmr/mem/css/OrderList.css">
<style>
.btnjin {
  color: #ffffff;
  background-color: #487BE1;
  border-color: transparent;
}
</style>
<script>
$(document).ready(function(){
	//전체선택 체크박스 클릭 
	$("#allCheck").click(function(){ 
		//만약 전체 선택 체크박스가 체크된상태일경우
		if($("#allCheck").prop("checked")) { 
			//해당화면에 전체 checkbox들을 체크해준다
			$("input[type=checkbox]").prop("checked",true); 
			// 전체선택 체크박스가 해제된 경우
		} else { 
			//해당화면에 모든 checkbox들의 체크를해제시킨다.
			$("input[type=checkbox]").prop("checked",false); 
		}
		//체크박스 선택되면 만들어논 경고문없어지기
		$("#warn").html("");
	})
	//체크박스 선택되면 만들어논 경고문없어지기
	$('input:checkbox[name=checked]').click(function(){
		$("#warn").html("");
	})
});
function creditUpdete(credit){ //처리여부 업데이트될때에 ### credit-> 변수명임 나중에 내 맘대로 정할 수 있음.
	var formData = 'order_state='+credit+"&"; 
	$('input:checkbox[name=checked]:checked').each(function() {
        formData += "order_seq_list="+$(this).val()+"&";
	});
	formData = formData.substr(0,formData.length-1);
	if(formData == 'order_state='+credit){
		$("#warn").html("목록을 선택해주세요!");
	}else{
		$.ajax({
			url: "/creditUpdete.do",
			data: formData,
			type: "post",
			success: function(){
				window.location.href="/creditList.do";
			},
			error:function(xhr,status,error){ //ajax 오류인경우  
// 			      alert("error\nxhr : " + xhr + ", status : " + status + ", error : " + error);       
			}
		})
	}
}
</script>
</head>
<body>
<!-- 상단바 -->
	<div>
		<c:import url="/adminTopMenu.do"/>
	</div>
<!-- 좌측 바 -->
	<div>
		<c:import url="/adminLeftMenu.do?menuCategry=2"/>
	</div>
<!-- 본인 디자인은 여기 안에서 -->
	<div class="mainContainer">
		<div class="col-md-12">
			<h4>입금 전 관리</h4>
			<hr>
		</div>
		<div style="text-align:right;">
			<span class="glyphicon glyphicon-ok" style="color:red;"> </span>
			<b>검색</b> 버튼을 꼭 눌러주세요!
		</div>
		<div class="board view view_v2"><!--view_v2-->
			<table class="basicT" summary="주문관리">
			<thead></thead>
				<tbody>
					<tr>
						<th scope="row" style="width:10%;">검색어</th>
						<td>
							<select style="height: 37px; width:20%; padding-left:10px; float:left;">
								<option value="mem_name" selected>주문자명</option>               
								<option value="mem_id"> 주문자 아이디 </option>
								<option value="mem_ph"> 주문자 휴대전화 </option>
								<option value=""> -------------------------- </option>
								<option value=""> 입금자명 </option>       
							</select> 
							<input type="text" class="textbox" id="" name="" style="width:30%; height: 37px; padding-left:10px; margin-left:15px; float:left;">
						</td>
					</tr>
					<tr>
						<th scope="row">검색어</th>
						<td>
							<select style="height: 37px; width:20%; padding-left:10px; float:left;">
								<option value="pnme" selected>상품명 </option>              
							</select> 
							<input type="text" class="textbox" id="" name="" style="width:30%; height: 37px; padding-left:10px; margin-left:15px; float:left;">
						</td>
					</tr>
					<tr>
						<th scope="row">기간</th>
						<td>
							<form name="" id="" method="POST">
								<div>
									<select style="height:37px; width:15%; padding-left:10px; float:left;">
										<option value="010" selected> 주문일 </option>
										<option value="010" > -------------------- </option>     
									</select>
								</div>
								<div style="float:left;">
									<input class="btn btn-default" type="button" value="오늘" id="today"> &nbsp;
									<input class="btn btn-default" type="button" value="1주일" id="oneweek">&nbsp;
									<input class="btn btn-default" type="button" value="1개월" id="month">&nbsp;
									<input class="btn btn-default" type="button" value="3개월" id="trimester">&nbsp;
									<input class="btn btn-default" type="button" value="6개월" id="halfyear">&nbsp;&nbsp;
									<input type="text" id="oneDatepicker" name="oneDatepicker" style="width:15%; height: 37px;"> &nbsp;&nbsp; ~ &nbsp;&nbsp;
									<input type="text" id="twoDatepicker" name="twoDatepicker" style="width:15%; height: 37px;">
									<button type="button" class="btn btn-info" onclick="" style="margin-left:15px;">조회</button>
								</div>
							</form>
						</td>
					</tr>
<!-- 						<tr> -->
<!-- 							<th scope="row">입금상태</th> -->
<!-- 							<td></td> -->
<!-- 						</tr> -->
				</tbody>
			</table>
		</div>
		<div style="width:100%; height:30px;"><!-- 빈얖 --></div>
		<div style="width:100%; height:50px;">
			<center>
				<button class="btn btn-default">검색</button>
				<button class="btn btn-default">초기화</button>
			</center>
		</div>
		<font><b>º 검색결과</b></font>
		<div style="border:1px solid #EAEAEA; width:100%; height:40px;">
			<div style="border:1px solid #FCFCFC; width:25%; height:40px; ">
				<select class="form-control" id="select" style="padding-left:10px;">
					<option>주문일 순</option>
					<option>주문일 역순</option>
					<option>입금여부 순</option>
					<option>입금여부 역순</option>
				</select>
			</div>
		</div>
		<br>
		<div class="board view view_v2">
			<table class="basicT" id="store" summary="배송상품">
			<thead></thead>
				<tr>
					<th colspan="8" style="border-bottom: 1px solid #C6C6C6; width:25%; height:30px;">
						<a href="javascript:creditUpdete('입금확인')" class="btn btnjin btn-xs" style="margin-left:10px; float:left;"> 입금확인 </a>
						<a href="javascript:creditUpdete('상품준비중')" class="btn btnjin btn-xs" style="margin-left:10px; float:left;"> 상품준비중 </a>
						<font id="warn" style="color:red; margin-left:10px; float:left;"></font>
					</th>
				</tr>
				<tr>
					<th style="text-align: center;">
						<input type="checkbox" name="allCheck" id="allCheck">
					</th>
					<th style="text-align: center;">주문일</th>
					<th style="text-align: center;">주문번호</th>
					<th style="text-align: center;">상품명</th>
					<th style="text-align: center;">주문자</th>
					<th style="text-align: center;">입금자</th>
					<th style="text-align: center;">입금금액</th>
					<th style="text-align: center;">처리여부</th>
				</tr>
				<c:forEach var ="ordrVO" items="${CreditList}">
				<tr onmouseover="this.style.backgroundColor = '#EBF7FF'" onmouseout="this.style.backgroundColor = ''" style="cursor:pointer">
					<td style="text-align: center;">
						<input type="checkbox" name="checked" id="checked" value="${ordrVO.order_seq}">
					</td>
					<td style="text-align: center;"> ${ordrVO.order_date} </td>
					<td style="text-align: center;"> ${ordrVO.order_seq} </td>
					<td style="text-align: center;"> ${ordrVO.prodct_nme} </td>
					<td style="text-align: center;"> ${ordrVO.mem_name} </td>
					<td style="text-align: center;"> ${ordrVO.mem_name} </td>
					<td style="text-align: center;"> ${ordrVO.order_sum} </td>
					<td style="text-align: center;" id=""> ${ordrVO.order_state} </td>
				</tr>
				</c:forEach>
<!-- 					<tr> -->
<!-- 						<td colspan="7" bgcolor="#EAEAEA" style="border-bottom: 1px solid #C6C6C6; width:25%; height:30px;"> -->
<!-- 							<a href="#" class="btn btnjin btn-xs" style="margin-left:10px; float:left;"> 입금 전 </a>  -->
<!-- 							<a href="#" class="btn btnjin btn-xs" style="margin-left:10px; float:left;"> 입금확인 </a> -->
<!-- 							<a href="#" class="btn btnjin btn-xs" style="margin-left:10px; float:left;"> 상품준비중 </a> -->
<!-- 						</td> -->
<!-- 					</tr> -->
			</table>
		</div>
		<div style="width:100%; height:30px;"><!-- 빈얖 --></div>
	</div><!-- 지워지면안됨 -->
</body>
</html>