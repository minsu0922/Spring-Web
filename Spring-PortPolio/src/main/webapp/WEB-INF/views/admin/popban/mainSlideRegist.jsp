<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript">
	
	$(document).ready(function() {
		
		initDatepicker("#popban_start_dt");
		initDatepicker("#popban_end_dt");
	});
	
	function registInfo() {
	    // 확인 창에서 취소 버튼을 눌렀다면 함수 종료
	    if (!confirm("등록하시겠습니까?")) {
	        return false;
	    }

	    // 파일 체크
	    /* var filePc = document.getElementById("file_pc");
	    var fileMobile = document.getElementById("file_mobile");
	    var filesPc = filePc.files;
	    var filesMobile = fileMobile.files;
	    
	    if (filesPc.length == 0 && filesMobile.length == 0) {
	        alert("메인 이미지를 등록해 주세요.");
	        return false;
	    } */

	    // 입력값 가져오기
	    const popbanNm = document.getElementById("popban_nm").value;
	    const useYn = document.getElementById("use_yn").value;
	    const siteSn = document.getElementById("site_sn").value;
	    const popbanDesc = document.getElementById("popban_desc").value;
	    const popbanDescPc = document.getElementById("popban_alt_pc").value;
	    const popbanDescMobile = document.getElementById("popban_alt_mobile").value;
	    const popbanOrder = document.getElementById("popban_order").value;
	    const popbanStartDt = document.getElementById("popban_start_dt").value;
	    const popbanEndDt = document.getElementById("popban_end_dt").value;

	    // 입력값 유효성 검사
	    if (!popbanNm) return alert("제목을 입력해 주세요.");
	    if (!useYn) return alert("사용 여부를 선택해 주세요.");
	    if (!siteSn) return alert("사이트 분류를 선택해 주세요.");
	    if (!popbanDesc) return alert("메인이미지 설명을 입력해 주세요.");
	    if (!popbanDescPc) return alert("메인이미지 대체텍스트(PC)를 입력해 주세요.");
	    if (!popbanDescMobile) return alert("메인이미지 대체텍스트(모바일)를 입력해 주세요.");
	    if (!popbanOrder) return alert("순서를 입력해 주세요.");
	    if (!popbanStartDt) return alert("게시일시(시작일)를 입력해 주세요.");
	    if (!popbanEndDt) return alert("게시일시(종료일)를 입력해 주세요.");

	    // 폼 제출
	    $("#formMainSlide").attr("action", "/admin/popban/mainslide_registproc.do");

	     $.ajax({
	         url: $("#formMainSlide").attr("action"),
	         method: "POST",
	         data: new FormData(document.getElementById("formMainSlide")),
	         contentType: false,
	         processData: false,
	         success: function(response) {
	             alert("등록이 완료되었습니다.");
	         },
	         error: function() {
	             alert("등록에 실패했습니다.");
	         }
	     });

	    // 일반적인 폼 제출
	    /* $("#formMainSlide").submit(); */
	}




	
	function mainSlideList(){
		var url = "/admin/popban/mainslide_list.do";
		window.location.href = url; 
	}
	

</script>
</head>
<body>
<div style="background-color: white;">
		<form id="formMainSlide" name="formMainSlide" method="post" enctype="multipart/form-data">
		<input type="hidden" id="popban_sn" name="popban_sn" value="">

		<script>
		    const randomValue = Math.floor(Math.random() * 1000000) + 1;  // 예: 1에서 1,000,000 사이의 난수
		    document.getElementById("popban_sn").value = randomValue;
		</script>
				
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
			        </select>
			    </td>
			</tr>
			<tr>
			    <th style="width : 150px;">4
			        메인이미지(PC)<br>이미지 크기 : 1920*840
			    </th>
			    <td style="width : 150px;">
					<input type="file" name="file_pc" id="file_pc" multiple/> 
					
			    </td>
			</tr>
			<tr>
			    <th style="width : 150px;">
			        메인이미지(모바일)<br>이미지 크기 : 1920*840
			    </th>
			    <td style="width : 150px;">
					<input type="file" name="file_mobile" id="file_mobile" multiple/>
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
			<button onclick="mainSlideList()">목록</button>
    </div>
</body>
</html>