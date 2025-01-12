<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/common/common.js"></script>
<script type="text/javascript">


	$(document).ready(function() {
		
		initDatepicker("#popban_start_dt");
		initDatepicker("#popban_end_dt");
	});

	function registInfo(){
		if(confirm("등록하시겠습니까?")){
			
			const popbanNm = document.getElementById("popban_nm").value;
		    const useYn = document.getElementById("use_yn").value;
		    const siteSn = document.getElementById("site_sn").value;
		    const popbanDesc = document.getElementById("popban_desc").value;
		    const popbanDescPc = document.getElementById("popban_alt_pc").value; // 대체텍스트(PC)
		    const popbanDescMobile = document.getElementById("popban_alt_mobile").value; // 대체텍스트(모바일)
		    const popbanOrder = document.getElementById("popban_order").value;
		    const popbanStartDt = document.getElementById("popban_start_dt").value;
		    const popbanEndDt = document.getElementById("popban_end_dt").value;

		    // 필요한 항목들에 대해 입력 체크
		    if (!popbanNm) {
		        alert("제목을 입력해 주세요.");
		        return;
		    }
		    if (!useYn) {
		        alert("사용여부를 선택해 주세요.");
		        return;
		    }
		    if (!siteSn) {
		        alert("사이트 분류를 선택해 주세요.");
		        return;
		    }
		    if (!popbanDesc) {
		        alert("메인이미지 설명을 입력해 주세요.");
		        return;
		    }
		    if (!popbanDescPc) {
		        alert("메인이미지 대체텍스트(PC)를 입력해 주세요.");
		        return;
		    }
		    if (!popbanDescMobile) {
		        alert("메인이미지 대체텍스트(모바일)를 입력해 주세요.");
		        return;
		    }
		    if (!popbanOrder) {
		        alert("순서를 입력해 주세요.");
		        return;
		    }
		    if (!popbanStartDt) {
		        alert("게시일시(시작일)를 입력해 주세요.");
		        return;
		    }
		    if (!popbanEndDt) {
		        alert("게시일시(종료일)를 입력해 주세요.");
		        return;
		    }
			
			$("#formPopup").attr("action","/admin/popban/popup_registproc.do");
			$("#formPopup").submit();
		}
	}

	function popupList(){
		var url = "/admin/popban/popup_list.do";
		window.location.href = url; 
	}
	

</script>
</head>
<body>
<div style="background-color: white;">
		<form id="formPopup" name="formPopup" method="post">
		<table border="1">
			<tr>
			    <th style="width : 150px;">제목</th>
			    <td style="width : 150px;">
			        <input type="text" id="popban_nm" name="popban_nm">
			    </td>
			</tr>
			<tr>
			    <th style="width : 150px;">사용여부</th>
			    <td style="width : 150px;">
			        <select id="use_yn" name="use_yn" style="width: 100px;">
			            <option value="Y">사용</option>
			            <option value="N">미사용</option>
			        </select>
			    </td>
			    <th style="width : 150px;">사이트 분류</th>
			    <td style="width : 150px;">
			        <select id="site_sn" name="site_sn" style="width: 100px;">
			            <option value="2001">사이트1</option>
			            <option value="2002">사이트2</option>
			            <option value="2003">사이트3</option>
			            <!-- 필요한 사이트 분류를 추가하세요 -->
			        </select>
			    </td>
			</tr>
			<tr>
			    <th style="width : 150px;">4
			        메인이미지(PC)<br>이미지 크기 : 1920*840
			    </th>
			    <td style="width : 150px;">
			    	<!--  <form id="uploadForm" method="post" enctype="multipart/form-data">
					       <input type="file" name="file" id="file" multiple/>
					       <button onclick="fileUpload()" id="uploadButton"></button>
					 </form> -->
					 <input type="hidden" id="atch_sn_pc" name="atch_sn_pc" value="">
					 
			    </td>
			</tr>
			<tr>
			    <th style="width : 150px;">
			        메인이미지(모바일)<br>이미지 크기 : 1920*840
			    </th>
			    <td style="width : 150px;">
			    	<!-- <form id="uploadForm" method="post" enctype="multipart/form-data">
					       <input type="file" name="file" id="file" multiple/>
					       <button onclick="fileUpload()" id="uploadButton"></button>
					 </form> -->
					 <input type="hidden" id="atch_sn_mobile" name="atch_sn_mobile" value="">
					 
			    </td>
			</tr>
			<tr>
			    <th style="width : 150px;">
			        메인이미지<br>설명
			    </th>
			    <td style="width : 150px;">
			        <input type="text" id="popban_desc" name="popban_desc">
			    </td>
			</tr>
			<tr>
			     <th style="width : 150px;">
			        메인이미지<br>대체텍스트(PC)
			    </th>
			    <td style="width : 150px;">
			    	<input type="text" id="popban_alt_pc" name="popban_alt_pc">
			    </td>
			    <th style="width : 150px;">
			        메인이미지<br>대체텍스트(모바일)
			    </th>
			    <td style="width : 150px;">
			    	<input type="text" id="popban_alt_mobile" name="popban_alt_mobile">
			    </td>
			</tr>
			<tr>
			    <th style="width : 150px;">순서</th>
			    <td style="width : 150px;">
			        <input type="number" id="popban_order" name="popban_order" min="1" max="100">
			    </td>
			</tr>

			<tr>
				<th style="width : 150px;">게시일시</th>
				<td style="width : 150px;">
				<input type="text" id="popban_start_dt" name="popban_start_dt" style="width:80px" >
				&nbsp;
				~ 
				&nbsp;
				<input type="text" id="popban_end_dt" name="popban_end_dt" style="width:80px" >
				</td>
			</tr>

			
		</table>
		</form>
			<button onclick="registInfo()">저장</button>
			<button onclick="popupList()">목록</button>
    </div>
</body>
</html>