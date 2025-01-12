<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>회원가입</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script type="text/javascript">
	
  $(document).ready(function() {
	    
	});
  var previousComCdSn = null;
  function godetail(com_cd_sn, cdCheck){
	  
	  var detailTable2 = document.getElementById('insertDetail');
	  var cdTable = document.getElementById('insertCd');
	  var cdTable2 = document.getElementById('updateDetail');
	  var cdTable3 = document.getElementById('updateCd');
	  detailTable2.style.display = 'none';  // 상세코드 추가테이블 숨기기
	  cdTable.style.display = 'none';  // 코드 추가테이블 숨기기
	  cdTable2.style.display = 'none';  // 상세코드 수정테이블 숨기기
	  cdTable3.style.display = 'none';  // 코드 수정테이블 숨기기
	  
	  $("#insertDetail input[type='text']").val(''); 
      $("#insertDetail input[name='use_yn3']").prop('checked', false);
	  $("#insertCd input[type='text']").val(''); 
      $("#insertCd input[name='use_yn2']").prop('checked', false);
	  $("#updateDetail input[type='text'], #updateDetail input[type='hidden']").val(''); 
      $("#updateDetail input[name='use_yn4']").prop('checked', false);
	  
	  if (previousComCdSn === com_cd_sn) {
	        var detailTable = document.getElementById('detail');
	        
	        detailTable.style.display = 'none';  // 테이블 숨기기
	        
	        previousComCdSn = null;  // 상태 초기화
	        return;
	    }
	 
	  $.ajax({
	        url: '/admin/system/com_cd_dtl.do', 
	        type: 'GET',
	        data: { com_cd_sn: com_cd_sn },
	        dataType: 'json',
	        success: function(response) {
	        	
	        	$('#addCd').empty();
	        	
	            console.log(response);
	            $("#cdCheck").text(cdCheck + " 상세코드 목록");
	            
	            let insertButton = $("<button></button>")
	            .text("상세코드 추가")  // 버튼에 표시할 텍스트
	            .on('click', function() { insertDetail(com_cd_sn); });
	            
	            /* let deleteButton = $("<button></button>")
	            .text("삭제")  // 버튼에 표시할 텍스트
	            .on('click', function() { deleteCd(com_cd_sn, cdCheck); }); */ 
	            
	            $("#addCd").append(insertButton) //.append(deleteButton);
	            
	            if (response.length > 0) {
	            	
	            	var detailTable = document.getElementById('detail');
	                detailTable.style.display = 'table';  // 테이블 보이기

	                // 기존 테이블 내용 제거
	                $('#detail tbody').empty();

	                // 각 항목에 대해 테이블에 추가 
	                $.each(response, function(i, detailData) {
	                    let tr = $("<tr></tr>");  // 새로운 행 생성
	                    $("<td></td>").html(detailData.dtl_cd).appendTo(tr);   // dtl_cd 표시
	                    
	                    let link = $("<a></a>")
                        .text(detailData.dtl_cd_nm)  // 링크 텍스트
                        .attr("data-com-cd-dtl-sn", detailData.com_cd_dtl_sn)  // 데이터 속성 추가
                        .on('click', function(event) { 
                            event.preventDefault();
                            godetail2(detailData.com_cd_dtl_sn, detailData.dtl_cd, detailData.dtl_cd_nm, detailData.use_yn); 
                        });

                    let td = $("<td></td>").append(link); // td에 링크 추가
                    tr.append(td); // td를 행에 추가
                    
                    $("<td></td>").html(detailData.use_yn).appendTo(tr);   // dtl_cd 표시
                    $("#detail tbody").append(tr);  // 테이블에 행 추가
	                });
	                previousComCdSn = com_cd_sn;
	            } else {
	                var detailTable = document.getElementById('detail');
	                detailTable.style.display = 'table'; 

	                $('#detail tbody').empty();

	                let noDataRow = $("<tr></tr>");
	                $("<td></td>").attr("colspan", "3").html("상세 코드가 없습니다.").appendTo(noDataRow);  
	                $('#detail tbody').append(noDataRow);
	                previousComCdSn = com_cd_sn;  
	            }
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	            console.error("Error: " + textStatus + ", Details: " + errorThrown);
	            alert('데이터를 불러오는 중 오류가 발생했습니다. 오류 내용: ' + errorThrown);
	        }
	    });
  }
  
  var previousComCdDtlSn = null;
  function godetail2(com_cd_dtl_sn, dtl_cd, dtl_cd_nm, use_yn){

      var cdTable = document.getElementById('updateDetail');
      //동일 코드 클릭시 숨김
      if (previousComCdDtlSn == com_cd_dtl_sn) {
          cdTable.style.display = 'none';
          $("#updateDetail input[type='text'], #updateDetail input[type='hidden']").val(''); 
          $("#updateDetail input[name='use_yn4']").prop('checked', false);
          previousComCdDtlSn = null;
          return;
      }
      //다른 코드 클릭시 이전 코드 숨김 후 표시
      if (previousComCdDtlSn != null) {
       	  cdTable.style.display = 'none';
       	  $("#updateDetail input[type='text'], #updateDetail input[type='hidden']").val(''); 
          $("#updateDetail input[name='use_yn4']").prop('checked', false);
      }
      previousComCdDtlSn = com_cd_dtl_sn;
      cdTable.style.display = 'table';
	  $("#updateDetail input[name='com_cd_dtl_sn']").val(com_cd_dtl_sn);
	  $("#updateDetail ")
	  $("#updateDetail input[name='dtl_cd']").val(dtl_cd);
	  $("#updateDetail input[name='dtl_cd_nm']").val(dtl_cd_nm);
	  $("#updateDetail input[name='use_yn4'][value='" + use_yn + "']").prop("checked", true);
  }

  function fileUpload(){
	  event.preventDefault();
	  var file = document.getElementById("file");
	  var files = file.files;
	  var filecount = files.length;
	  
	  if(filecount == 0){
		  alert("선택된 파일이 없습니다");
		  return false;
	  }
	  
	  if(confirm(filecount + "개의 파일을 업로드 하시겠습니까?")){
		  $("#uploadForm").attr("action", "/common/file_upload.do");
		  $("#uploadForm").submit();
	  }else{
		  return false;
	  }
  }
  
  function goDownload(atch_id){
	  event.preventDefault();
	  if(confirm("다운로드 하시겠습니까?")){
		$("#atch_id").val(atch_id);
		$("#downloadForm").attr("action", "/common/file_download.do");
		$("#downloadForm").submit();
	  }else{
		  return;
	  }
  }
  
  function selectAll(selectAllCheckbox) {
      var checkboxes = document.getElementsByName('selectedFiles');
      for (var checkbox of checkboxes) {
          checkbox.checked = selectAllCheckbox.checked;
      }
  }
  
  function goDelete(){
	  var checkedBoxes = document.querySelectorAll('input[name="selectedFiles"]:checked');
	    if (checkedBoxes.length === 0) {
	        alert("삭제할 파일을 선택하세요.");
	        return;
	    }

	    var selectedId = []; 
	    checkedBoxes.forEach(function(checkbox) {
	        selectedId.push(checkbox.value); 
	    });
	    if (confirm("선택한 파일을 삭제하시겠습니까?")) {
	        var deleteUrl = "/common/file_delete.do?atch_id=" + selectedId;
	        window.location.href = deleteUrl; 
	    }
  }
  
  function insertCd(){
	  event.preventDefault();
	  if(confirm("등록하시겠습니까?")){
		  
		  var useYn = document.querySelector('input[name="use_yn2"]:checked');
		    if (useYn) {
			  $("#use_yn").val(useYn.value);
		    } else {
		        alert("사용 여부를 선택해 주세요.");
		        return;
		    }
		  
		  $("#formCd").attr("action", "/admin/system/com_cd_insert.do");
		  $("#formCd").submit();
	  }else{
		  return;
	  }
  }
  
  function checkEng(input) {
	  input.value = input.value.replace(/[^A-Za-z]/g, '');
	}
  
  function cdTable(){
	  var cdTable = document.getElementById('insertCd');
      if(cdTable.style.display == 'table'){
    	  cdTable.style.display = 'none';
      }else{
    	  cdTable.style.display = 'table';
      }
  }
  
  function insertDetail(com_cd_sn){
	  var cdTable = document.getElementById('insertDetail');
      if(cdTable.style.display == 'table'){
    	  cdTable.style.display = 'none';
      }else{
    	  cdTable.style.display = 'table';
      }
      $("#goDetail input[name='com_cd_sn']").val(com_cd_sn);
  }
  function goInsertDetail(){
	  event.preventDefault();
	  if(confirm("등록하시겠습니까?")){
		  
		  var useYn = document.querySelector('input[name="use_yn3"]:checked');
		    if (useYn) {
		    	$("#goDetail input[name='use_yn']").val(useYn.value);
		    } else {
		        alert("사용 여부를 선택해 주세요.");
		        return;
		    }
		  $("#goDetail").attr("action", "/admin/system/com_cd_dtl_insert.do");
		  $("#goDetail").submit();
	  }else{
		  return;
	  }
  }
  var previousComCdSn = null;
  function godetail3(com_cd_sn, cd, cd_nm, cd_description, use_yn){
	  var cdTable = document.getElementById('updateCd');
      //동일 코드 클릭시 숨김
      if (previousComCdSn == com_cd_sn) {
          cdTable.style.display = 'none';
          $("#updateCd input[type='text'], #updateCd input[type='hidden']").val(''); 
          $("#updateCd input[name='use_yn4']").prop('checked', false);
          previousComCdSn = null;
          return;
      }
      //다른 코드 클릭시 이전 코드 숨김 후 표시
      if (previousComCdSn != null) {
       	  cdTable.style.display = 'none';
       	  $("#updateCd input[type='text'], #updateCd input[type='hidden']").val(''); 
          $("#updateCd input[name='use_yn5']").prop('checked', false);
      }
      previousComCdSn = com_cd_sn;
      cdTable.style.display = 'table';
	  $("#updateCd input[name='com_cd_sn']").val(com_cd_sn);
	  $("#updateCd input[name='cd']").val(cd);
	  $("#updateCd input[name='cd_nm']").val(cd_nm);
	  $("#updateCd input[name='cd_description']").val(cd_description);
	  $("#updateCd input[name='use_yn5'][value='" + use_yn + "']").prop("checked", true);
	  
	  $('#addbutton').empty();
	  
	  let insertButton = $("<button></button>")
      .text("수정")  
      .on('click', function() { goUpdateCd(com_cd_sn); });  // com_cd_sn 값을 전달
      
      let deleteButton = $("<button></button>")
      .text("삭제")  
      .on('click', function() { goDeleteCd(com_cd_sn, cd); });  // com_cd_sn 값을 전달
      
      $("#addbutton").append(insertButton).append(deleteButton);
	  
  }
  
  function goUpdateCd(com_cd_sn){
	  event.preventDefault();
	  if(confirm("수정하시겠습니까?")){
		  
	  var useYn = document.querySelector('input[name="use_yn5"]:checked');
	    if (useYn) {
	    	$("#updateForm input[name='use_yn']").val(useYn.value);
	    } else {
	        alert("사용 여부를 선택해 주세요.");
	        return false;
	    }
	    
		$("#updateForm").attr("action", "/admin/system/com_cd_update.do");
		$("#updateForm").submit();
	  }else{
		  return false;
	  }
  }
  
  function goDeleteCd(com_cd_sn, cd){
	  event.preventDefault();
	  if(confirm(cd+" 코드를 삭제하시겠습니까? 상세코드도 삭제됩니다")){
		  var deleteUrl = "/admin/system/com_cd_delete.do?com_cd_sn=" + com_cd_sn;
	      window.location.href = deleteUrl; 
	  }else{
		  return false;
	  }
  }
  
  function goUpdateDetail(){
	  event.preventDefault();
	  if(confirm("상세코드를 수정하시겠습니까?")){
		  
		  var useYn = document.querySelector('input[name="use_yn4"]:checked');
		    if (useYn) {
		    	$("#goUpdate input[name='useYn']").val(useYn.value);
		    } else {
		        alert("사용 여부를 선택해 주세요.");
		        return false;
		    }
		  
		  $("#goUpdate").attr("action", "/admin/system/com_cd_dtl_update.do");
		  $("#goUpdate").submit();
	  }else{
		  return false;
	  }
  }
  
  function goDeleteDetail(){
	  event.preventDefault();
	  if(confirm("상세코드를 삭제하시겠습니까?")){
		  var com_cd_dtl_sn = $("#com_cd_dtl_sn").val();
		  var deleteUrl = "/admin/system/com_cd_dtl_delete.do?com_cd_dtl_sn=" + com_cd_dtl_sn;
	      window.location.href = deleteUrl; 
	  }else{
		  return false;
	  }
  }
  
  </script>
