<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
</head>
<style>

.table-sap > thead > tr > th {
	text-align:left;
	padding-left:15px;
	padding-top:5px;	
}

.table-sap > tbody > tr > td {
	padding-left:15px;
	padding-top:5px;
	padding-bottom:5px;
}

.table-sap1 {
	border-top: 2px solid #333;
	width:490px;
	margin-left:5px;
	margin-bottom:5px;
}

.table-sap1 > tbody > tr > td {
	min-height: 46px;
	height: 46px;
	border-bottom: 1px solid #e6e6e6;
	text-align: center;
	word-break : break-all; /* í­ë§žì¶¤ */
	border:1px solid #E6E6E6;
}

.table-sap1td1 {
	padding-left:15px;
	width:90px;
	background-color:#f5f5f5;
}

.table-sap1 > tbody > tr > td > select {
	width:66px;
}


.table-text {
	width:50px;
	min-height:30px;
	height:30px;
	font-size:12px;
}

.table-text1 {
	width:345px;
	min-height:30px;
	height:30px;
	font-size:12px;
}

.table-sap2td1 {
	padding-left:15px;
	padding-top:5px;
	padding-bottom:5px;
}

.table-sap2td2 {
	text-align:right;
	padding-right:5px;
}

.table-sap3 {
	border-top: 2px solid #333;
	width:490px;
	margin-left:5px;
	margin-bottom:5px;
}

.table-sap3 > thead > tr > th {
	font-weight:bold;
	min-height: 30px;
	height: 25px;
	border-bottom: 1px solid #e6e6e6;
	background-color: #f5f5f5;
	text-align: center;
	padding:5px;
	border:1px solid #E6E6E6;
}

.table-sap3 > tbody > tr > td {
	min-height: 30px;
	height: 25px;
	border-bottom: 1px solid #e6e6e6;
	text-align: center;
	word-break : break-all; /* í­ë§žì¶¤ */
	padding:5px;
	border:1px solid #E6E6E6;
}

.table-sap4 {
	margin-top:10px;
	float:right;
}

.table-sap4 > tbody > tr > td {
	text-align:right;
	padding-right:5px;
	padding-top:5px;
	padding-bottom:5px;
	width:95%
}

.table-sap4 > tbody > tr > td > select {
	width:95px;
	min-height:30px;
	height:30px;
	font-size:12px;
}

/*---------------------- table - list ----------------------*/

</style>

<!-- 메뉴 등록  -->
<body style="overflow-x: hidden;">
	<div class="login-popup">
		<!-- 조회 및 검색 영역 시작 -->		
		<table border="1" class="table-sap1">
			<tbody>
				<tr>
					<th>메뉴명</th>
					<th>
						<input type="text" name="searchKeyword" id="searchKeyword" value="" placeholder="메뉴를 입력하세요."/>
					</th>
					<th>
						<input type="button" value="메뉴검색" id="btn_search_menu_popup" class="btn_m"/>
					</th>	
				</tr>
			</tbody>
		</table>
		<!-- 조회 검색 영역 끝 -->

		<!-- 조회 결과 선택 영역 시작 -->			
		<table class="table-sap3">
			<thead>
				<tr>
					<th>메뉴명</th>
					<th>메뉴ID</th>
					<th>메뉴URL</th>
					<th>메뉴깊이</th>
					<th>사용여부</th>
					<th>선택</th>
				</tr>
			</thead>
			<tbody id="menu_list">
				
			</tbody>
		</table>
			<!-- 버튼 영역 시작 -->	
			<div class="table-sap4">
				<input type="button" value="닫기" class="btn_sap" id="btn_close">
				<input type="button" value="선택" class="btn_sap1" id="btn_select_popup" >
			</div>
			<!-- 버튼 영역 끝 -->
		<!-- 조회 결과 선택 영역 끝 -->
	</div>
</body>
<!-- 메뉴 등록 종료 -->
<script src="/resources/js/admin/menu.js"></script>