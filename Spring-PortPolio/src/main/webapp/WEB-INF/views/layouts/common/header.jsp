<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- Header Area(s) -->
        <header id="header">
            <div class="logo_con">
            <div class="logoName">
                <sec:authorize access="hasAnyRole('ROLE_ADMIN')">
            	<a href="/common/login.do" class="logo" title="이안시스템CMS">이안시스템CMS</a>
	            </sec:authorize>
	            <sec:authorize access="hasAnyRole('ROLE_USER')">
	            	<a href="/common/login.do" class="logo" title="이안시스템CMS">이안시스템CMS</a>
	            </sec:authorize>
	            <sec:authorize access="!isAuthenticated()">
	            	<a href="/common/login.do" class="logo" title="이안시스템CMS">이안시스템CMS</a>
	            </sec:authorize>
                <ul class="glb">
                <sec:authorize access="isAuthenticated()">
        	<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">
                    <li><p>환영합니다. <sec:authentication property="principal.user_role"/> <sec:authentication property="principal.user_name"/>님.</p></li>
                    <li><a href="/member/member_list.do">회원수정</a></li>
                    <li class="logout log"><a href="/common/logout">로그아웃</a></li>
                    </sec:authorize>
		</sec:authorize>
                </ul>
            </div>
            </div>
            <!-- deskTop Navigation Area(s) -->
            <nav id="navDesktop">
                <h2 class="blind">이안CMS 주요메뉴</h2>
                <div class="gnb_box">
                    <div class="gnbMenu">
                        <sec:authorize access="hasAnyRole('ROLE_ADMIN')">
                        <ul id="menu_list" class="gnb">
                        	<c:forEach var="list" items="${menu_list}" varStatus="status">
                        		<c:if test="${list.menuDepth eq 1}">
					        		<li><a href="${list.menuUrl}">${list.menuNm}</a></li>
                        		</c:if>
							</c:forEach>
						</ul>       
                        </sec:authorize>
                        <sec:authorize access="hasAnyRole('ROLE_USER')">
				        <ul id="menu_list" class="gnb">
				            <li class="depth1"><a href="/common/com_cd_list.do">시스템관리</a></li>
				            <li class="depth1"><a href="">사이트관리</a></li>
				            <li class="depth1"><a href="/member/member_list.do">회원관리</a></li>
				            <li class="depth1"><a href="/menu/menu_list.do">메뉴관리</a></li>
				            <li class="depth1"><a href="/contents/boardWriteView.do">콘텐츠관리</a></li>
				            <li class="depth1"><a href="/popup/mainslide_list.do">팝업 및 배너관리</a></li>
				            <li class="depth1"><a href="">만족도관리</a></li>
				            <li class="depth1"><a href="/statistic/statistic_list.do">접속통계관리</a></li>
				        </ul>
						</sec:authorize>	
                    </div>
                </div>
            </nav>
        </header>
        <!--// Header Area(e) -->