</head>
<body>
<form id="downloadForm" method="post">
<input type="hidden" id="atch_id" name="atch_id"/>
</form>
<!-- <div>
    <h1>파일 업로드</h1>
</div>
    <form id="uploadForm" method="post" enctype="multipart/form-data">
        <input type="file" name="file" id="file" multiple/>
        <button onclick="fileUpload()" id="uploadButton">업로드</button>
    </form> -->
<br> 
    <div style="height: 350px; width: 500px; overflow: scroll; background-color: white;">
		<table>
			<tr>
				<th>코드</th>
				<th>코드명</th>
				<th>설명</th>
				<th>사용유무</th>
			</tr>
			<c:choose>
				<c:when test="${! empty comCdList }">
					<c:forEach var="comCdList" items="${comCdList }" varStatus="status">
						<tr>
							<td><a onclick="godetail('${comCdList.com_cd_sn }', '${comCdList.cd }')">${comCdList.cd }</a></td>
							<td><a onclick="godetail3('${comCdList.com_cd_sn}', '${comCdList.cd}','${comCdList.cd_nm}','${comCdList.cd_description}','${comCdList.use_yn}')">${comCdList.cd_nm }</a></td>
							<td>${comCdList.cd_description }</td>
							<td>${comCdList.use_yn }</td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>
		<button onclick="cdTable()">등록</button>
    </div>
    <%-- <div class="panel-body"  style="height: 350px; width: 500px; overflow: scroll; background-color: white;">
		<table>
			<tr>
				<th><input type="checkbox" id="selectAll" onclick="selectAll(this)"></th>
				<th>경로</th>
				<th>파일명</th>
			</tr>
			<c:choose>
				<c:when test="${! empty atchFileList }">
					<c:forEach var="resultList" items="${atchFileList }" varStatus="status">
						<tr>
							<td><input type="checkbox" name="selectedFiles" value="${resultList.atch_id }"></td>
							<td>${resultList.file_path }</td>
							<td><a onclick="goDownload(${resultList.atch_id })">${resultList.atch_nm }</a></td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>
		<button type="button" onclick="goDelete()">삭제</button>
    </div>  --%>
    <br>
    <form id="formCd" name="formCd" method="post">
    <table border="1" id="insertCd" style="display: none; width:500px" >
    	<tr>
    		<th colspan="4">코드등록</th>
    	</tr>
        <tr>
        	<th>코드</th>
            <th><input type="text" maxlength="6" name="cd" id="cd" oninput="checkEng(this)"/></th>
            <th>코드명</th>
            <th><input type="text" maxlength="6" name="cd_nm" id="cd_nm"/></th>
        </tr>
        <tr>
			<th>설명</th>
            <th><input type="text" maxlength="10" name="cd_description" id="cd_description"/></th>            
            <th>사용여부</th>
            <th>
            	<input type="radio" name="use_yn2" id="use_yn2" value="Y">사용
            	<input type="radio" name="use_yn2" id="use_yn2" value="N">미사용
            	<input type="hidden" name="use_yn" id="use_yn">
            </th>
        </tr>
        <tr>
        	<td colspan="2"></td>
			<td colspan="2">
				<button onclick="insertCd()">등록</button>
			</td>        
        </tr>
    </table>
    </form>
    <br>
    
    <form id="updateForm" method="post">
    <table border="1" id="updateCd" style="display: none; width:500px">
		<tr>
			<th colspan="4">
				코드수정
			</th>
		</tr>
		<tr>
			<th>코드</th>
			<th>
				<input type="text" name="cd" id="cd">
				<input type="hidden" name="com_cd_sn" id="com_cd_sn">
			</th>
			<th>코드명</th>
			<th><input type="text" name="cd_nm" id="cd_nm"></th>
		</tr>
		<tr>
			<th>설명</th>
			<th><input type="text" name="cd_description" id="cd_description"></th>
			<th>사용유무</th>
			<th>
				<input type="radio" name="use_yn5" id="use_yn5" value="Y">사용
            	<input type="radio" name="use_yn5" id="use_yn5" value="N">미사용
            	<input type="hidden" name="use_yn" id="use_yn">
			</th>
		</tr>
		<tr>
			<td colspan="2"></td>
			<td colspan="2" id="addbutton">
			</td>
		</tr>
	</table>
    </form>
    
    <br>
	<table border="1" id="detail" style="display: none; width:500px">
		<thead>
			<tr>
				<th id="cdCheck" colspan="2"></th>
				<th id="addCd">
				</th>
			</tr>
			<tr>
				<th>상세코드</th>
				<th>상세코드명</th>
				<th>사용유무</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	
	<br>
	<form id="goDetail"	method="post">
	<table border="1" id="insertDetail" style="display: none; width:500px">
		<tr>
			<th colspan="4">
				상세코드 등록
			</th>
		</tr>
		<tr>
			<th>상세코드</th>
			<th>
				<input type="text" name="dtl_cd" id="dtl_cd">
				<input type="hidden" name="com_cd_sn" id="com_cd_sn">
			</th>
			<th>상세코드명</th>
			<th><input type="text" name="dtl_cd_nm" id="dtl_cd_nm"></th>
		</tr>
		<tr>
			<th>사용유무</th>
			<th>
				<input type="radio" name="use_yn3" id="use_yn3" value="Y">사용
            	<input type="radio" name="use_yn3" id="use_yn3" value="N">미사용
            	<input type="hidden" name="use_yn" id="use_yn">
			</th>
			<td colspan="2">
				<button onclick="goInsertDetail()">등록</button>
			</td>
		</tr>
	</table>
	</form>
	
	<form id="goUpdate">
	<table border="1" id="updateDetail" style="display: none; width:500px">
		<tr>
			<th colspan="4">
				상세코드 수정
			</th>
		</tr>
		<tr>
			<th>상세코드</th>
			<th>
				<input type="text" name="dtl_cd" id="dtl_cd">
				<input type="hidden" name="com_cd_dtl_sn" id="com_cd_dtl_sn">
			</th>
			<th>상세코드명</th>
			<th><input type="text" name="dtl_cd_nm" id="dtl_cd_nm"></th>
		</tr>
		<tr>
			<th>사용유무</th>
			<th>
				<input type="radio" name="use_yn4" id="use_yn4" value="Y">사용
            	<input type="radio" name="use_yn4" id="use_yn4" value="N">미사용
            	<input type="hidden" name="useYn" id="useYn">
			</th>
			<td colspan="2">
				<button onclick="goUpdateDetail()">수정</button>
				<button onclick="goDeleteDetail()">삭제</button>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>