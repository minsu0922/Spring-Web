package iancms.domain.admin.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.ResponseBody;
import com.google.gson.Gson;

import iancms.domain.admin.menu.vo.menuDto;
import iancms.domain.user.common.service.commonService;
import iancms.domain.admin.menu.service.menuService;
import iancms.domain.user.common.vo.atchFileDto;
import iancms.domain.user.common.vo.commonDto;
import iancms.domain.user.common.vo.customUser;
import iancms.domain.user.common.vo.defaultVO;
import iancms.domain.user.common.vo.loginDto;
import iancms.domain.user.sample.service.EgovSampleService;
import iancms.domain.user.sample.vo.SampleDefaultVO;
import iancms.global.common.baseController;
import iancms.global.common.pageVO;
import iancms.global.util.FileUtility;
import iancms.global.util.PageUtility;

@Controller
@RequestMapping(value="/admin")
public class mainController extends baseController {
	
	@Autowired
	private EgovSampleService sampleService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Autowired
	private commonService commonService;
	
	@Autowired
	private menuService menuService;
	
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String main(HttpServletRequest request, @ModelAttribute("searchVO") SampleDefaultVO searchVO, @ModelAttribute("defaultVO") defaultVO defaultVO, commonDto dto, menuDto menu, Model model) throws Exception {
		customUser user = super.getCustomUser();
		
		HttpSession session = request.getSession();
		loginDto user2 = (loginDto) session.getAttribute("user");
		String userIp = (String) session.getAttribute("userIp");
		
		// 등록된 메뉴 정보 조회
		List<menuDto> list = menuService.select_menu_list(menu);
					
 		// 페이징
		int totCnt = sampleService.selectSampleListTotCnt(searchVO);
		// 파일 경로를 가져온다.
		
		/** EgovPropertyService.sample */
		/*
		 * defaultVO.setPagePerPageCnt(propertiesService.getInt("pageUnit"));
		 * defaultVO.setPageTotCnt(propertiesService.getInt("pageSize"));
		 */
		
		PageUtility.paging(defaultVO, totCnt, model); 
		
		/** pageing setting */
		/*
		 * PaginationInfo paginationInfo = new PaginationInfo();
		 * paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		 * paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		 * paginationInfo.setPageSize(searchVO.getPageSize());
		 * 
		 * searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		 * searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		 * searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		 * 
		 * 
		 * paginationInfo.setTotalRecordCount(totCnt);
		 * model.addAttribute("paginationInfo", paginationInfo);
		 */
		
		List<?> sampleList2 = commonService.selectSample(dto);
		  model.addAttribute("resultList", sampleList2);
		  model.addAttribute("menu_list", list);
		
		return "admin/main";
	}

}
