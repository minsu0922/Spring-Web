package iancms.domain.admin.menu.service;

import java.util.List;
import java.util.Map;

import iancms.domain.admin.menu.vo.menuDto;

public interface menuService {
	int insert_menu_list(menuDto dto) throws Exception;
	List<menuDto> select_menu_list(menuDto dto) throws Exception; //메뉴 가져오기
	menuDto select_menu_url(String url) throws Exception; //메뉴url과 일치하는 메뉴 가져오기(1개)
}
