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
	<link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<%-- <link rel="stylesheet" href="${contextPath}/resources/css/common/style_common.css"> --%>
	<link rel="stylesheet" href="${contextPath}/resources/css/styles.css">
	<title>이안시스템</title>
	<!-- 에디터 -->
	<!-- <link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/43.2.0/ckeditor5.css" /> -->
	<!-- <link rel="stylesheet" href="resources/css/common/style_contents.css"> -->
<%--     <sec:authorize access="hasAnyRole('ROLE_ADMIN')">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/admin/style_admin.css">
	</sec:authorize>
	<sec:authorize access="hasAnyRole('ROLE_USER')">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/user/style_user.css">
<<<<<<< HEAD
	</sec:authorize> --%>
  </head>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="https://kit.fontawesome.com/b17d4fa9e7.js" crossorigin="anonymous"></script>
  <!-- jsTree -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
   <!-- 에디터 -->
   <link rel="icon" type="image/png" href="https://ckeditor.com/assets/images/favicons/32x32.png" sizes="32x32">
	<link rel="icon" type="image/png" href="https://ckeditor.com/assets/images/favicons/96x96.png" sizes="96x96">
	<link rel="apple-touch-icon" type="image/png" href="https://ckeditor.com/assets/images/favicons/120x120.png" sizes="120x120">
	<link rel="apple-touch-icon" type="image/png" href="https://ckeditor.com/assets/images/favicons/152x152.png" sizes="152x152">
	<link rel="apple-touch-icon" type="image/png" href="https://ckeditor.com/assets/images/favicons/167x167.png" sizes="167x167">
	<link rel="apple-touch-icon" type="image/png" href="https://ckeditor.com/assets/images/favicons/180x180.png" sizes="180x180">
	<link rel="stylesheet" href="/resources/style.css">
	<link rel="stylesheet" href="/resources/ckeditor5/ckeditor5.css">
  <%-- <script src="${contextPath}/resources/ckeditor5/ckeditor5.js"></script> --%>
  <%-- <script src="${contextPath}/resources/ckeditor/ckeditor.js"></script> --%>
  <%-- <script src="${contextPath}/resources/ckeditor5/ckeditor5.umd.js"></script> --%>
  <script src="/resources/js/common/common.js"></script>
 
  <body>
  <tiles:insertAttribute name="header" />
  	<div id="main" class="main">
  	<main>
		  <div id="contents" class='content'>  	
  			 <tiles:insertAttribute name="left"/>
  			 <div class="subWrap">
	  		 <tiles:insertAttribute name="content" ignore="true"/>
	  		 </div>
  			</div>
  		</main>
  	</div>
  	<tiles:insertAttribute name="footer" />
  </body>
  <tiles:insertAttribute name="modal" />
</html>
