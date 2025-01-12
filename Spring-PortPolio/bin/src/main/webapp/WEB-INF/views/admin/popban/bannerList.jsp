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
		
		$("#formBanner").attr("action", "/admin/popban/banner_list.do");
		$("#formBanner").submit();
	}

	function goDetail(popban_sn) {
		$("#popban_sn").val(popban_sn);
		$("#formBanner").attr("action", "/admin/popban/banner_info.do");
		$("#formBanner").submit();
	}
	
	function goRegist() {
		window.location.href = '/admin/popban/banner_regist.do';
    }
	
	function deleteBanner(popban_sn){
		if(confirm("배너를 삭제하시겠습니까?")){
			$("#popban_sn").val(popban_sn);
			$("#formBanner").attr("action","/admin/popban/banner_delete.do");
			$("#formBanner").submit();
		}
	}
	
</script>
<h2 class="subtitle">배너 관리</h2>
<form id="formBanner" name="formBanner" method="post">
<input type="hidden" name="popban_sn" id="popban_sn" />
<div class="search-box">
       <div class="search-box1">
       <label for="search_site_sn">검색 유형</label>
		<select name="search_site_sn" id="search_site_sn" class="select01">
 			<option selected value=''>사이트 분류</option>
 			<option value="" ></option>
			<option value="" ></option>
		</select>
		</div>
		<div class="search-box2">
		<span>등록일</span>
		<input type="text" id="search_datestart" name="search_datestart" value="${bannerDto.search_datestart }" style="width:80px; margin: 0 10px;" class="input01">
        <span>~</span>
		<input type="text" id="search_dateend" name="search_dateend" value="${bannerDto.search_dateend }" style="width:80px; margin: 0 10px;" class="input01">
		<input type="text" name="search_word" id="search_word" value="${bannerDto.search_word}" placeholder="제목을 입력하세요." style="width:250px;" class="input01"/>
		<button class="btn01 input_btn01" type="button" onclick="search2()">조회</button>
		</div>
</div>
<p class="total_title">Total: <span class="color">${bannerCount}</span>건</p>
<div class="bdtable">
		<table>
			<thead>
				<th>순번</th>
				<th>사이트</th>
				<th>제목</th>
				<th>게시 기간</th>
				<th>등록일자</th>
				<th>삭제</th>
			</thead>
			
			<tbody>
			<c:choose>
            <c:when test="${!empty banners}">
                <c:forEach var="banner" items="${banners}" varStatus="status">
                    <tr style="text-align: center;">
                        <td>${status.index + 1}</td>
                        <td>${banner.site_sn}</td>
                        <td><a onclick="goDetail('${banner.popban_sn}')">${banner.popban_nm}</a></td>
                        <td>${banner.popban_start_dt} ~ ${banner.popban_end_dt}</td>
                        <td>${banner.reg_dt}</td>
                        <td><button class="del_btn01" type="button" onclick="deleteBanner('${banner.popban_sn}')">삭제</button></td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="8" style="text-align: center;">등록된 배너가 없습니다.</td>
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
