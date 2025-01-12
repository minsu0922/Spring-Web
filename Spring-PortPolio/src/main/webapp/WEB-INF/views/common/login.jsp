<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
			<div id="container" class="maininner">
            <form action="/common/loginProcess.do" method="post" id="login-form">
        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> <!-- CSRF 토큰 -->
                <!-- main first Area(s) -->
                <div class="mainsector1 login_page">
                    <h2>관리자 페이지 로그인</h2>
                    <div class="login-box">
                        <div class="login_input idinput">
                            <input id="id" type="text" name="user_id" placeholder="아이디">
                        </div>
                        <div class="login_input pwinput">
                            <input id="pw" type="password" name="user_password" placeholder="비밀번호">
                        </div>
                    </div>
                    <button class="login-button" type="submit" name="submit" value="로그인">로그인 하기</button>
                    <div class="loginbutton-box2" style="text-align: center;">
                            <a id="signUpBtn" type="button" class="user_btn" onclick="location.href='/common/sign_up.do'">회원가입</a>
                    </div>
                </div>
                <!-- main first Area(e) -->
                </form>
            </div>
            