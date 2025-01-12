package iancms.domain.admin.menu.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import iancms.domain.admin.menu.mapper.menuMapper;
import iancms.domain.admin.menu.vo.menuDto;

@Service
public class menuServiceImpl implements menuService{
	
	@Autowired
	private menuMapper menuMapper;

	@Override
	public int insert_menu_list(menuDto dto) throws Exception {
		int result = menuMapper.insert_menu_list(dto);
		return result;
	}

	@Override
	public List<menuDto> select_menu_list(menuDto dto) throws Exception {
		List<menuDto> list = menuMapper.select_menu_list(dto);
		return list;
	}

	@Override
	public menuDto select_menu_url(String url) throws Exception {
		menuDto menuDto = menuMapper.select_menu_url(url);
		return menuDto;
	}
	
}
