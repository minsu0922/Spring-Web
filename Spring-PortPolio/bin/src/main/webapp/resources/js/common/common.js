$(document).ready(function(){
	
		// 모달 관련 변수 설정
        const modal = document.getElementById("myModal");
        const modalOverlay = document.getElementById("modalOverlay");
        const closeModal = document.getElementById("closeModal");
        const closeModalButton = document.getElementById("closeModalButton");
		const message = document.getElementById("modalMessage").textContent;
        // 메시지가 있을 경우 모달을 띄우는 로직
        if (message.length > 0) {
            modal.style.display = "block";
            modalOverlay.style.display = "block";
        }

        // 모달 닫기 버튼 클릭 시 모달 닫기
        closeModal.addEventListener("click", function() {
            modal.style.display = "none";
            modalOverlay.style.display = "none";
        });

        // 모달 안의 닫기 버튼 클릭 시 모달 닫기
        closeModalButton.addEventListener("click", function() {
            modal.style.display = "none";
            modalOverlay.style.display = "none";
        });

        // 오버레이 클릭 시 모달 닫기
        modalOverlay.addEventListener("click", function() {
            modal.style.display = "none";
            modalOverlay.style.display = "none";
        });

		paging(paging, "noticeList"); // 페이징
		
});	
//datepicker 설정
function initDatepicker(selector) {
	// 달력옵션
	var datepicker_option = {
			dateFormat:'yy-mm-dd',
			prevText: '이전 달',
			nextText: '다음 달',
			monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			dayNames: ['일', '월', '화', '수', '목', '금', '토'],
			dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			changeMonth: true,
			changeYear: true,
			showMonthAfterYear: true,
			yearRange: "-100:+0",
			maxDate:"0",
			//yearSuffix: '년',
			duration: "slow" ,
			showAnim: "fadeIn",
			currentText: '오늘 날짜',
		 	/* onSelect: function(dateText, inst) {
		 				// 시작일 input 요소를 선택한 경우
				 		if ($(inst.input).hasClass("start_date")) {
				 			$('#act_area .end_date').datepicker("option", "minDate", dateText);
			            // 종료일 input 요소를 선택한 경우	
				 		} else if ($(inst.input).hasClass("end_date")) {
				 			$('#act_area .start_date').datepicker("option", "maxDate", dateText);
				 		}
				} */
		};
	
    // 기본 옵션과 추가 옵션 병합 후 적용
    $(selector).datepicker(datepicker_option);
}

/*
 * 페이징
 * @param	paging : PageVO
 * @param	fnName : 페이징 호출이 필요한 함수명
 */
function paging(page, fnName) {
	let pageHtml = "";
	let firstPage = Number(page.firstPage);
	let lastPage = Number(page.lastPage);
	let nextPage = Number(lastPage + 1);
	let prevPage = Number(firstPage - 1);
	
	pageHtml += "<li class='first'><a href='javascript:"+fnName+"("+1+");'><img src='/resources/images/common/left02.png' alt='처음 페이지' /></a></li><li class='prev'><a href='javascript:"+fnName+"("+prevPage+");'><img src='/resources/images/common/left01.png' alt='이전 페이지' /></a></li>";

	for (var i=firstPage; i<=lastPage; i++) { // 페이지 번호
		if (page.currentPage == i) {
			pageHtml += "<li><a class='page-text active'>"+i+"</a></li>";
			
		} else {
			pageHtml += "<li><a class='page-text' href='javascript:"+fnName+"("+i+");'>"+i+"</a></li>";
	    }
	}

	pageHtml += "<li class='next'><a href='javascript:"+fnName+"("+nextPage+");'><img src='/resources/images/common/right01.png' alt='다음 페이지' /></a></li><li class='last'><a href='javascript:"+fnName+"("+page.pageTotCnt+");'><img src='/resources/images/common/right02.png' alt='마지막 페이지' /></a></li>"; // 마지막
	
	$("#paging ul").html(pageHtml);
}

	
//우편주소
function daumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("user_extra_addr").value = extraAddr;
                
                } else {
                    document.getElementById("user_extra_addr").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zip_code').value = data.zonecode;
                document.getElementById("user_addr").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("user_detail_addr").focus();
            }
        }).open();
    }

