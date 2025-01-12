package iancms.domain.admin.menu.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.google.gson.Gson;

import iancms.domain.admin.menu.service.menuService;
import iancms.domain.admin.menu.vo.menuDto;
import iancms.domain.user.common.service.commonService;
import iancms.domain.user.common.vo.customUser;
import iancms.global.common.baseController;

@Controller
@RequestMapping(value="/admin/menu/")
public class menuController {
	
	@Autowired
	private commonService commonService;
	
	@Autowired
	private menuService menuService;
	
	// 메뉴 리스트
	@RequestMapping(value = "/menu_list.do", method = RequestMethod.GET)
	public String menu_list(menuDto dto, Model model) throws Exception {

		return "/admin/menu/menu_list";
	}
	
	// 메뉴 등록
	@RequestMapping(value = "/menu_list_insert.do", method = RequestMethod.POST)
	public String menu_list_insert(menuDto dto, Model model) throws Exception {
		
		int result = menuService.insert_menu_list(dto);
		
		return "redirect:/admin/menu/menu_list.do";
	}
	
	/**
     * 메뉴 선택 팝업
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/menu_list_popup.do" , method=RequestMethod.GET)
    public String menu_list_popup (menuDto dto, Model model) throws Exception {
        // 등록된 메뉴 정보 조회
        List<menuDto> list = menuService.select_menu_list(dto);
        
        return "admin/menu/menu_list_popup.popup";
    }
	
    /**
     * 메뉴 검색
     * @param model
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value="/search_menu_list.do", method=RequestMethod.GET)
    public String search_menu_list(menuDto dto, Model model) throws Exception {     
    	 // 등록된 메뉴 정보 조회
        List<menuDto> list = menuService.select_menu_list(dto);

        String jsonStr = new Gson().toJson(list);
        return jsonStr ;
    }
    
	
}
