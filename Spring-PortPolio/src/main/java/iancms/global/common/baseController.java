package iancms.global.common;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import iancms.domain.admin.menu.service.menuService;
import iancms.domain.admin.menu.vo.menuDto;
import iancms.domain.user.common.vo.commonDto;
import iancms.domain.user.common.vo.customUser;

@ControllerAdvice
public class baseController {

	@Autowired
	private menuService menuService;

	/*	*//**
			 * 세션에 담긴 사용자 정보를 가져온다
			 */
	/*
	 * protected commonDto getUser(HttpServletRequest request) { commonDto user =
	 * (commonDto) request.getSession().getAttribute("user");
	 * 
	 * return user; }
	 * 
	 *//**
		 * 세션에 담긴 접속 IP를 가져온다
		 *//*
			 * protected String getUserIp(HttpServletRequest request) { String userIp =
			 * (String) request.getSession().getAttribute("userIp");
			 * 
			 * return userIp; }
			 */

	/**
	 * 스프링 시큐리티 접속 정보 가져오기
	 */
	@ModelAttribute("CustomUser")
	protected customUser getCustomUser() {
		// 스프링 시큐리티 컨텍스트 로 부터 가져오기
		if (SecurityContextHolder.getContext() != null
				&& SecurityContextHolder.getContext().getAuthentication() != null) {

			if (SecurityContextHolder.getContext().getAuthentication().getPrincipal().getClass()
					.equals(customUser.class)) {
				customUser customUser = (customUser) SecurityContextHolder.getContext().getAuthentication()
						.getPrincipal();
				return customUser;
			}
		}
		return null;
	}

	/**
	 * 헤더,사이드에 넣을 메뉴리스트
	 */
	@ModelAttribute("menu_list")
	protected List<menuDto> menu(HttpServletRequest request, menuDto dto, Model model) throws Exception {
		// 등록된 메뉴 정보 조회
		List<menuDto> list = menuService.select_menu_list(dto);
		model.addAttribute("menu_list", list);

		String now_menu_url = request.getRequestURI();

		// 사이드 메뉴
		menuDto menuDto = menuService.select_menu_url(now_menu_url);
		if (menuDto != null) {
			String menuNm = menuDto.getMenu_nm();
			model.addAttribute("side_menuNm", menuNm);
		}
		return list;
	}
}
