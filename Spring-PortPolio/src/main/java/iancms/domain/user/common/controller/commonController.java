package iancms.domain.user.common.controller;

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

import iancms.domain.user.common.service.commonService;
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
@RequestMapping(value="/common/")
public class commonController extends baseController {
	
	@Autowired
	private EgovSampleService sampleService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Autowired
	private commonService commonService;
	
	@Autowired
    private FileUtility fileUtility;
	
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String main(HttpServletRequest request, @ModelAttribute("searchVO") SampleDefaultVO searchVO, @ModelAttribute("defaultVO") defaultVO defaultVO, commonDto dto, Model model) throws Exception {
		customUser user = super.getCustomUser();
		
		HttpSession session = request.getSession();
		loginDto user2 = (loginDto) session.getAttribute("user");
		String userIp = (String) session.getAttribute("userIp");
		
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
		 
		
		return "user/sample/egovSampleList";
	}
	
	// 로그인 화면	
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String login(HttpSession session , commonDto dto, Model model) throws Exception {
		
		// 세션에서 에러 메시지 가져오기
        String errorMessage = (String) session.getAttribute("errorMessage");
		model.addAttribute("msg", errorMessage);
		return "common/login.main";
	}

	
	 // 로그인
		
		/*
		 * @RequestMapping(value = "/loginProcess.do", method =RequestMethod.POST)
		 * public String loginProcess(@ModelAttribute("searchVO")SampleDefaultVO
		 * searchVO, loginDto dto, Model model, RedirectAttributes rttr) throws
		 * Exception {
		 * 
		 * loginDto check = commonService.loginUser(dto);
		 * 
		 * if(check != null) { return "redirect:/common/main.do"; }else {
		 * rttr.addFlashAttribute("msg", "로그인을 실패했습니다."); return
		 * "redirect:/common/login.do"; }
		 * 
		 * }
		 */
		 
		 
	 
	  // 회원가입
	  @RequestMapping(value = "/sign_up.do", method = RequestMethod.GET)
		public String sign_up(@ModelAttribute("searchVO") SampleDefaultVO searchVO, commonDto dto, Model model) throws Exception {
			
			/*
			 * List<?> sampleList1 = sampleService.selectSampleList(searchVO);
			 * model.addAttribute("resultList", sampleList1);
			 */
			
			System.out.println("test");
			
			 List<?> sampleList2 = commonService.selectSample(dto);
			  model.addAttribute("resultList", sampleList2);
			 
			
			return "common/sign_up";
		}
	  
	  
	  
	  //아이디 중복체크
		@RequestMapping(value= "/chkUserId.do" , method = RequestMethod.GET)
		@ResponseBody
		public String chkUserId(@RequestParam("user_id") String user_id) throws Exception {
			
			int result = commonService.chkUserId(user_id);
			
			String jsonStr = new Gson().toJson(result);
			
			return jsonStr;
		}
	  
	  // 회원가입
	  @RequestMapping(value = "/sign_up.do", method = RequestMethod.POST)
		public String sign_up_Process(@ModelAttribute("searchVO") SampleDefaultVO searchVO, loginDto dto, commonDto commonDto, Model model) throws Exception {
			int result = commonService.sign_up_User(dto);
			
			return "redirect:/common/login.do";
		}
	  
	  //파일 업로드
	  @RequestMapping(value = "/file_upload.do", method = RequestMethod.POST)
	  public String fileUpload(MultipartHttpServletRequest multiRequest, Model model, RedirectAttributes attr) throws Exception{
	       
		  String msg="";
		  List<MultipartFile> list = multiRequest.getFiles("file");
		  if (list.get(0).getSize() > 0) {
			fileUtility.fileUpload(multiRequest);
			msg = "업로드 완료";
		  } else {
			msg = "업로드 파일 없음";
		  }
		  attr.addFlashAttribute("msg", msg);
		  return "redirect:/admin/system/com_cd_list.do";
	  }
	  
	  //파일 다운로드
	  @RequestMapping(value = "/file_download.do")
	  public void fileDownload(HttpServletRequest request, HttpServletResponse response, atchFileDto dto, RedirectAttributes attr) throws Exception{
		  String msg="";
		  String result = fileUtility.fileDownload(request, response, dto);
		  if(result.equals("no")) {
			  msg = "다운로드 파일 없음";  
			  attr.addFlashAttribute("msg", msg);
		  }
		  //return "redirect:/admin/system/com_cd_list.do";
	  }
	  
	  //파일 삭제
	  @RequestMapping(value = "/file_delete.do")
	  public String fileDelete(@RequestParam("atch_id") String atch_id, RedirectAttributes attr) throws Exception{
		  String msg="삭제완";
		  fileUtility.fileDelete(atch_id);
		  attr.addFlashAttribute("msg", msg);
		  return "redirect:/admin/system/com_cd_list.do";
	  }
}
