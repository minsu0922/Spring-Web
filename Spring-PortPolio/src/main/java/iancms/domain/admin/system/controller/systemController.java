package iancms.domain.admin.system.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import iancms.domain.admin.system.service.systemService;
import iancms.domain.admin.system.vo.systemDto;
import iancms.domain.user.common.vo.atchFileDto;
import iancms.domain.user.sample.vo.SampleDefaultVO;
import iancms.global.common.baseController;
import iancms.global.util.FileUtility;

@Controller
@RequestMapping(value="/admin/system/")
public class systemController {
	
	@Autowired
	private systemService systemService;
	
	@Autowired
    private FileUtility fileUtility;
	
	// 사이트관리 리스트(공통코드)
	@RequestMapping(value = "/com_cd_list.do", method = RequestMethod.GET)
	public String comCdList(@ModelAttribute("searchVO") SampleDefaultVO searchVO, systemDto dto, atchFileDto vo,
			Model model) throws Exception {
		System.out.println("test");
		List<systemDto> comCdList = systemService.comCdList(dto);
		List<atchFileDto> atchFileList = fileUtility.atchFileList(vo);
		model.addAttribute("comCdList", comCdList);
		model.addAttribute("atchFileList", atchFileList);
		return "common/com_cd";
	}

	// 사이트관리 공통코드 등록
	@RequestMapping(value = "/com_cd_insert.do", method = RequestMethod.POST)
	public String comCdInsert(@ModelAttribute("formCd") systemDto dto, RedirectAttributes attr) throws Exception {

		String msg = "";
		int result = systemService.comCdInsert(dto);

		if (result > 0) {
			msg = "코드등록 완료";
		} else {
			msg = "코드등록 실패";
		}
		attr.addFlashAttribute("msg", msg);
		return "redirect:/admin/system/com_cd_list.do";
	}

	// 사이트관리 공통코드 수정
	@RequestMapping(value = "/com_cd_update.do", method = RequestMethod.POST)
	public String comCdUpdate(@ModelAttribute("updateForm") systemDto dto, RedirectAttributes attr) throws Exception {

		String msg = "";
		int result = systemService.comCdUpdate(dto);

		if (result > 0) {
			msg = "코드수정 완료";
		} else {
			msg = "코드수정 실패";
		}
		attr.addFlashAttribute("msg", msg);
		return "redirect:/admin/system/com_cd_list.do";
	}

	// 사이트관리 공통코드 삭제
	@RequestMapping(value = "/com_cd_delete.do")
	public String comCdDelete(@RequestParam("com_cd_sn") String com_cd_sn, RedirectAttributes attr) throws Exception {

		String msg = "";
		int result = systemService.comCdDelete(com_cd_sn);

		if (result > 0) {
			msg = "코드삭제 완료";
		} else {
			msg = "코드삭제 실패";
		}
		attr.addFlashAttribute("msg", msg);
		return "redirect:/admin/system/com_cd_list.do";
	}

	// 사이트관리 상세리스트(공통코드)
	@RequestMapping(value = "/com_cd_dtl.do", method = RequestMethod.GET)
	@ResponseBody
	public String comCdDtlList(@RequestParam("com_cd_sn") String com_cd_sn) throws Exception {
		List<systemDto> comCdDtlList = systemService.comCdDtlList(com_cd_sn);
		String jsonStr = new Gson().toJson(comCdDtlList);
		return jsonStr;
	}

	// 사이트관리 공통코드상세 등록
	@RequestMapping(value = "/com_cd_dtl_insert.do", method = RequestMethod.POST)
	public String comCdDtlInsert(@ModelAttribute("goDetail") systemDto dto, RedirectAttributes attr) throws Exception {

		String msg = "";
		int result = systemService.comCdDtlInsert(dto);

		if (result > 0) {
			msg = "상세코드등록 완료";
		} else {
			msg = "상세코드등록 실패";
		}
		attr.addFlashAttribute("msg", msg);
		return "redirect:/admin/system/com_cd_list.do";
	}
	
	// 사이트관리 상세코드 수정
	@RequestMapping(value = "/com_cd_dtl_update.do")
	public String comCdDtlUpdate(@ModelAttribute("goUpdate") systemDto dto, RedirectAttributes attr) throws Exception {
		
		String msg = "";
		int result = systemService.comCdDtlUpdate(dto);
		
		if (result > 0) {
			msg = "상세코드수정 완료";
		} else {
			msg = "상세코드수정 실패";
		}
		attr.addFlashAttribute("msg", msg);
		return "redirect:/admin/system/com_cd_list.do";
	}
	
	// 사이트관리 상세코드 삭제
	@RequestMapping(value = "/com_cd_dtl_delete.do")
	public String comCdDtlDelete(@RequestParam("com_cd_dtl_sn") String com_cd_dtl_sn, RedirectAttributes attr) throws Exception {

		String msg = "";
		int result = systemService.comCdDtlDelete(com_cd_dtl_sn);

		if (result > 0) {
			msg = "코드삭제 완료";
		} else {
			msg = "코드삭제 실패";
		}
		attr.addFlashAttribute("msg", msg);
		return "redirect:/admin/system/com_cd_list.do";
	}

}
