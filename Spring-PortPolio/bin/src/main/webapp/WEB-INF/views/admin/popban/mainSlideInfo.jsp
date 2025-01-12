<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/common/common.js"></script>
<script type="text/javascript">

	
	function updateInfo(){
		if(confirm("해당정보로 수정하시겠습니까?")){
			$("#formMainSlide").attr("action","/admin/popban/mainslide_update.do");
			$("#formMainSlide").submit();
		}
	}

	function deleteInfo(){
		if(confirm("슬라이드를 삭제하시겠습니까?")){
			$("#formMainSlide").attr("action","/admin/popban/mainslide_delete.do");
			$("#formMainSlide").submit();
		}
	}

	function mainSlideList(){
		var url = "/admin/popban/mainslide_list.do";
		window.location.href = url; 
	}
	

</script>
</head>
<body>
<div class="bdtable2">
	<c:choose>
		<c:when test="${! empty mainSlideInfo }">
		<form id="formMainSlide" name="formMainSlide" method="post">
		<input type="hidden" id="popban_sn" class="input01" name="popban_sn" value="${mainSlideInfo.popban_sn }">
		<table border="1">
			<tr>
			    <th>제목</th>
			    <td colspan="3" style="text-align: left;">
			        <input type="text" id="popban_nm" class="input01" style="width: 80%;" name="popban_nm" value="${mainSlideInfo.popban_nm}">
			    </td>
			</tr>
			<tr>
			    <th>사용여부</th>
			    <td style="text-align: left;">
			        <select id="use_yn" name="use_yn" class="select01">
			            <option value="Y" ${mainSlideInfo.use_yn == 'Y' ? 'selected' : ''}>사용</option>
			            <option value="N" ${mainSlideInfo.use_yn == 'N' ? 'selected' : ''}>미사용</option>
			        </select>
			    </td>
			    <th>사이트 분류</th>
			    <td style="text-align: left;">
			        <select id="site_sn" name="site_sn" class="select01">
			            <option value="2001" ${mainSlideInfo.site_sn == '2001' ? 'selected' : ''}>사이트1</option>
			            <option value="2002" ${mainSlideInfo.site_sn == '2002' ? 'selected' : ''}>사이트2</option>
			            <option value="2003" ${mainSlideInfo.site_sn == '2003' ? 'selected' : ''}>사이트3</option>
			        </select>
			    </td>
			</tr>
			<tr>
			    <th>
			        메인이미지(PC)<br>이미지 크기 : 1920*840
			    </th>
			    <td colspan="3">
				    <c:choose>
					<c:when test="${! empty atchFileList }">
						<c:forEach var="test2" items="${atchFileList }" varStatus="status">
							<div class="download-box">
								<input type="checkbox" name="selectedFiles" value="${test2.atch_sn }">
								<span>${test2.file_path }${test2.atch_nm }</span>
								<button type="button" class="btn01" onclick="goDownload(${test2.atch_sn })">다운로드</button>
							</div>
						</c:forEach>
					</c:when>
					</c:choose>
			    </td>
			</tr>
			<tr>
			    <th>
			        메인이미지(모바일)<br>이미지 크기 : 1920*840
			    </th>
			    <td colspan="3">
			    <c:choose>
				<c:when test="${! empty atchFileList }">
					<c:forEach var="test2" items="${atchFileList }" varStatus="status">
						<div class="download-box">
							<span>${test2.file_path }${test2.atch_nm }</span>
							<button type="button" class="btn01" onclick="goDownload(${test2.atch_sn })">다운로드</button>
						</div>
					</c:forEach>
				</c:when>
				</c:choose>
			    </td>
			</tr>
			<tr>
			    <th>
			        메인이미지<br>설명
			    </th>
			    <td colspan="3" style="text-align:left">
			        <input type="text" id="popban_desc" class="input01" name="popban_desc" value="${mainSlideInfo.popban_desc}">
			    </td>
			</tr>
			<tr>
			    <th>
			        메인이미지<br>대체텍스트(PC)
			    </th>
			    <td style="text-align:left">
			    	<input type="text" id="popban_alt_pc" class="input01" style="width:100%:" name="popban_alt_pc" value="${mainSlideInfo.popban_alt_pc}">
			    </td>
			    <th style="width : 150px;">
			        메인이미지<br>대체텍스트(모바일)
			    </th>
			    <td style="text-align:left">
			    	<input type="text" id="popban_alt_mobile" class="input01" style="width:100%:" name="popban_alt_mobile" value="${mainSlideInfo.popban_alt_mobile}">
			    </td>
			</tr>
			<tr>
			    <th>순서</th>
			    <td style="text-align:left">
			        <input type="number" id="popban_order" class="input01"  style="width:100%:" name="popban_order" value="${mainSlideInfo.popban_order}" min="1" max="100">
			    </td>
			    <th>게시일시</th>
				<td colspan="3">
				<input type="text" id="popban_start_dt" class="input01" name="popban_start_dt" value="${mainSlideInfo.popban_start_dt}" style="width:100px" >
				<span>~</span>
				<input type="text" id="popban_end_dt" class="input01" name="popban_end_dt" value="${mainSlideInfo.popban_end_dt}" style="width:100px" >
				</td>
			</tr>
			<tr>
				<th>등록자 아이디/ 등록일</th>
				<td ><p>${mainSlideInfo.rgtr_id} / ${mainSlideInfo.reg_dt}</p></td>
				<th>수정자 아이디/ 수정일</th>
				<td ><p>${mainSlideInfo.mdfr_id} / ${mainSlideInfo.mdfcn_dt}</p></td>
			</tr>
		</table>
		</form>
			<div class="mrtp">
			<button type="button" class="btn04 input_btn01" onclick="mainSlideList()">목록</button>
			<button type="button" class="btn03 input_btn01" style="margin:0 10px;"onclick="updateInfo()">저장</button>
			<button type="button" class="del_btn01 input_btn01" style="min-width: 100px; border-radius:0;" onclick="deleteInfo()">삭제</button>
			</div>
		</c:when>
		</c:choose>
    </div>
</body>
</html>