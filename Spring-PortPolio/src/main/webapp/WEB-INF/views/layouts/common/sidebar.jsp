<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
	<div class="leftMenu" id="leftMenu"  style="position: sticky; top: 0px;">
		<h3>${side_menuNm}</h3>
        <c:forEach var="list" items="${menu_list}" varStatus="status">
        	<c:if test="${list.upMenuNm eq side_menuNm}">
		        <div class="subMenu">
		            <c:if test="${list.menuDepth eq 2}">
						<a href="${list.menuUrl}">${list.menuNm}</a>
		           </c:if>
		        </div>	
        	</c:if>
		</c:forEach>
	</div>