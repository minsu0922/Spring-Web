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
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/common/style_common.css">
	<!-- 에디터 -->
	<link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/43.2.0/ckeditor5.css" />
	<!-- <link rel="stylesheet" href="resources/css/common/style_contents.css"> -->
    <%-- <sec:authorize access="hasAnyRole('ROLE_ADMIN')">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/admin/style_admin.css">
	</sec:authorize>
	<sec:authorize access="hasAnyRole('ROLE_USER')">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/user/style_user.css">
	</sec:authorize> --%>
    <!-- <script src="https://code.jquery.com/jquery-latest.min.js"></script> jquery 최신 버전을 자동으로 불러오는  -->
  </head>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="https://kit.fontawesome.com/b17d4fa9e7.js" crossorigin="anonymous"></script>
   <!-- 에디터 -->
  <%-- <script src="${contextPath}/resources/ckeditor5/ckeditor5.js"></script> --%>
  <script src="${contextPath}/resources/ckeditor/ckeditor.js"></script>
  <%-- <script src="${contextPath}/resources/ckeditor5/ckeditor5.umd.js"></script> --%>
  <script src="/resources/js/common/common.js"></script>
  <body>
  	<div class='wrap'>
		 <div class='content'>  	
	  		<div class="">
	  			<tiles:insertAttribute name="content"/>
	  		</div>
  		</div>
  	</div>
  </body>
  	<tiles:insertAttribute name="modal"/>
</html>
