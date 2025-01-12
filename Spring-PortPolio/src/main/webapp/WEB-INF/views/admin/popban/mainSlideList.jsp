<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript">

	$(document).ready(function() {
		
		initDatepicker("#search_datestart");
		initDatepicker("#search_dateend");

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
		
		$("#formMainSlide").attr("action", "/admin/popban/mainslide_list.do");
		$("#formMainSlide").submit();
	}

	function goDetail(popban_sn) {
		$("#popban_sn").val(popban_sn);
		$("#formMainSlide").attr("action", "/admin/popban/mainslide_info.do");
		$("#formMainSlide").submit();
	}
	
	function goRegist() {
		window.location.href = '/admin/popban/mainslide_regist.do';
    }
	
	function deleteSlide(popban_sn){
		if(confirm("슬라이드를 삭제하시겠습니까?")){
			$("#popban_sn").val(popban_sn);
			$("#formMainSlide").attr("action","/admin/popban/mainslide_delete.do");
			$("#formMainSlide").submit();
		}
	}
	
</script>
<h2 class="subtitle">메인 슬라이드 관리</h2>
<form id="formMainSlide" name="formMainSlide" method="post">
<input type="hidden" name="popban_sn" id="popban_sn" />
<div class="search-box">
      <div class="search-box1">
      <label for="search_site_sn">검색 유형</label>
		 <select name="search_site_sn" id="search_site_sn" class="select01">
 			<option selected value=''>사이트 분류</option>
 			<option value="${mainSlideDto.search_site_sn }" >2009</option>
			<option value="${mainSlideDto.search_site_sn }" >2010</option>
		</select>
		<select name="search_use_yn" id="search_use_yn" class="select01">
 			<option selected value=''>사용여부</option>
 			<option value='N' ${mainSlideDto.use_yn eq 'N' ? 'selected="selected"' : '' }>사용</option>
	  		<option value='Y' ${mainSlideDto.use_yn eq 'Y' ? 'selected="selected"' : '' }>미사용</option>
		</select>
		</div>
		<div class="search-box2">
		<label for="search_datestart">등록일</label>
		<input type="text" id="search_datestart" name="search_datestart" value="${mainSlideDto.search_datestart }" style="width:80px; margin: 0 10px;" class="input01">
		<span>~</span>
		<input type="text" id="search_dateend" name="search_dateend" value="${mainSlideDto.search_dateend }" style="width:80px; margin: 0 10px;" class="input01">
		<input type="text" name="search_word" id="search_word" value="${mainSlideDto.search_word}" placeholder="제목을 입력하세요." style="width:250px;" class="input01"/>
		<button class="btn01 input_btn01" type="button" onclick="search2()">조회</button>
		</div>
</div>
<p class="total_title">Total: <span class="color">${mainSlideCount}</span>건</p>
<div class="bdtable">
		<table>
			<thead>
				<th>순번</th>
				<th>사이트</th>
				<th>제목</th>
				<th>사용여부</th>
				<th>순서</th>
				<th>게시 기간</th>
				<th>등록일자</th>
				<th>삭제</th>
			</thead>
			<tbody>
			<c:choose>
            <c:when test="${!empty mainSlides}">
                <c:forEach var="slide" items="${mainSlides}" varStatus="status">
                    <tr style="text-align: center;">
                        <td>${status.index + 1}</td>
                        <td>${slide.site_sn}</td>
                        <td><a onclick="goDetail('${slide.popban_sn}')">${slide.popban_nm}</a></td>
                        <td>${slide.use_yn == 'Y' ? '사용' : '미사용'}</td>
                        <td>${slide.popban_order}</td>
                        <td>${slide.popban_start_dt} ~ ${slide.popban_end_dt}</td>
                        <td>${slide.reg_dt}</td>
                        <td><button class="del_btn01" type="button" onclick="deleteSlide('${slide.popban_sn}')">삭제</button></td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="8" style="text-align: center;">등록된 슬라이드가 없습니다.</td>
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
