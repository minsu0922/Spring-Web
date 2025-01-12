<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">

	$(document).ready(function() {
		initDatepicker("#user_birth");
		
		 $('[id^="user_cel"]').each(function() {
		     checkHangul(this);
		 });
		
		//번호 분리
		var userCel = $("#user_cel").val();
		$("#user_cel1").val(userCel.substring(0, 3));
		$("#user_cel2").val(userCel.substring(3, 7));
		$("#user_cel3").val(userCel.substring(7, 11));
		 
		//이메일 분리
		var email = $("#user_email").val();
		var emailParts = email.split('@');
		$("#user_email1").val(emailParts[0]);

		var domain = emailParts[1];
		var domainCheck = false;
		
		$("#user_email2 option").each(function(){
			if($(this).val() == domain){
				$(this).prop("selected", true);
				domainCheck = true;
				$("#user_email3").attr("disabled", true);
				return;
			}
		});
		
		if (!domainCheck) {
		    $("#user_email3").attr("disabled", false);  
		    $("#user_email3").val(domain);
		    $("#user_email2").val("nonono");
		}
	    
	});
	function resetPw(){
		if(confirm("비밀번호 초기화 시 ID와 동일하게 설정 됩니다.\n초기화 하시겠습니까?")){
			$("#formMember").attr("action","/admin/member/member_pwreset.do");
			$("#formMember").submit();
			
		}
	}
	
	function isNumber(event) {
	 var code = event.keyCode;
	    // 숫자(0-9), 백스페이스(8), Delete(46), Tab(9), 왼쪽(37), 오른쪽(39)
	    if ((code >= 48 && code <= 57) || code === 8 || code === 46 || code === 9 || code === 37 || code === 39) {
	        return true; 
	    } else {
	        event.preventDefault();
	        return false;
	    }
	}
	function updateInfo(){
		if(confirm("해당정보로 수정하시겠습니까?")){
			
			var email = $("#user_email1").val() + "@" + ($("#user_email2").val() != "nonono" ? $("#user_email2").val() : $("#user_email3").val());
			if(!chkEmail(email)){
				$("#user_email").focus();
				return false;
			} else {
				$("#user_email").val(email);
			}
			
			var cel_num = $("#user_cel1").val() + $("#user_cel2").val() + $("#user_cel3").val() ;
			$("#user_cel").val(cel_num);
			$("#formMember").attr("action","/admin/member/member_update.do");
			$("#formMember").submit();
		}
	}
	function memberList(){
		var url = "/member/member_list.do";
		window.location.href = url; 
	}
	function deleteInfo(){
		if(confirm("회원을 삭제하시겠습니까?")){
			$("#formMember").attr("action","/admin/member/member_delete.do");
			$("#formMember").submit();
		}
	}
	function chg_email(){
		var email = $("#user_email2").val();

		if(email == "nonono"){
			$("#user_email3").attr("disabled", false);
		} else {
			$("#user_email3").val("");
			$("#user_email3").attr("disabled", true);
		}
	}
	function checkHangul(input) {
		
	    var inputVal = input.value;
	    var check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;

	    if (check.test(inputVal)) {
	        input.value = "";
	    }
	}
</script>
	<c:choose>
		<c:when test="${! empty memberInfo }">
		<form id="formMember" name="formMember" method="post">
		<input type="hidden" id="user_id" name="user_id" value="${memberInfo.user_id }">
		<div style="margin-bottom: 10px; text-align: right;">
		<button class="btn05" style="height: 40px;margin: 0;" type="button" onclick="resetPw()">비번초기화</button>
		</div>
		<div class="bdtable2">
		<table border="1">
			<tr>
				<th>ID</th>
				<td>${memberInfo.user_id }</td>
				<th>이름</th>
				<td><input class="input01" type="text" id="user_name" name="user_name" value="${memberInfo.user_name }"></td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>
				<input type="hidden" id="user_cel" name="user_cel" value="${memberInfo.user_cel }">
				<input class="input01" id="user_cel1" name="user_cel1" type="text" maxlength="4" size="4" onkeydown="isNumber(event)" oninput="checkHangul(this)" />
					<span> - </span>
				<input class="input01" id="user_cel2" name="user_cel2" type="text" maxlength="4" size="4" onkeydown="isNumber(event)" oninput="checkHangul(this)" />
					<span> - </span>
				<input class="input01" id="user_cel3" name="user_cel3" type="text" maxlength="4" size="4" onkeydown="isNumber(event)" oninput="checkHangul(this)" />
				</td>
				<th>생년월일</th>
				<td><input class="input01" type="text" id="user_birth" name="user_birth" value="${memberInfo.user_birth }" readonly></td>
			</tr>
			<tr>
				<th>권한</th>
				<td>
					<input type="radio" id="user_role" name="user_role" value="ROLE_ADMIN" ${memberInfo.user_role eq 'ROLE_ADMIN' ? 'checked="checked"' : '' }> 관리자
					<input type="radio" id="user_role" name="user_role" value="ROLE_USER" ${memberInfo.user_role eq 'ROLE_USER' ? 'checked="checked"' : '' }> 사용자
				</td>
				<th>사용여부</th>
				<td>
					<input type="radio" name="del_yn" value="N" ${memberInfo.del_yn eq 'N' ? 'checked="checked"' : '' }>사용
					<input type="radio" name="del_yn" value="Y" ${memberInfo.del_yn eq 'Y' ? 'checked="checked"' : '' }>미사용
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td style="text-align:left;">
				<input type="hidden" id="user_email" name="user_email" value="${memberInfo.user_email }">
					<input class="input01" id="user_email1" name="user_email1" style="width: 120px;" type="text" />
								@
					<select id="user_email2"  class="select01" onchange="chg_email();" >
						<option value="">선택</option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="daum.net">daum.net</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="nate.com">nate.com</option>
						<option value="empal.com">empal.com</option>
						<option value="hotmail.com">hotmail.com</option>
						<option value="nonono">직접입력</option>
					</select>
					<input class="input01" id="user_email3" type="text" style="width: 120px;"  disabled />
					<p> (직접입력시 @는 제외하고 도메인만 입력하세요.)</p>
				</td>
				<th>주소</th>
				<td style="text-align:left;">
					<input class="input01" style="width: 120px;" type="text" id="zip_code" name="zip_code" value="${memberInfo.zip_code}">
					<input class="input01" type="text" id="user_addr" name="user_addr" value="${memberInfo.user_addr }">
					<button type="button" class="input_btn01 btn01" onclick="daumPostcode()">우편번호 찾기</button>
					<p style="margin-top: 5px">
					<input class="input01" style="width: 449px;" type="text" id="user_detail_addr" name="user_detail_addr" value="${memberInfo.user_detail_addr }">
					<input type="hidden" id="user_extra_addr" name="user_extra_addr" value="${memberInfo.user_extra_addr}">
					</p>
				</td>
				<!-- <th><button onclick="resetPw()">비번초기화</button></th> -->
			</tr>
		</table>
		</div>
		</form>
			<div class="mrtp" style="text-align: center;">
			<button type="button" class="btn04 input_btn01" onclick="memberList()">목록</button>
			<button type="button" class="btn03 input_btn01" style="margin:0 10px;"onclick="updateInfo()">저장</button>
			<button type="button" class="del_btn01 input_btn01" style="min-width: 100px; border-radius:0;" onclick="deleteInfo()">삭제</button>
			</div>
		</c:when>
		</c:choose>