/*
 * modal 열기
 */
function openModal(modal) {
	// 모달 보이기
	modal = "#"+modal;
	$(modal).css("display", "block");
	$(modal).prev().css("display", "none");
	
	// 모달 뒷배경 생성
	$(".modal-background").fadeIn(500); 
	
	// 모달 닫기
	$("[class^='modal-close-btn']").on('click', function(){
		$(".modal-custom").hide();
		$(".modal-background").fadeOut(500);
	});
	$(".modal-background").on('click', function(){
		$(".modal-custom").hide();
		$(this).fadeOut(500);
	});
}

/*
 * popup 열기
 */
function openPopup1(target) {
	var width = 1000;
	var height = 500;
	var left = (window.screen.width / 2) - (width/2);
	var top = (window.screen.height / 4);
	var size = "width="+width+",height="+height+",left="+left+",top="+top;

	return window.open("", target, size);
}

function openPopup2(target, leftX, topY) {
	var width = 1000;
	var height = 500;
	var left = (window.screen.width / 2) - (width/2) + leftX;
	var top = (window.screen.height / 4) + topY;
	var size = "width="+width+",height="+height+",left="+left+",top="+top;

	return window.open("", target, size);
}

function openPopup3(target) {
	var width = 500;
	var height = 500;
	var left = (window.screen.width / 2) - (width/2);
	var top = (window.screen.height / 4);
	var size = "width="+width+",height="+height+",left="+left+",top="+top;

	return window.open("", target, size);
}

function openPopup4(target) {
	var width = 600;
	var height = 500;
	var left = (window.screen.width / 2) - (width/2) + 500;
	var top = (window.screen.height / 4) - 50;
	var size = "width="+width+",height="+height+",left="+left+",top="+top;

	return window.open("", target, size);
}

/*
 * popup 닫기
 */
function closePopup() {
	window.close();
}

/*
 * 전체 권한목록 호출
 */
function select_Menu_List() {
	$.ajax({
        type: "get",
        url: "/admin/menu/search_menu_list.do",
        dataType: "json",
        success:function(result) {
        	var list = result;
        	$("#searched_list").empty();

        	var html = "";

        	if ( list.length > 0 ) {
        		
	        	for ( var i = 0 ; i < list.length ; i++ ) {
	        		
	        		html += '<tr>';
					html += '		<input type="hidden" name="menuNm" value="' + list[i].menuNm + '" />';
					html += '		<input type="hidden" name="menuId" value="' + list[i].menuId + '" />';
					html += '	<td>' + list[i].menuNm + '</td>';
					html += '	<td>' + list[i].menuUrl + '</td>';
					html += '	<td>' + list[i].menuOrder + '</td>';
					html += '	<td>' + list[i].useYn + '</td>';
					html += '	<td>';
					html += '		<input type="radio" name="select" value="' + list[i].menuId + '" />';
					html += '	</td>';
					html += '</tr>';
	        	}
	        	
        	} else {
        		html = "<tr><td colspan='5'>검색 결과가 없습니다.</td></tr>";
        	}
			
       		$("#searched_list").html(html);
		},
		error:function(x,e){
			alert(x, e);
		}
	});
}


/* 
 * 필수 입력값 유효성 검사 (텍스트)
 * (class가 must로 설정된 입력값의 value.length가 0인 경우를 체크)
 * @return	boolean
 * */
