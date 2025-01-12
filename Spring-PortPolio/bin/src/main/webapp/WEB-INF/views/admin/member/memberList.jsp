<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript">

	$(document).ready(function() {
		
		initDatepicker("#search_datestart");
		initDatepicker("#search_dateend");
		
	/* 	var msg2 = '${msg}';
		if (msg2 !== '') {
			alert(msg2);
		} */
	});

	function search2() {
		var start = $("#search_datestart").val();
		var end = $("#search_dateend").val();
		
		if (start != '' && end == '') {
		    alert("등록일을 설정해주세요.");
		    $("#search_dateend").focus();
		    return;
		} else if (start == '' && end != '') {
		    alert("등록일을 설정해주세요.");
		    $("#search_datestart").focus();
		    return;
		}
		
		$("#formMember").attr("action", "/admin/member/member_list.do");
		$("#formMember").submit();
	}

	function godetail(user_id) {
		$("#user_id").val(user_id);
		$("#formMember").attr("action", "/admin/member/member_info.do");
		$("#formMember").submit();
	}
	
	function downloadExcel() {
        var table = document.getElementById('excelTable');
        var ws = XLSX.utils.table_to_sheet(table);
        var wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, "사용자목록");
        XLSX.writeFile(wb, "사용자목록.xlsx");
    }
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<meta charset="UTF-8">
<head>
<title>Insert title here</title>
</head>
<body>
<h2 class="subtitle">회원관리</h2>
<form id="formMember" name="formMember" method="post">
<input type="hidden" name="user_id" id="user_id" />
<div class="search-box">
      <div class="search-box1">
      <label for="search_type">회원유형</label>
		<select name="search_type" id="search_type" class="select01">
	  			<option selected value=''>유형</option>
	  			<option value="user_name" ${memberDto.search_type eq 'user_name' ? 'selected="selected"' : ''}>이름</option>
				<option value="user_id" ${memberDto.search_type eq 'user_id' ? 'selected="selected"' : ''}>아이디</option>
		 </select>
		 <select name="search_auth" id="search_auth" class="select01">
 			<option selected value=''>권한</option>
 			<option value="ROLE_ADMIN" ${memberDto.search_auth eq 'ROLE_ADMIN' ? 'selected="selected"' : ''}>관리자</option>
			<option value="ROLE_USER" ${memberDto.search_auth eq 'ROLE_USER' ? 'selected="selected"' : ''}>사용자</option>
		</select>
		<select name="search_del_yn" id="search_del_yn" class="select01">
 			<option selected value=''>사용여부</option>
 			<option value='N' ${memberDto.search_del_yn eq 'N' ? 'selected="selected"' : '' }>사용</option>
	  		<option value='Y' ${memberDto.search_del_yn eq 'Y' ? 'selected="selected"' : '' }>미사용</option>
 			<%-- <c:forEach var="searchScsnYnCd" items="${searchScsnYnCode}" varStatus="status">
				<option value="${searchScsnYnCd.codeId}" ${searchScsnYnCd.codeId == memberVO.searchScsnYn ? 'selected="selected"' : '' }>${searchScsnYnCd.codeName}</option>
			</c:forEach> --%>
		</select>
		&nbsp;
		<span>등록일</span>
		<input type="text" id="search_datestart" name="search_datestart" value="${memberDto.search_datestart }" style="width:80px" >
		&nbsp;
		~
		&nbsp;
		<input type="text" id="search_dateend" name="search_dateend" value="${memberDto.search_dateend }" style="width:80px" >
		&nbsp;
		<input type="text" name="search_word" id="search_word" value="${memberDto.search_word}" style="width:200px;" />
		<a onclick="search2()">조회</a>
	</li>
</ul>
<button onclick="downloadExcel()">엑셀 다운로드</button>
<div style="height: 350px; width: 600px; background-color: white;">
		<table id="excelTable">
			<thead>
			<tr>
		</div>
      <div class="search-box2">
        <label for="search_datestart">등록일</label>
		<input type="text" id="search_datestart" name="search_datestart" value="${memberDto.search_datestart }" class="input01" style="width:80px; margin: 0 10px;" >
		<span>~</span>
		<input type="text" id="search_dateend" name="search_dateend" value="${memberDto.search_dateend }" class="input01" style="width:80px; margin: 0 10px;" >
		<input type="text" name="search_word" id="search_word" value="${memberDto.search_word}" class="input01" style="width:250px;" />
		<button class="btn01 input_btn01" type="button" onclick="search2()">조회</button>
		</div>
</div>
<div class="bdtable">
		<table>
			<thead>
				<th style="width : 80px;">순번</th>
				<th style="width : 80px;">이름</th>
				<th style="width : 80px;">아이디</th>
				<th style="width : 80px;">권한</th>
				<th style="width : 80px;">사용여부</th>
				<th style="width : 80px;">등록일</th>
				<th style="width : 80px;">최종접속일</th>
			</tr>
			</thead>
			<tbody>
			</thead>
			<c:choose>
				<c:when test="${! empty memberList }">
					<c:forEach var="test" items="${memberList }" varStatus="status">
						<tr style="text-align:center;">
							<td>${status.index +1 }</td>
							<td>${test.user_name }</td>
							<td><a onclick="godetail('${test.user_id }')">${test.user_id }</a></td>
							<td>
								${test.user_role eq 'ROLE_USER' ? '사용자' : '관리자' }
							</td>
							<td>
								${test.del_yn eq 'Y' ? '미사용' : '사용' }
							</td>
							<td>${test.insert_date }</td>
							<td>구현중</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td>사용자 리스트가 없습니다</td>
					</tr>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
    </div>
</form>

        <!-- <div class="number-navi">
            <ul>
                <li class="first"><a href=""><<</a></li>
                <li class="prev"><a href=""><</a></li>
                <li><a href="">1</a></li>
                <li><a href="">2</a></li>
                <li><a href="">3</a></li>
                <li><a href="">4</a></li>
                <li class="active"><span>5</span></li>
                <li><a href="">6</a></li>
                <li><a href="">7</a></li>
                <li><a href="">8</a></li>
                <li><a href="">9</a></li>
                <li><a href="">10</a></li>
                <li class="next"><a href="">></a></li>
                <li class="last"><a href="">>></a></li>
            </ul>
        </div> -->