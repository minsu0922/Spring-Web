<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />	
<!-- jsTree theme -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<h2 class="subtitle">관리자 메뉴 입니다.</h2>
<div class="menulist-box">
	<!-- 메뉴 리스트 jstree -->
	<div class="menu_tree_list" style="width: 50%;">
		<div class="login-popup">
		<!-- 조회 및 검색 영역 시작 -->		
		<table border="1" class="table-sap1">
			<tbody>
				<tr>
					<th>메뉴명</th>
					<th>
						<select class="btn_m" name="searchMenuType">
						    <option value="admin">관리자</option>
						    <option value="user">사용자</option>
						 </select> 
					</th>	
				</tr>
			</tbody>
		</table>
		<!-- 조회 검색 영역 끝 -->
	</div>
		
	<div class="menuList">
		<div id="tree">
			<ul id="menu_tree" class="tree">
			</ul>
		</div>
	</div>
</div>	
<!-- 메누 리스트 종료 -->
<!-- 메뉴 등록  -->
	<div class="bdtable2">
    <form action="/admin/menu/menu_list_insert.do" id="menu_List" name="menu_List" method="post">
	<input type="hidden" name="menu_id" id="menu_id" value="" />
	<table border="1" >
		<tr>
			<th>대메뉴</th>
			<td colspan="3" class="p10">
				<label> 
					<input type="radio" id="menu_type_user" name="menu_type" value="user" autocomplete="off"/>사용자
				</label> 
				<label> 
					<input type="radio" id="menu_type_admin" name="menu_type" value="admin" autocomplete="off" />관리자
				</label>
			</td>
		</tr>
		<tr>
			<th>상위메뉴</th>
			<td colspan="2" style="text-align: left;">
				<input type="text" name="up_menu_id" id="up_menu_id" class="input01" style="width: 100%;"readonly/>
				<input type="hidden" name="up_menu_nm" id="up_menu_nm" />
				<div style="text-align: right;margin-top:10px;">
				<button type="button" id="btn_menu_select_popup" class="input_btn01 btn03">메뉴 선택</button>
                <button type="button" id="btn_top_menu" class="input_btn01 btn04">최상위 메뉴</button>
				</div>
				<!-- <input type="button" value="메뉴선택" id="btn_select_menu_popup" class="btn_m"/>
				<input type="button" value="최상위메뉴" id="btn_top_menu" class="btn_m"/> -->
				<input type="hidden" id="top_menu_yn" name="top_menu_yn" value="N" />
			</td>	
		</tr>
		<tr>
			<th>메뉴URL</th>
			<td colspan="3" style="text-align: left;">
				<input type="text" name="menu_url" id="menu_url" value="" class="input01"  style="width: 100%;" placeholder ="메뉴경로(영어)"/>
			</td>
		</tr>
		<tr>
			<th>메뉴명</th>
			<td colspan="3" style="text-align: left;">
				<input type="text" name="menu_nm" id="menu_nm" class="input01"  style="width: 100%;" placeholder ="메뉴명(한글)" />
			</td>
		</tr>
		<tr>
			<th>메뉴깊이</th>
			<td colspan="3" class="p10">
				<label style="margin-right:10px;"> 
					<input type="radio" id="menu_depth_1" name="menu_depth" autocomplete="off" value="1" disabled />1
				</label> 
				<label style="margin-right:10px;"> 
					<input type="radio" id="menu_depth_2" name="menu_depth" autocomplete="off" value="2" />2
				</label> 
				<label> 
					<input type="radio" id="menu_depth_3" name="menu_depth" autocomplete="off" value="3" />3
				</label>
			</td>
		</tr>
		<tr>
			<th>메뉴순서</th>
			<td colspan="3" class="p10">
				<c:forEach begin="1" end="${menu_list.size()}" var="index">
					<label style="margin-right:10px;"><input type="radio" name="menu_order" autocomplete="off" value="${index}" />${index}</label>
				</c:forEach>
				<!-- <label> 
					<input type="radio" name="menu_order" autocomplete="off" value="1" />1
				</label> 
				<label> 
					<input type="radio" name="menu_order" autocomplete="off" value="2" />2
				</label> 
				<label> 
					<input type="radio" name="menu_order" autocomplete="off" value="3" />3
				</label>
				<label> 
					<input type="radio" name="menu_order" autocomplete="off" value="4" />4
				</label> 
				<label> 
					<input type="radio" name="menu_order" autocomplete="off" value="5" />5
				</label> 
				<label> 
					<input type="radio" name="menu_order" autocomplete="off" value="6" />6
				</label>
				<label> 
					<input type="radio" name="menu_order" autocomplete="off" value="7" />7
				</label> 
				<label> 
					<input type="radio" name="menu_order" autocomplete="off" value="8" />8
				</label> 
				<label> 
					<input type="radio" name="menu_order" autocomplete="off" value="9" />9
				</label> -->
			</td>
		</tr>
		<tr>
			<th>사용여부</th>
			<th colspan="3" class="p10">
				<label> 
					<input type="radio" id="use_yn_y" name="use_yn" autocomplete="off" value="Y" checked />사용
				</label> 
				<label> 
					<input type="radio" id="use_yn_n"  name="use_yn" autocomplete="off" value="N" />미사용
				</label>
			</th>
		</tr>
				
		<tr>
			<th rowspan="3">권한여부</th>
			<th class="p10">시스템 관리자</th>
			<td class="p10">
				<label> 
					<input type="radio" id="admin_allow_1" name="admin_allow" autocomplete="off" value="1" />조회
				</label>	
				<label> 
					<input type="radio" id="admin_allow_2" name="admin_allow" autocomplete="off" value="2" />조회/쓰기/수정
				</label>	
				<label> 
					<input type="radio" id="admin_allow_3" name="admin_allow" autocomplete="off" value="3" />모든권한
				</label>
			</td>
		</tr>
		<tr>
			<th class="p10">운영자</th>
			<td class="p10">
				<label> 
					<input type="radio" id="manage_allow_1" name="manage_allow" autocomplete="off" value="1" />조회
					</label>
				<label> 
					<input type="radio" id="manage_allow_2" name="manage_allow" autocomplete="off" value="2" />조회/쓰기/수정
					</label>
				<label> 
					<input type="radio" id="manage_allow_3" name="manage_allow" autocomplete="off" value="3" />모든권한
				</label>
			</td>
		</tr>
		<tr>
			<th class="p10">일반회원</th>
			<td class="p10">
				<label> 
					<input type="radio" id="user_allow_1" name="user_allow" autocomplete="off" value="1" />조회
				</label> 
				<label> 
					<input type="radio" id="user_allow_2" name="user_allow" autocomplete="off" value="2" />조회/쓰기/수정
				</label> 
				<label> 
					<input type="radio" id="user_allow_3" name="user_allow" autocomplete="off" value="3" />모든권한
				</label>
			</td>
		</tr>
	</table>
	<div class="clearfix mrtp">
                        <button id="submitBtn" class="btn02 input_btn01 right" type="button">등록</button>
    </div>
</form>
	</div>
</div>
<!-- 메뉴 등록 종료 -->
<script src="/resources/js/admin/menu.js"></script>