<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
  <head>
	<meta charset="UTF-8">
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link rel="stylesheet" href="${contextPath}/resources/css/styles.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
	<script src="/resources/js/common/common.js"></script>
  </head>

  <body>
	  <!-- 스킵 네비게이션(s) -->
	    <div id="skipNavigation">
	        <ul>
	            <li>
	                <a href="#container">본문 바로가기</a>
	            </li>
	        </ul>
	    </div>
	    <!--// 스킵 네비게이션(e) -->
        <!-- Header Area(s) -->
        <header id="header">
            <div class="logo_con">
            <div class="logoName">
                <a href="#" class="logo" title="이안시스템CMS">이안시스템CMS</a>
                <a href="#" class="logo2" title="이안시스템CMS"><img src="../../resources/images/common/header_logo_mb.png" alt="이안시스템CMS"></a>
            </div>
            </div>
        </header>
        <!--// Header Area(e) -->
        <!-- contents Area(s) -->
        <div id="main" class="main">
        <main>
	  		<tiles:insertAttribute name="content" />
        </main>
        </div>
        <!--// contents Area(e) -->
  	<tiles:insertAttribute name="footer" />
  </body>
    <tiles:insertAttribute name="modal" />
  
</html>