function validation(form) {
	var isValid = true;
	var form = $(form);
	var user_id = form.find($("#user_id"));
	var user_password = form.find($("#user_password"));
	var user_password2 = form.find($("#user_password2"));
		//아이디 값 유효성 검사
	if(!checkId(user_id)){
		console.log("1");
		return false;
	}
	
	if(!checkPw(user_password, user_password2)){
		console.log("2");
		return false;
	}
	
	$('.must').each(function(index,item) {
		if (item.value.length == 0 || item.value.trim() == "") {
			var placeholder = $(item).attr("placeholder");
            alert(placeholder + '을(를) 입력하세요.');
			item.focus();
			isValid = false;
			return false;
		}
	})
	return isValid;
}

/* 
 * 필수 입력값 유효성 검사 (체크박스)
 * (class가 must로 설정된 checkbox가 하나라도 체크가 되어있는지 체크)
 * @return	boolean
 * */
function validation2() {
	var isValid = true;
	var checkboxArr = {};
	$(".must").each(function(index, item) { // checkbox의 name을 기준으로 배열 생성
		if (item.type == "checkbox") {
	        var checkbox = $(item).attr("name");
	        if (!checkboxArr[checkbox]) checkboxArr[checkbox] = [];
	        checkboxArr[checkbox].push($(item));
		}
	});
    for (var checkbox in checkboxArr) { // 각 checkbox 유효성 검사
    	var groupIsValid = false;
    	for (var i=0; i < checkboxArr[checkbox].length; i++) {
            if (checkboxArr[checkbox][i].is(":checked")) {
            	groupIsValid = true;
                break;
            }
        }
        if (!groupIsValid) isValid = false;
    }
    return isValid;
}

/*
 * 아이디 검증 (아이디)
 */
function checkId(user_id) {
		//아이디 필수값 체크
		var user = $(user_id);
		var obj = $(user_id).val().trim();
		if(obj.length == 0 || obj == ""){
			var placeholder = $(user_id).attr("placeholder");
            alert(placeholder + '을(를) 입력하세요.');
			user.focus();
			user.select();
			return false;
		} else if(obj.length < 4){
			var placeholder = $(user_id).attr("placeholder");
            alert(placeholder + '는 4자 이상 입력해야합니다.');
		    user.focus();
		    user.select();
		    return false;
		}
		
		check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		if(check.test(obj)){
			alert("아이디에는 한글을 사용할 수 없습니다.");
			user.select();
			return false;
		}
		
		var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	    if(regExp.test(obj)){
	        alert("아이디에는 특수문자를 사용할 수 없습니다.");
			user.select();
	        return false;
	    }
	
		if(obj.indexOf('admin') > -1){
			alert("admin이 포함된 아이디는 사용할 수 없습니다.");
			user.select();
			return false;
		}
		return true;
}

/*
 * 비밀번호 검증 (비밀번호)
 */
function checkPw(user_pw, user_pw2) {
		//비밀번호 필수값 체크
		var user_pw = $(user_pw);
		if(user_pw.val().trim() == ""){
			alert( user_pw.attr('placeholder') +    '을(를) 입력하세요.');
			user_pw.focus();
			user_pw.select();
			return false;
		} /*else if(user_pw.val().trim().length < 6){
			alert(user_pw.attr('placeholder') +    '는 6자리 이상 입력 해야합니다.');
		    user_pw.focus();
		    user_pw.select();
		    return false;
		}*/

		//비밀번호 일치여부 판단
		var user_pw2 = $(user_pw2);
		if(user_pw2.val().trim() == ""){
			alert( user_pw2.attr('placeholder') +    '을(를) 입력하세요.');
			user_pw2.focus();
			user_pw2.select();
			return false;
		}
		
		if(user_pw2.val().trim() != user_pw2.val().trim()){
			alert('비밀번호가 일치 하지 않습니다.');
			user_pw2.focus();
			return false;
		}
		return true;
}

//이메일 유효성 체크
function chkEmail(val){
	var email = val;
	var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	if(regex.test(email) === false) {
		alert("잘못된 이메일 형식입니다.");
		return false;
	} else {
		return true;
	}
}

