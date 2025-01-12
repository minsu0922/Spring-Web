<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript">

    function updateInfo(){
        if(confirm("해당정보로 수정하시겠습니까?")){
            $("#formPopup").attr("action", "/admin/popban/mainslide_update.do");
            $("#formPopup").submit();
        }
    }

    function deleteInfo(){
        if(confirm("슬라이드를 삭제하시겠습니까?")){
            $("#formPopup").attr("action", "/admin/popban/mainslide_delete.do");
            $("#formPopup").submit();
        }
    }

    function popupList(){
    	var url = "/admin/popban/popup_list.do";
		window.location.href = url; 
    }
</script>

</head>
<body>

<div class="popup-container">
    <c:choose>
        <c:when test="${! empty popupInfo }">
            <form id="formPopup" name="formPopup" method="post">
                <input type="hidden" id="popban_sn" name="popban_sn" value="${popupInfo.popban_sn }">
                <table border="1" style="width:100%; table-layout: fixed;">
                    <tr>
                        <th style="width: 150px;">제목</th>
                        <td style="width: 150px;">
                            <input type="text" id="popban_nm" name="popban_nm" value="${popupInfo.popban_nm}">
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 150px;">사용여부</th>
                        <td style="width: 150px;">
                            <select id="use_yn" name="use_yn" style="width: 100px;">
                                <option value="Y" ${popupInfo.use_yn == 'Y' ? 'selected' : ''}>사용</option>
                                <option value="N" ${popupInfo.use_yn == 'N' ? 'selected' : ''}>미사용</option>
                            </select>
                        </td>
                        <th style="width: 150px;">사이트 분류</th>
                        <td style="width: 150px;">
                            <select id="site_sn" name="site_sn" style="width: 100px;">
                                <option value="2001" ${popupInfo.site_sn == '2001' ? 'selected' : ''}>사이트1</option>
                                <option value="2002" ${popupInfo.site_sn == '2002' ? 'selected' : ''}>사이트2</option>
                                <option value="2003" ${popupInfo.site_sn == '2003' ? 'selected' : ''}>사이트3</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 150px;">메인이미지(PC)<br>이미지 크기 : 1920*840</th>
                        <td style="width: 150px;"></td>
                    </tr>
                    <tr>
                        <th style="width: 150px;">메인이미지(모바일)<br>이미지 크기 : 1920*840</th>
                        <td style="width: 150px;"></td>
                    </tr>
                    <tr>
                        <th style="width: 150px;">메인이미지<br>설명</th>
                        <td style="width: 150px;">
                            <input type="text" id="popban_desc" name="popban_desc" value="${popupInfo.popban_desc}">
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 150px;">메인이미지<br>대체텍스트(PC)</th>
                        <td style="width: 150px;"></td>
                        <th style="width: 150px;">메인이미지<br>대체텍스트(모바일)</th>
                        <td style="width: 150px;"></td>
                    </tr>
                    <tr>
                        <th style="width: 150px;">순서</th>
                        <td style="width: 150px;">
                            <input type="number" id="popban_order" name="popban_order" value="${popupInfo.popban_order}" min="1" max="100">
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 150px;">게시일시</th>
                        <td style="width: 150px;">${popupInfo.reg_dt}</td>
                    </tr>
                    <tr>
                        <th style="width: 150px;">등록자 아이디<br>/ 등록일</th>
                        <td style="width: 150px;">${popupInfo.rgtr_id} / ${popupInfo.reg_dt}</td>
                        <th style="width: 150px;">수정자 아이디<br>/ 수정일</th>
                        <td style="width: 150px;">${popupInfo.mdfr_id} / ${popupInfo.mdfcn_dt}</td>
                    </tr>
                </table>
            </form>
            <button onclick="updateInfo()">저장</button>
            <button onclick="deleteInfo()">삭제</button>
            <button onclick="popupList()">목록</button>
        </c:when>
    </c:choose>
</div>

</body>
</html>
