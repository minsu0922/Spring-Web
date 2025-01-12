<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript">

	
	function updateInfo(){
		if(confirm("해당정보로 수정하시겠습니까?")){
			$("#formBanner").attr("action","/admin/popban/banner_update.do");
			$("#formBanner").submit();
		}
	}

	function deleteInfo(){
		if(confirm("배너를 삭제하시겠습니까?")){
			$("#formBanner").attr("action","/admin/popban/banner_delete.do");
			$("#formBanner").submit();
		}
	}

	function bannerList(){
		var url = "/admin/popban/banner_list.do";
		window.location.href = url; 
	}
	

</script>
</head>
<body>
<div style="background-color: white;">
	<c:choose>
		<c:when test="${! empty bannerInfo }">
		<form id="formBanner" name="formBanner" method="post">
		<input type="hidden" id="popban_sn" name="popban_sn" value="${bannerInfo.popban_sn }">
		<table border="1">
			<tr>
			    <th style="width : 150px;">제목</th>
			    <td style="width : 150px;">
			        <input type="text" id="popban_nm" name="popban_nm" value="${bannerInfo.popban_nm}">
			    </td>
			</tr>
			<tr>
			    <th style="width : 150px;">사용여부</th>
			    <td style="width : 150px;">
			        <select id="use_yn" name="use_yn" style="width: 100px;">
			            <option value="Y" ${bannerInfo.use_yn == 'Y' ? 'selected' : ''}>사용</option>
			            <option value="N" ${bannerInfo.use_yn == 'N' ? 'selected' : ''}>미사용</option>
			        </select>
			    </td>
			    <th style="width : 150px;">사이트 분류</th>
			    <td style="width : 150px;">
			        <select id="site_sn" name="site_sn" style="width: 100px;">
			            <option value="2001" ${bannerInfo.site_sn == '2001' ? 'selected' : ''}>사이트1</option>
			            <option value="2002" ${bannerInfo.site_sn == '2002' ? 'selected' : ''}>사이트2</option>
			            <option value="2003" ${bannerInfo.site_sn == '2003' ? 'selected' : ''}>사이트3</option>
			            <!-- 필요한 사이트 분류를 추가하세요 -->
			        </select>
			    </td>
			</tr>
			<tr>
			    <th style="width : 150px;">
			        링크 구분
			    </th>
			    <td style="width : 150px;">
			    </td>
			    <th style="width : 150px;">
			        링크 주소
			    </th>
			    <td style="width : 150px;">
			    </td>
			</tr>
			
			<tr>
			    <th style="width : 150px;">
			        배너이미지(PC)<br>이미지 크기 : 1920*840
			    </th>
			    <td style="width : 150px;">
			    </td>
			</tr>
			<tr>
			    <th style="width : 150px;">
			        배너이미지(모바일)<br>이미지 크기 : 1920*840
			    </th>
			    <td style="width : 150px;">
			    </td>
			</tr>
			<tr>
			    <th style="width : 150px;">
			        배너텍스트(PC)
			    </th>
			    <td style="width : 150px;">
			    </td>
			    <th style="width : 150px;">
			        배너텍스트(모바일)
			    </th>
			    <td style="width : 150px;">
			    </td>
			</tr>
			<tr>
			    <th style="width : 150px;">
			        배너위치(PC)
			    </th>
			    <td style="width : 150px;">
			    </td>
			    <th style="width : 150px;">
			        배너위치(모바일)
			    </th>
			    <td style="width : 150px;">
			    </td>
			</tr>
			

			<tr>
				<th style="width : 150px;">게시일시</th>
				<td style="width : 150px;">${bannerInfo.reg_dt}</td>
			<tr>
				<th style="width : 150px;">
				등록자 아이디<br>
				/ 등록일</th>
				<td style="width : 150px;">${bannerInfo.rgtr_id} / ${bannerInfo.reg_dt}</td>
				<th style="width : 150px;">
				수정자 아이디<br>
				/ 수정일</th>
				<td style="width : 150px;">${bannerInfo.mdfr_id} / ${bannerInfo.mdfcn_dt}</td>
			</tr>
			
		</table>
		</form>
			<button onclick="updateInfo()">저장</button>
			<button onclick="deleteInfo()">삭제</button>
			<button onclick="bannerList()">목록</button>
		</c:when>
		</c:choose>
    </div>
</body>
</html>