/*
 * 숫자만 입력 가능 (전화번호)
 */
function checkTelno(obj) {
	var num = obj;
	var regex=/^(01[016789]{1})[0-9]{3,4}[0-9]{4}$/;
	if(regex.test(num) === false) {
		alert("잘못된 전화번호 형식입니다.");
		return false;
	} else {
		return true;
	}
	
}

/*
 * 텍스트 검증 (텍스트)
 */
function checkText(obj) {
		//이름 필수값 체크
		var obj = $("#CEO_NAME") ;
		if(obj.val().trim() == ""){
			alert( obj.attr('placeholder') +    '을(를) 입력하세요.');
			obj.focus();
			obj.select();
			return false;
		} else if(obj.val().trim().length < 2){
			alert('올바른 '	+	obj.attr('placeholder') +    '을(를) 입력하세요.');
		    obj.focus();
		    obj.select();
		    return false;
		}

		//생년월일  필수값 체크
		var obj = $("#BUILD_DATE") ;
		if(obj.val().trim() == ""){

			alert( obj.attr('placeholder') +    '을(를) 입력하세요.');
			obj.focus();
			obj.select();
			return false;
		} else if( !isValidDate(obj.val().trim()) ){
			alert("유효한 설립년도를 입력해주세요.\nex) 2017(숫자만 입력)");
			obj.focus();
			obj.select();
			return false;
		}

		//휴대전화  필수값 체크
	    var obj = $("#CORP_TEL1").val().trim() ;
	    obj += $("#CORP_TEL2").val().trim() ;
	    obj += $("#CORP_TEL3").val().trim() ;
	    if(!chkNum(obj)){
			//alert(!chkNum(obj))
			alert("대표전화는 숫자만 입력 가능합니다.");
			$("#CORP_TEL2").focus();
			return false;
		} else if( !(obj.length >= 9 && obj.length <= 11) ){
			alert("올바른 대표전화를 입력해주세요.");
			$("#CORP_TEL2").focus();
			return false;
		}
	    
		//상세주소
		var obj = $("#CORP_ADDR3") ;
		if(obj.val().trim() == ""){

			alert('상세주소를 입력하세요.');
			obj.focus();
			obj.select();
			return false;
		}
}




/*
 * 파일 업로드 여부 검사
 */
function checkFile() {
	var files = document.querySelectorAll('input[name*="uploadedDataFile"]');
	for (var i = 0; i < files.length; i++) {
		if (files[i].value == "") {
			alert("업로드 할 파일을 선택해주세요.");
			return false;
		}
	}
	return true;
}

/* 
 * 파일 다운로드
 * @param	fileSn, sortOrdr, fileSz
 * */
function fileDownload(fileSn, sortOrdr, fileSz) {
	var form = createForm("post", "/file/downloadFile.do");
	createField("fileSn", fileSn, form);
	createField("sortOrdr", sortOrdr, form);
	createField("fileSz", fileSz, form);
	submit(form);
}

/* 
 * 파일 추가
 * @param	item : this
 * @param	limitCnt(공백 가능) : 파일 업로드 개수 제한 (default: 5개)
 * @param	fileTaskCd(공백 가능) : 업무 코드 존재 시 설정
 */
function addFile(item, limitCnt, fileTaskCd) {
	var fileList = item.closest("td").querySelector(".fileList");
	var rowCnt = fileList.querySelectorAll("li").length;
	var fileIndex = rowCnt + 1;

	if (limitCnt == undefined) limitCnt = 5;
	if (rowCnt < limitCnt) {
		var row = document.createElement("li");
		if (fileTaskCd == undefined) { // 업무 코드 설정 X
			row.innerHTML = `<input type="file" name="uploadedDataFile${fileIndex}">
				<button type="button" onclick="deleteFile(this);" class="button02 f-right">제거</button>`;
		} else { // 업무 코드 설정 O
			row.innerHTML = `<input type="file" name="uploadedDataFile${fileIndex}${fileTaskCd}">
				<button type="button" onclick="deleteFile(this);" class="button02 f-right">제거</button>`;
		}
		fileList.appendChild(row);
	} else {
		alert("최대 "+limitCnt+"개까지만 첨부가 가능합니다.");
	}
}

