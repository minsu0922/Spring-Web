$(document).ready(function(){
	
//메뉴타입에 따른 메뉴트리
if(($("select[name=searchMenuType]").val()) != null){
	if($("select[name=searchMenuType]").val() == 'user'){
		getMenuTree('user');
	}else{
		getMenuTree('admin');
	}
}

//메뉴타입에 따른 메뉴트리
$("select[name=searchMenuType]").on("change",function () {
		getMenuTree($(this).val());
});

//팝업 메뉴 창
$("#btn_select_menu_popup").click(function(){
	radio_toggle("N");
	var url = "/admin/menu/menu_list_popup.do";
	var option = "width=550, height=550, location=no, menubar=no, resizable=no, scrollbars=no, status=no, toolbar=no";
	window.open(url, 'menu_select', option);
});

// 팝업 메뉴 검색
$("#btn_search_menu_popup").click(function(){
	var searchKeyword = $("#searchKeyword").val();
	console.log(searchKeyword);
	$.ajax({
        type: "get",
        url: "/admin/menu/search_menu_list.do",
        data: {"searchKeyword" : searchKeyword},
        dataType: "json",
        success:function(result) {
        	const list = result;
        	$("#menu_list").empty();
			const menu_list = document.getElementById('menu_list');
        	if ( list.length > 0 ) {
				for (let i = 0; i < list.length; i++) {
				    const row = document.createElement('tr');
				    // 숨겨진 input 요소들
				    const hiddenMenuNm = document.createElement('input');
				    hiddenMenuNm.type = 'hidden';
				    hiddenMenuNm.name = 'menuNm';
				    hiddenMenuNm.value = list[i].menuNm;
				    row.appendChild(hiddenMenuNm);
				
				    const hiddenMenuId = document.createElement('input');
				    hiddenMenuId.type = 'hidden';
				    hiddenMenuId.name = 'menuId';
				    hiddenMenuId.value = list[i].menuId;
				    row.appendChild(hiddenMenuId);
				
				    // 데이터 셀 추가
				    const menuNmCell = document.createElement('td');
				    menuNmCell.textContent = list[i].menuNm;
				    row.appendChild(menuNmCell);
				
				    const menuIdCell = document.createElement('td');
				    menuIdCell.textContent = list[i].menuId;
				    row.appendChild(menuIdCell);
				
				    const menuUrlCell = document.createElement('td');
				    menuUrlCell.textContent = list[i].menuUrl; 
				    row.appendChild(menuUrlCell);
				
				    const menuDepthCell = document.createElement('td');
				    menuDepthCell.textContent = list[i].menuDepth; 
				    row.appendChild(menuDepthCell);
				
				    const useYnCell = document.createElement('td');
				    useYnCell.textContent = list[i].useYn; 
				    row.appendChild(useYnCell);
				
				    // Radio 버튼 추가
				    const radioCell = document.createElement('td');
				    const radioInput = document.createElement('input');
				    radioInput.type = 'radio';
				    radioInput.name = 'select';
				    radioInput.value = list[i].menuId;
				    radioCell.appendChild(radioInput);
				    row.appendChild(radioCell);
					 // 테이블에 행 추가
					menu_list.appendChild(row);
				}
	
	        	/*for ( var i = 0 ; i < list.length ; i++ ) {
	        		html += '<tr>';
					html += '		<input type="hidden" name="menuNm" value="' + list[i].menuNm + '" />';
					html += '		<input type="hidden" name="menuId" value="' + list[i].menuId + '" />';
					html += '	<td>' + list[i].menuNm + '</td>';
					html += '	<td>' + list[i].menuId + '</td>';
					html += '	<td>' + list[i].menuUrl + '</td>';
					html += '	<td>' + list[i].menuOrder + '</td>';
					html += '	<td>' + list[i].useYn + '</td>';
					html += '	<td>';
					html += '		<input type="radio" name="select" value="' + list[i].menuId + '" />';
					html += '	</td>';
					html += '</tr>';
	        	}*/
	        	
        	} else {
				const row = document.createElement('tr');
				const cell = document.createElement('td');
				// 속성 설정
				cell.colSpan = 6; // colspan 속성 설정
				cell.textContent = '검색 결과가 없습니다.';
				row.appendChild(cell);
				 // 테이블에 행 추가
			menu_list.appendChild(row);
				
        	}
			
		},
		error:function(x,e){
			alert(x, e);
		}
	});
});

//팝업에서 메뉴 선택
$("#btn_select_popup").click(function(){
		var up_menu_nm = $("input:radio[name='select']:checked").closest('tr').find("input[name='menuNm']").val();
		var up_menu_id = $("input:radio[name='select']:checked").closest('tr').find("input[name='menuId']").val();
		opener.document.getElementById("up_menu_nm").value = up_menu_nm;
		opener.document.getElementById("up_menu_id").value = up_menu_id;
		self.close();
	});

// 최상위 메뉴 버튼 클릭
$("#btn_top_menu").click(function(){
	$("#up_menu_nm").val("");
	$("#up_menu_id").val("");
	$("#menu_url").focus();
	radio_toggle("Y");
});

//메뉴 등록
$("#submitBtn").click(function(){
	// 최상위 메뉴 선택 여부
	let top_menu_yn = $("#top_menu_yn").val();
	//관리자/사용자
	let menu_type =  $("input:radio[name='menu_type']:checked").val();
	//상위메뉴
	let up_menu_id = $("#up_menu_id").val();
	//메뉴 url
	let menu_url = $("#menu_url").val();
	let full_menu_url;
	let menu_id;
	
	//최상위 메뉴 일경우 (메뉴 depth 1)
	if(top_menu_yn == 'Y'){
	  full_menu_url = "/" + menu_type + "/" + menu_url;
	//상위메뉴 값이 존재하지 않기때문에 메뉴로 id 생성
	  menu_id = menu_url; 
	//최상위 메뉴 아닐경우 (메뉴 depth 2 이상)
	}else if(top_menu_yn == 'N'){
	  full_menu_url = "/" + menu_type + "/" + up_menu_id + "/" + menu_url;
		 

	//상위메뉴 값이 존재하기 때문에 상위메뉴_숫자식으로 id 생성 
	  menu_id = up_menu_id; 
	}
	
	console.log(menu_url);	  
		console.log(full_menu_url);	 
	
	$("#menu_id").val(menu_id);
	$("#menu_url").val(full_menu_url);
	
	if(confirm("등록하시겠습니까?")){
	 $('#menu_form').submit();
	}
});

 // 노드 선택 시 이벤트 핸들러
   $('#menu_tree').on('select_node.jstree', function (e, data) {
        // 선택한 노드의 텍스트와 ID를 가져오기
		var menu = data.node.original;
		var menu_id = menu.id;
        var menu_nm = menu.text;
        var up_menu_id = menu.parent;
        var up_menu_nm = menu.up_menu_nm;
        var menu_type = menu.menu_type;
        var menu_url = menu.menu_url;
        var use_yn = menu.use_yn;
        var menu_depth = menu.menu_depth;
        var menu_order = menu.menu_order;
        var admin_allow = menu.admin_allow;
        var manage_allow = menu.manage_allow;
        var user_allow = menu.user_allow;
		console.log(user_allow);
        // 정보를 input 필드에 설정
		if (menu_type == "admin") {
            $('#menu_type_admin').prop('checked', true);
            $('#menu_type_user').prop('checked', false);
        } else {
            $('#menu_type_user').prop('checked', true);
            $('#menu_type_admin').prop('checked', false);
        }
		
		    $('#menu_id').val(menu_id);
	        $('#up_menu_id').val(up_menu_id);
	        $('#up_menu_nm').val(up_menu_nm);
	        $('#menu_url').val(menu_url);
	        $('#menu_nm').val(menu_nm);
		
		if (use_yn == "Y") {
            $('#use_yn_y').prop('checked', true);
            $('#use_yn_n').prop('checked', false);
        } else {
            $('#use_yn_n').prop('checked', true);
            $('#use_yn_y').prop('checked', false);
        }

		if (admin_allow == "1") {
            $('#admin_allow_1').prop('checked', true);
            $('#admin_allow_2').prop('checked', false);
            $('#admin_allow_3').prop('checked', false);
        } else if(admin_allow == "2") {
            $('#admin_allow_1').prop('checked', false);
            $('#admin_allow_2').prop('checked', true);
            $('#admin_allow_3').prop('checked', false);
        }else{
			$('#admin_allow_1').prop('checked', false);
            $('#admin_allow_2').prop('checked', false);
            $('#admin_allow_3').prop('checked', true);
		}
		
		if (manage_allow == "1") {
            $('#manage_allow_1').prop('checked', true);
            $('#manage_allow_2').prop('checked', false);
            $('#manage_allow_3').prop('checked', false);
        } else if(manage_allow == "2") {
            $('#manage_allow_1').prop('checked', false);
            $('#manage_allow_2').prop('checked', true);
            $('#manage_allow_3').prop('checked', false);
        }else{
			$('#manage_allow_1').prop('checked', false);
            $('#manage_allow_2').prop('checked', false);
            $('#manage_allow_3').prop('checked', true);
		}
		
		if (user_allow == "1") {
            $('#user_allow_1').prop('checked', true);
            $('#user_allow_2').prop('checked', false);
            $('#user_allow_3').prop('checked', false);
        } else if(user_allow == "2") {
            $('#user_allow_1').prop('checked', false);
            $('#user_allow_2').prop('checked', true);
            $('#user_allow_3').prop('checked', false);
        }else{
			$('#user_allow_1').prop('checked', false);
            $('#user_allow_2').prop('checked', false);
            $('#user_allow_3').prop('checked', true);
		}
		
      });


});	
//전체 메뉴목록 불러오기
function getMenuTree(menuType){
	$.ajax({
		type: "get",
		url: "/admin/menu/search_menu_list.do",
		data: {menu_type: menuType},
		dataType: "json",
		beforeSend : function(xhr){
       	 $('#menu_tree').jstree("destroy").empty();
		},
		success: function(data) {
			console.log(data);
			 var menuData = data.map(function(item) {
                return {
                    id: item.menuId,
                    text: item.menuNm,
                    parent: item.upMenuId || "#", // 부모가 없으면 루트 노드로 설정
                    up_menu_nm: item.upMenuNm || "#", // 부모가 없으면 루트 노드로 설정
                    menu_type: item.menuType,
                    menu_url: item.menuUrl,
                    menu_depth: item.menuDepth,
                    menu_order: item.menuOrder,
                    use_yn: item.useYn,
                    admin_allow: item.adminAllow,
                    manage_allow: item.manageAllow, 
                    user_allow: item.userAllow
                };
            });
			
			// jstree 초기화 및 데이터 설정
            $('#menu_tree').jstree({
                'core': {
                    'data': menuData, // 서버에서 받은 데이터를 설정
                    'themes': {
                        'name': 'default',
                        'dots': true, // 점 스타일 활성화
                        'icons': true // 아이콘 활성화
                    },
					"check_callback" : true
                },
                plugins: ['checkbox', 'contextmenu', 'search', 'state', 'types', 'dnd'],
				 checkbox: { //단일체크 설정
			    tie_selection: true, // 선택과 체크를 동일하게 처리
			    whole_node: false    // 노드 전체 클릭 시 체크박스와 분리
			  },
/*				contextmenu: {
			    items: function ($node) { // 메뉴 항목 정의
			      return {
			        create: {
			          label: "Add Node", // 메뉴 항목 이름
			          action: function (obj) {
			            var newNode = $('#tree').jstree(true).create_node($node, {
			              text: "New Node"
			            });
			            if (newNode) {
			              $('#tree').jstree('edit', newNode); // 노드 편집 모드 활성화
			            }
			          }
			        },
			        rename: {
			          label: "Rename Node",
			          action: function (obj) {
			            $('#tree').jstree(true).edit($node); // 선택한 노드 편집
			          }
			        },
			        delete: {
			          label: "Delete Node",
			          action: function (obj) {
			            $('#tree').jstree(true).delete_node($node); // 선택한 노드 삭제
			          }
			        }
			      };
			    }
				}
*/            });
        },
        error: function(xhr, status, error) {
            console.error("Error while fetching menu data:", error);
        }
	});
}

//최상위 메뉴와 아닐때의 라디오 제어
function radio_toggle(menu_yn){
	$('input[name="menu_depth"]').each(function() {
		let menu_depth_value  = $(this).val();
		if(menu_yn == 'Y'){
			$("#top_menu_yn").val("Y");
			if(menu_depth_value != 1){
				$(this).prop('disabled', true);
			}else{
				$(this).prop('disabled', false);
			}
		}else if(menu_yn == 'N'){
			$("#top_menu_yn").val("N");
			if(menu_depth_value != 1){
				$(this).prop('disabled', false);
			}else{
				$(this).prop('disabled', true);
			}
		}	
	});
}


