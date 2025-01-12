package iancms.domain.admin.member.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import iancms.domain.admin.member.service.*;
import iancms.domain.admin.member.vo.memberDto;
import iancms.domain.admin.menu.service.menuService;
import iancms.domain.admin.menu.vo.menuDto;
import iancms.global.common.baseController;

@Controller
@RequestMapping(value="/admin/member/")
public class memberController {
	
	@Autowired
	private memberService memberService; 
	@Autowired
	private menuService menuService;
	
	@RequestMapping(value = "/member_list.do")
	public String memberList(@ModelAttribute("formMember")memberDto dto, menuDto menu,  Model model) throws Exception{
		/*
		 * // 등록된 메뉴 정보 조회 List<menuDto> list = menuService.select_menu_list(menu);
		 * 
		 * model.addAttribute("menu_list", list);
		 */
		
		
		List<memberDto> memberList = memberService.memberList(dto);
		model.addAttribute("memberList", memberList);
		model.addAttribute("memberDto", dto);
		return "admin/member/memberList";
	}
	@RequestMapping(value = "/member_info.do")
	public String memberInfo(@ModelAttribute("formMember")memberDto dto, Model model) throws Exception{
		memberDto memberInfo = memberService.memberInfo(dto);
		model.addAttribute("memberInfo", memberInfo);
		model.addAttribute("memberDto", dto);
		return "admin/member/memberInfo";
	}
	@RequestMapping(value = "/member_pwreset.do")
	public String memberPwreset(@RequestParam("user_id") String user_id, RedirectAttributes attr) throws Exception{
		
		String msg="";
		int result = memberService.memberPwreset(user_id);
		if(result > 0) {
			msg = "비밀번호 초기화 완료";
		}else {
			msg = "비밀번호 초기화 미완료";
		}
		attr.addFlashAttribute("msg", msg);
		return "redirect:/admin/member/member_list.do";
	}
	@RequestMapping(value = "/member_update.do")
	public String memberUpdate(@ModelAttribute("formMember")memberDto dto, RedirectAttributes attr) throws Exception{

		String msg="";
		int result = memberService.memberUpdate(dto);
		if(result > 0) {
			msg = "회원정보 수정완료";
		}else {
			msg = "회원정보 수정실패";
		}
		attr.addFlashAttribute("msg", msg);
		return "redirect:/admin/member/member_list.do";
	}
	@RequestMapping(value = "/member_delete.do")
	public String memberDelete(@RequestParam("user_id") String user_id, RedirectAttributes attr) throws Exception{
		String msg="";
		
		int result = memberService.memberDelete(user_id);
		if(result > 0) {
			msg="회원삭제 완료";
		}else {
			msg="회원삭제 실패";
		}
		attr.addFlashAttribute("msg", msg);
		return "redirect:/admin/member/member_list.do";
	}
}