/* 
 * 파일 삭제 
 */
function deleteFile(item){
	item.closest("li").remove();
}

/* 
 * 업로드된 기존 파일 삭제
 */
function deleteUploadedFile(fileSn, sortOrdr, item) {
	if (confirm("파일을 삭제하면 복구할 수 없습니다.\n삭제하시겠습니까?")) {
		$.ajax({
			type: "POST",
			url: "/file/deleteFile.do",
			data: {
				"fileSn" : fileSn,
				"sortOrdr" : sortOrdr
			},
			dataType: "json",
			success: function(result){
				if (result.result) {
					alert(result.msg);
					$(item).closest("li").remove();
				} else {
					alert(result.msg);
				}
			}
		});
	}
}


/* 
 * 테이블 행 개수 체크 후 메시지 row 설정
 * 사용법 : 1. jsp에서 테이블 행이 0개일 때 나타낼 메시지 행의 tr태그 id 값을 'table-messageRow'로 설정
 * 		  2. js로 테이블 행을 추가/삭제하는 메소드 안에서 tableRowCheck 메소드 호출
 */
function tableRowCheck(table) {
	var messageRow = table.querySelector("tr#table-messageRow");
	var rowCount = table.querySelectorAll("tbody > tr").length;

	if (rowCount == 1) {
		messageRow.style.display = "table-row";
	} else {
		messageRow.style.display = "none";
	}
}

function get_menu_list(menuType){
	//전체 메뉴목록 불러오기
	var searchKeyword = $("#searchKeyword").val();
	$.ajax({
        type: "get",
        url: "/admin/menu/search_menu_list.do",
        data: {"searchKeyword" : searchKeyword , "menuType" : menuType},
        dataType: "json",
        success:function(result) {
        	var list = result;
        	$("#menu_list").empty();
			
        	var html = "";
			if(menuType == 'header'){
			if ( list.length > 0 ) {
	        	for ( var i = 0 ; i < list.length ; i++ ) {
					html += `<li class="depth1"><a href="/${list[i].menuUrl}/main.do">${list[i].menuNm}</a></li>`;
	        		}
				}
			}else if(menuType == 'popup'){
				
        	if ( list.length > 0 ) {
        		
	        	for ( var i = 0 ; i < list.length ; i++ ) {
	        		
	        		html += '<tr>';
					html += '		<input type="hidden" name="menuNm" value="' + list[i].menuNm + '" />';
					html += '		<input type="hidden" name="menuId" value="' + list[i].menuId + '" />';
					html += '	<td>' + list[i].menuNm + '</td>';
					html += '	<td>' + list[i].menuId + '</td>';
					html += '	<td>' + list[i].menuUrl + '</td>';
					html += '	<td>' + list[i].menuOrder + '</td>';
					html += '	<td>' + list[i].useYn + '</td>';
					html += '	<td>';
					html += '		<input type="radio" name="select" value="' + list[i].menuId + '" />';
					html += '	</td>';
					html += '</tr>';
	        	}
	        	
	        	} else {
	        		html = "<tr><td colspan='5'>검색 결과가 없습니다.</td></tr>";
	        	}
			}
			
       		$("#menu_list").html(html);
		},
		error:function(x,e){
			console.log(x, e);
		}
	});
	
	
	/*$.ajax({
		type: "POST",
		url: "/admin/search_menu_list",
		data: {menuType: menuType},
		dataType: "json",
		success: function(result) {
			//메뉴목록 호출 성공 시
			var upCdList = result.upCdList;
			// 리스트 생성
			var menuList = new Array() ;
			for(var i=0; i<upCdList.length; i++){
				// 객체 생성
				var data = new Object();
				data.id = upCdList[i].menuCd;
				if(upCdList[i].menuUpCd != "TOP"){
					data.pId = upCdList[i].menuUpCd;
				}
				data.name = upCdList[i].menuNm;
				data.open = true;
				// 리스트에 생성된 객체 삽입
				menuList.push(data);
			}
			// String 형태로 변환
			var jsonData = JSON.stringify(menuList);
			
			//ztree 생성
			var setting = {
			    data: {
			        simpleData: {
			            enable: true,
			        }
			    },
		        callback : {
	    	        onClick: function(event, treeId, treeNode, clickFlag) {
	    				var selectedId = treeNode.id; //클릭한 메뉴의 코드를 확인
	    				selectMenu(selectedId);
	    	        },
	    	    }
			}
			
			$.fn.zTree.init($("#menuList"), setting, menuList);
		}
	});*/
}

