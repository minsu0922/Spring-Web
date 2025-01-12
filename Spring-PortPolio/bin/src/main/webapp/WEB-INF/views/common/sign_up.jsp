<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<title>회원가입</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript">
var isPassCheckId = false ; // 중복아이디 체크
$(document).ready(function(){
	// 달력    
	initDatepicker("#user_birth");
	
	var userInfo = '${userInfo}';
	var submitTxt = "가입";
	if(userInfo != ''){
		submitTxt = "수정";
	}

	$("#submitBtn").val(submitTxt);
	$(".submitTxt").html("정보"+submitTxt);
	
//아이디 중복체크
$("#btn_id_check").click(function(){
	var idVal = $("#user_id").val().trim();
	//아이디 값 유효성 검사
	if(checkId("#user_id")){
		isPassCheckId = true;
	}
	if(isPassCheckId){
	    $.ajax({
	        type: "get",
	        url: "/common/chkUserId.do",
	        data: { user_id: idVal },
	        dataType: "json",
	        success:function( result ) {
		          if(result == 0){
		        	  alert('사용가능한 아이디 입니다.') ;
		        	  isPassCheckId = true;
		        	  $("#user_id").val(idVal);
		        	  $("#user_password").focus();
		          }
		          if(result !=0){
		        	  alert('이미 사용하고 있는 아이디 입니다.') ;
		        	  isPassCheckId = false;
		        	  $("#user_id").select();
		          }
	        }
	      });
	}
});

//입력폼 체크
$("#submitBtn").click(function(){
	var registForm = $("#registForm");
	var email = $("#user_email1").val() + "@" + ($("#user_email2").val() != "nonono" ? $("#user_email2").val() : $("#user_email3").val());
	var cel_num = $("#user_cel1").val().trim() ;
	cel_num += $("#user_cel2").val().trim() ;
	cel_num += $("#user_cel3").val().trim() ;
	console.log(email);
	console.log(cel_num);
	
	//필수 입력값 유효성 검사
	if(!validation(registForm)){
		return false;
	}
	//아이디 중복검사 
	if(!isPassCheckId){
		alert("아이디 중복검사를 진행하세요.");
		$("#btn_id_check").focus();
		console.log("1");
		return false;
	}
	//전화번호 유효성 검사
	if(!checkTelno(cel_num)){
		$("#user_cel2").focus();
		console.log("2");
		return false;
	} else {
		$("#user_cel").val(cel_num);
	}
	
	//이메일 유효성 검사
	if(!chkEmail(email)){
		$("#user_email1").focus();
		console.log("3");
		return false;
	} else {
		$("#user_email").val(email);
	}
	
	if(confirm(submitTxt + " 하시겠습니까?")){
	 $('#registForm').submit();
	}
});

$("#cancelBtn").click(function(){
	history.back();
});

});
//비밀번호 일치 확인
function passwordCheck(){
	if($("#user_password").val().trim() != $("#user_password2").val().trim()){
		$("#passMessage").html("비밀번호가 서로 일치하지 않습니다.");
		return false;
	}else{
		$("#passMessage").html("");
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
</script>
</head>
<body>
	<div class="container">
	<!-- 컨텐츠 시작 -->
	<div class="contents" style="float: none;">

		<!-- 서브타이틀 영역 시작 -->
		<div class="sub-title">
			<div class="navi">
				<a href="/sign_up.do">
					<img src="/resources/images/common/quick_home.png" />
				</a>
				&nbsp;<img src="/resources/images/common/quick_next.png" />
				<b>회원<span class="submitTxt">가입</span></b>
			</div>
		</div>
		<!-- 서브타이틀 영역 시작 -->
		<form id="registForm" method="post" action="/common/sign_up.do" novalidate="novalidate">
			<!-- 본문 영역 시작 -->
			<div class="content">
				<table class="table-pb">
					<tbody>
						<tr>
							<th>아이디 <font color="red">*</font></th>
							<td class="p10">
								<c:choose>
									<c:when  test="${userInfo eq null }">
										<input class="must" id="user_id" name="user_id" type="text" placeholder="아이디"  />
										<input type="button" value="ID중복체크" id="btn_id_check" class="btn_m"/><br>
									</c:when>
									<c:otherwise>
										${userInfo.user_id }
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th>비밀번호 <font color="red">*</font></th>
							<td class="p10">
								<input id="user_password" class="" name="user_password" type="password" placeholder="비밀번호"  value="${userInfo.user_pw}" onkeyup="passwordCheck()"/>
								<span>(6자 이상)</span>
							</td>
						</tr>
						<tr>
							<th>비밀번호확인 <font color="red">*</font></th>
							<td class="p10">
								<input id="user_password2" name="user_password2" type="password" placeholder="비밀번호확인"  value="${userInfo.user_pw}" onkeyup="passwordCheck()" />
								<span id="passMessage" style="color: red"></span>
							</td>
						</tr>

						<tr>
							<th>이름 <font color="red">*</font></th>
							<td class="p10">
								<input id="user_name" class="must" name="user_name" type="text" placeholder="이름" value="${userInfo.ceo_name }"/>
							</td>
						</tr>
						<tr>
							<th>생년월일 <font color="red">*</font></th>
							<td class="p10">
								<input type="text" class="must" id="user_birth" name="user_birth" placeholder="생년월일"  value="${userInfo.user_work}">
							</td>
						</tr>
						<tr>
							<th>휴대폰 <font color="red">*</font></th>
							<td class="p10">
								<input id="user_cel" name="user_cel" type="hidden"  value="${userInfo.user_cel}" placeholder="핸드폰번호" />
								<%-- <select  class="tel" name="user_cel1" id="user_ce11" >
									<option value="010" <c:if test="${userInfo.user_tel1 eq '010'}">selected</c:if>>010</option>
									<option value="011" <c:if test="${userInfo.user_tel1 eq '011'}">selected</c:if>>011</option>
									<option value="016" <c:if test="${userInfo.user_tel1 eq '016'}">selected</c:if>>016</option>
									<option value="017" <c:if test="${userInfo.user_tel1 eq '017'}">selected</c:if>>017</option>
									<option value="018" <c:if test="${userInfo.user_tel1 eq '018'}">selected</c:if>>018</option>
									<option value="019" <c:if test="${userInfo.user_tel1 eq '019'}">selected</c:if>>019</option>
								</select> --%>
								<input id="user_cel1" name="user_cel" type="text" maxlength="4"  size="4"   value="010" />
								<span> - </span>
								<input id="user_cel2" name="user_cel2" type="text" maxlength="4"  size="4"   value="${userInfo.user_cel2}" />
								<span> - </span>
								<input id="user_cel3" name="user_cel3" type="text" maxlength="4"  size="4"   value="${userInfo.user_cel3}" />
							</td>
						</tr>
						<tr>
							<th>주소<font color="red">*</font></th>
							<td class="p10">
								<input type="text" class="must" id="zip_code" name="zip_code" value="${userInfo.zip_code}" readonly placeholder="우편번호">
								<input type="button"  class="btn_m" onclick="daumPostcode()" value="우편번호 찾기"><br>
								<input type="text" class="must" id="user_addr" name="user_addr" readonly value="${userInfo.user_addr}" placeholder="주소"><br>
								<input type="text" class="must" id="user_detail_addr" name="user_detail_addr"  value="${userInfo.user_detail_addr}" placeholder="상세주소">
								<input type="hidden" id="user_extra_addr" name="user_extra_addr" value="${userInfo.user_extra_addr}" placeholder="참고항목">
								<%-- <input type="text" id="zip_code" name="zip_code" value="${userInfo.corp_zip_code}"  readonly onclick="openDaumPostCode('CORP_ZIP_CODE','CORP_ADDR1','CORP_ADDR2','CORP_ADDR3','CORP_ADDR4');"/>
								<input type="button" class="btn_m" value="우편번호 찾기" onclick="openDaumPostCode('CORP_ZIP_CODE','CORP_ADDR1','CORP_ADDR2','CORP_ADDR3','CORP_ADDR4');"/><br>
								<input type="hidden" id="user_addr1" name="user_addr1" value="${userInfo.corp_addr1}"/>
								<input type="hidden" id="user_addr2" name="user_addr2" value="${userInfo.corp_addr2}"/>
								<input type="text" id="user_addr3" name="user_addr3"  value="${userInfo.corp_addr3}" readonly onclick="openDaumPostCode('CORP_ZIP_CODE','CORP_ADDR1','CORP_ADDR2','CORP_ADDR3','CORP_ADDR4');"/>
								<input type="text" id="user_addr4" name="user_addr4"  placeholder="상세 주소를 입력하세요."  value="${userInfo.corp_addr4}"/> --%>
							</td>
						</tr>
						<tr>
							<th>이메일 <font color="red">*</font></th>
							<td class="p10">
								<input id="user_email" name="user_email" type="hidden"  value="${userInfo.user_email}" placeholder="이메일" />
								<input id="user_email1" name="user_email1" class="must" type="text" placeholder="이메일" value=""/>
								@
								<select id="user_email2" onchange="chg_email();" >
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
								<input id="user_email3" type="text" style="width: 120px;"  disabled />
								<br>
								<span> (직접입력시 @는 제외하고 도메인만 입력하세요.)</span>
							</td>
						</tr>
						<tr>
							<th>권한<font color="red">*</font></th>
							<td class="p10">
								<label> 
									<input type="radio" name="user_role"
									autocomplete="off" value="ROLE_ADMIN" checked />관리자
								</label> 
								<label> 
									<input type="radio" name="user_role"
										autocomplete="off" value="ROLE_USER" />유저
								</label>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="tac">
				<input id="submitBtn" type="button" class="btn002 red-b hover-red-r" value="회원가입"/>
		 		<a href="/common/login.do"><input type="button" class="btn002 red-b" value="취소"/></a>
		 	</div>
		</form>
	</div>
</div>


<!-- 다음우편번호 레이어팝업 -->
<div id="postcode-daumapi-wrap" style="display:none;position:fixed; height:605px; -webkit-overflow-scrolling:touch; width:430px;  border:1px solid #000; background:#fff; box-sizing:border-box; padding:0 26px; left:50%; top:50%; z-index:9000; transform: translate(-50%, -50%)">
	<img src="/resources/images/common/close_zip.gif" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:25px;top:25px; z-index:1000" onclick="closeDaumPostcode();" alt="닫기 버튼">
	<p style="padding:25px 0 20px 0; width:100%; margin:0 auto; border-bottom:2px solid #000; text-align:center;">
		<img src="/resources/images/common/txt_zip.gif" alt="" />
	</p>
	<div id="postcode-daumapi" style="width:100%; height:475px; margin:20px auto 0 auto; border:1px solid #aaa;"></div>
</div>
<!-- 다음우편번호 레이어팝업 -->
</body>
</html>