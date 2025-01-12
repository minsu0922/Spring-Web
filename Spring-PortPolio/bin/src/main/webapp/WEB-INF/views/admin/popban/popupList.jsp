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
		
		$("#formPopup").attr("action", "/popban/popup_list.do"); // URL 변경
		$("#formPopup").submit();
	}

	function goDetail(popban_sn) {
		$("#popban_sn").val(popban_sn);
		$("#formPopup").attr("action", "/popban/popup_info.do"); // URL 변경
		$("#formPopup").submit();
	}
	
	function goRegist() {
		window.location.href = '/admin/popban/popup_regist.do';
    }
	
	function deletePopup(popban_sn){
		if(confirm("팝업을 삭제하시겠습니까?")){ // 메시지 수정
			$("#popban_sn").val(popban_sn);
			$("#formPopup").attr("action", "/popban/popup_delete.do"); // URL 변경
			$("#formPopup").submit();
		}
	}
	
</script>
<h2 class="subtitle">팝업 관리</h2>
<form id="formPopup" name="formPopup" method="post"> <!-- form id 및 name 변경 -->
<input type="hidden" name="popban_sn" id="popban_sn" />
<div class="search-box">
      <div class="search-box1">
      <label for="search_site_sn">검색 유형</label>
		 <select name="search_site_sn" id="search_site_sn" class="select01">
 			<option selected value=''>사이트 분류</option>
 			<option value="" ></option>
			<option value="" ></option>
		</select>
		<select name="search_del_yn" id="search_del_yn" class="select01">
 			<option selected value=''>사용여부</option>
 			<option value='N' ${popupDto.use_yn eq 'N' ? 'selected="selected"' : '' }>사용</option>
	  		<option value='Y' ${popupDto.use_yn eq 'Y' ? 'selected="selected"' : '' }>미사용</option>
		</select>
		</div>
		<div class="search-box2">
		<span>등록일</span>
		<input type="text" id="search_datestart" name="search_datestart" value="${popupDto.search_datestart }" style="width:80px; margin: 0 10px;" class="input01">
        <span>~</span>
 		<input type="text" id="search_dateend" name="search_dateend" value="${popupDto.search_dateend }" style="width:80px; margin: 0 10px;" class="input01">
		<input type="text" name="search_word" id="search_word" value="${popupDto.search_word}" placeholder="제목을 입력하세요." style="width:250px;" class="input01"/>
		<button class="btn01 input_btn01" type="button" onclick="search2()">조회</button>
		</div>
</div>
<p class="total_title">Total: <span class="color">${popupCount}</span>건</p><!-- mainSlideCount -> popupCount로 변경 -->

<div class="bdtable">
		<table>
			<thead>
				<th>순번</th>
				<th>사이트</th>
				<th>제목</th>
				<th>사용여부</th>
				<th>순서</th>
				<th>등록일자</th>
				<th>삭제</th>
			</thead>
			<tbody>
			<c:choose>
            <c:when test="${!empty popups}"> <!-- mainSlides -> popups로 변경 -->
                <c:forEach var="popup" items="${popups}" varStatus="status"> <!-- mainSlides -> popups로 변경 -->
                    <tr style="text-align: center;">
                        <td>${status.index + 1}</td>
                        <td>${popup.site_sn}</td>
                        <td><a onclick="goDetail('${popup.popban_sn}')">${popup.popban_nm}</a></td> <!-- mainSlide 관련 부분 수정 -->
                        <td>${popup.use_yn == 'Y' ? '사용' : '미사용'}</td>
                        <td>${popup.popban_order}</td>
                        <td>${popup.reg_dt}</td>
                        <td><button class="del_btn01" type="button" onclick="deletePopup('${popup.popban_sn}')">삭제</button></td> <!-- mainSlide 관련 부분 수정 -->
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="8" style="text-align: center;">등록된 팝업이 없습니다.</td> <!-- mainSlide 관련 메시지 수정 -->
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
		</table>
    </div>
    <div class="clearfix mrtp">
		<button class="btn02 input_btn01 right" type="button" onclick="goRegist()">등록</button>
	</div>
</form>