/** 선택된 메뉴 정보 호출 */
function selectMenu(menuCd){
	var reqUrl = "/admin/selectAuthInfo";
	$.ajax({
	    type: "POST",
	    url: reqUrl,
	    data: {menuCd: menuCd},
	    dataType: "json",
	    success: function(result) {
	    	var resultMenu = result.menuCd;
	    	var authList = result.menuAuthList;
	    	var authListHtml = "<input type='hidden' name='menuCd' value='"+resultMenu+"'>";
	    		authListHtml += "<input type='hidden' id='authQty' value='"+authList.length+"'>";
	    	$.each(authList, function(i){
	    		var srchYn = authList[i].srchAuthYn == 'Y' ? 'checked' : '';
	    		/* var instYn = authList[i].instAuthYn == 'Y' ? 'checked' : '';
	    		var modyYn = authList[i].modyAuthYn == 'Y' ? 'checked' : '';
	    		var deltYn = authList[i].deltAuthYn == 'Y' ? 'checked' : ''; */
	    		authListHtml += "<tr>";
	    		authListHtml += "<input type='hidden' name='menuVoList["+i+"].menuCd' value='"+authList[i].menuCd+"'>";
	    		authListHtml += "<input type='hidden' name='menuVoList["+i+"].authCd' value='"+authList[i].authCd+"'>";
	    		authListHtml += "<td>"+authList[i].authCd+"</td>";
	    		authListHtml += "<td>"+authList[i].authNm+"</td>";
	    		authListHtml += "<td><input type='hidden' id='menuVoList["+i+"].srchAuthYn' name='menuVoList["+i+"].srchAuthYn'><input type='checkbox' title='선택' class='srchAuthYnChk' value='"+i+"' "+srchYn+"/></td>";
	    		/* authListHtml += "<td><input type='hidden' id='menuVoList["+i+"].instAuthYn' name='menuVoList["+i+"].instAuthYn'><input type='checkbox' title='선택' class='instAuthYnChk' value='"+i+"' "+instYn+"/></td>";
	    		authListHtml += "<td><input type='hidden' id='menuVoList["+i+"].modyAuthYn' name='menuVoList["+i+"].modyAuthYn'><input type='checkbox' title='선택' class='modyAuthYnChk' value='"+i+"' "+modyYn+"/></td>";
	    		authListHtml += "<td><input type='hidden' id='menuVoList["+i+"].deltAuthYn' name='menuVoList["+i+"].deltAuthYn'><input type='checkbox' title='선택' class='deltAuthYnChk' value='"+i+"' "+deltYn+"/></td>"; */
	    		authListHtml += "</tr>"
	    	});
	    	$("#authBody").html(authListHtml);
	    	var detailModal = $("#menuAuth");
	    	detailModal.css("display", "block");
	    	$("#menuTitle").text(authList[0].menuNm);
	    },
	    error : function(request, error){
	        //Ajax 실패시
	    	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        //새로고침
	        /* window.location.reload(); */
	    }
	});
}