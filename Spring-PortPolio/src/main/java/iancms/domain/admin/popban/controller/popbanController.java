package iancms.domain.admin.popban.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import iancms.domain.admin.popban.vo.bannerDto;
import iancms.domain.admin.popban.vo.mainSlideDto;
import iancms.domain.admin.popban.vo.popupDto;
import iancms.domain.user.common.vo.atchFileDto;
import iancms.global.common.baseController;
import iancms.global.util.FileUtility;
import iancms.domain.admin.popban.service.*;

@Controller
@RequestMapping(value="/admin/popban/")
public class popbanController {
	
		@Autowired
	    private popbanService popbanService; 
	
		@Autowired
	    private FileUtility fileUtility; // fileUtility 의존성 추가

	    // 메인 슬라이드 조회 화면
	    @RequestMapping(value = "/mainslide_list.do")
	    public String mainSlideList(@ModelAttribute("formMainSlide") mainSlideDto dto, Model model) throws Exception {
	        // 메인 슬라이드 목록 조회
	        List<mainSlideDto> mainSlides = popbanService.mainSlideList(dto);
	        model.addAttribute("mainSlides", mainSlides);
	        model.addAttribute("mainSlideDto", dto);

	        // 전체 메인 슬라이드 건수 조회
	        int mainSlideCount = mainSlides.size();
	        model.addAttribute("mainSlideCount", mainSlideCount);

	        return "admin/popban/mainSlideList";
	    }
		
		// 메인 슬라이드 상세 화면
		@RequestMapping(value = "/mainslide_info.do", method = RequestMethod.POST)
		public String mainSlideInfo(@ModelAttribute("formMainSlide")mainSlideDto dto, Model model) throws Exception {
			mainSlideDto mainSlideInfo = popbanService.mainSlideInfo(dto);
			model.addAttribute("mainSlideInfo", mainSlideInfo);
			model.addAttribute("mainSlideDto", dto);
			
	        // atchFileDto 생성 및 파일 조회
	        atchFileDto fileDto = new atchFileDto();

	        // 파일 목록 조회
	        List<atchFileDto> atchFileList = fileUtility.atchFileList(fileDto);
	        model.addAttribute("atchFileList", atchFileList);
			
			return "admin/popban/mainSlideInfo";
		}
		
		
		// 메인 슬라이드 등록화면
		@RequestMapping(value = "/mainslide_regist.do", method = RequestMethod.GET)
		public String mainSlideRegist(@ModelAttribute("formMainSlide")mainSlideDto dto, Model model) throws Exception {
			return "admin/popban/mainSlideRegist";
		}
		
		/*
		 * // 메인 슬라이드 등록하기
		 * 
		 * @RequestMapping(value = "/mainslide_registproc.do", method =
		 * RequestMethod.POST) public String
		 * mainSlideRegist_proc(@ModelAttribute("formMainSlide")mainSlideDto dto, Model
		 * model, RedirectAttributes attr) throws Exception { String msg=""; int result
		 * = popbanService.mainSlideRegist(dto); if(result > 0) { msg = "저장이 완료되었습니다.";
		 * }else { msg = "저장에 실패하였습니다."; } attr.addFlashAttribute("msg", msg);
		 * 
		 * return "redirect:/admin/popban/mainslide_list.do"; }
		 * 
		 * //파일 업로드
		 * 
		 * @RequestMapping(value = "/file_upload.do", method = RequestMethod.POST)
		 * public String fileUpload(MultipartHttpServletRequest multiRequest, Model
		 * model, RedirectAttributes attr) throws Exception{
		 * 
		 * String msg=""; List<MultipartFile> list = multiRequest.getFiles("file"); if
		 * (list.get(0).getSize() > 0) { fileUtility.fileUpload(multiRequest); msg =
		 * "업로드 완료"; } else { msg = "업로드 파일 없음"; } attr.addFlashAttribute("msg", msg);
		 * return "redirect:/common/com_cd_list.do"; }
		 */
		
		@RequestMapping(value = "/mainslide_registproc.do", method = RequestMethod.POST)
		public String mainSlideRegist_proc(@ModelAttribute("formMainSlide") mainSlideDto dto,
		                                   MultipartHttpServletRequest multiRequest,
		                                   RedirectAttributes attr) {
		    
		    String msg="";

		    try {
		        fileUtility.fileUpload(multiRequest); // MultipartHttpServletRequest 전체 전달
		        int result = popbanService.mainSlideRegist(dto);
		        msg = (result > 0) ? "등록 완료했습니다." : "등록에 실패하였습니다.";
		    } catch (Exception e) {
		        msg = "오류 발생: " + e.getMessage();
		        e.printStackTrace();
		    }

		    attr.addFlashAttribute("msg", msg);

		    return "redirect:/admin/popban/mainslide_list.do";
		}



		// 메인 슬라이드 수정
		@RequestMapping(value = "/mainslide_update.do", method = RequestMethod.POST)
		public String mainSlideUpdate(@ModelAttribute("formMainSlide")mainSlideDto dto, Model model, RedirectAttributes attr) throws Exception {

			String msg="";
			int result = popbanService.mainSlideUpdate(dto);
			if(result > 0) {
				msg = "저장이 완료되었습니다.";
			}else {
				msg = "저장에 실패하였습니다.";
			}
			attr.addFlashAttribute("msg", msg);
			return "redirect:/admin/popban/mainslide_list.do";
		}
		
		// 메인 슬라이드 삭제
		@RequestMapping(value = "/mainslide_delete.do", method = RequestMethod.POST)
		public String mainSlideDelete(@RequestParam("popban_sn") String popban_sn, Model model, RedirectAttributes attr) throws Exception {
			String msg="";
			
			int result = popbanService.mainSlideDelete(popban_sn);
			if(result > 0) {
				msg="삭제가 완료되었습니다.";
			}else {
				msg="삭제에 실패하였습니다.";
			}
			attr.addFlashAttribute("msg", msg);
			return "redirect:/admin/popban/mainslide_list.do";
		}
		
		//////////////////////////////////////////////////////////////////
		
		 // 팝업 조회 화면
	    @RequestMapping(value = "/popup_list.do", method = RequestMethod.GET)
	    public String popupList(@ModelAttribute("formPopup") popupDto dto, Model model) throws Exception {
	        List<popupDto> popups = popbanService.popupList(dto);
	        model.addAttribute("popups", popups);
	        model.addAttribute("popupDto", dto);
	        
	        // 전체 팝업 건수 조회
	        int popupCount = popups.size();
	        model.addAttribute("popupCount", popupCount);
	        
	        return "admin/popban/popupList";
	    }
	    
	    // 팝업 상세 화면
	    @RequestMapping(value = "/popup_info.do", method = RequestMethod.POST)
	    public String popupInfo(@ModelAttribute("formPopup") popupDto dto, Model model) throws Exception {
	        popupDto popupInfo = popbanService.popupInfo(dto);
	        model.addAttribute("popupInfo", popupInfo);
	        model.addAttribute("popupDto", dto);
	        
	        // atchFileDto 생성 및 파일 조회
	        atchFileDto fileDto = new atchFileDto();

	        // 파일 목록 조회
	        List<atchFileDto> atchFileList = fileUtility.atchFileList(fileDto);
	        model.addAttribute("atchFileList", atchFileList);
	        
	        return "admin/popban/popupInfo";
	    }
	    
	    // 팝업 등록화면
		@RequestMapping(value = "/popup_regist.do", method = RequestMethod.GET)
		public String popupRegist(@ModelAttribute("formPopup")popupDto dto, Model model) throws Exception {
			return "admin/popban/popupRegist";
		}
		
		// 팝업 등록하기
		@RequestMapping(value = "/popup_registproc.do", method = RequestMethod.POST)
		public String popupRegist_proc(@ModelAttribute("formPopup")popupDto dto, Model model, RedirectAttributes attr) throws Exception {
			String msg="";
			int result = popbanService.popupRegist(dto);
			if(result > 0) {
				msg = "저장이 완료되었습니다.";
			}else {
				msg = "저장에 실패하였습니다.";
			}
			attr.addFlashAttribute("msg", msg);
			
			return "redirect:/admin/popban/popup_list.do";
		}
		
	    
	    // 팝업 수정
	    @RequestMapping(value = "/popup_update.do", method = RequestMethod.POST)
	    public String popupUpdate(@ModelAttribute("formPopup") popupDto dto, Model model, RedirectAttributes attr) throws Exception {

	        String msg="";
	        int result = popbanService.popupUpdate(dto);
	        if(result > 0) {
	            msg = "저장이 완료되었습니다.";
	        } else {
	            msg = "저장에 실패하였습니다.";
	        }
	        attr.addFlashAttribute("msg", msg);
	        return "redirect:/admin/popban/popup_list.do";
	    }
	    
	    // 팝업 삭제
	    @RequestMapping(value = "/popup_delete.do", method = RequestMethod.POST)
	    public String popupDelete(@RequestParam("popban_sn") String popban_sn, Model model, RedirectAttributes attr) throws Exception {
	        String msg="";
	        
	        int result = popbanService.popupDelete(popban_sn);
	        if(result > 0) {
	            msg="삭제가 완료되었습니다.";
	        } else {
	            msg="삭제에 실패하였습니다.";
	        }
	        attr.addFlashAttribute("msg", msg);
	        return "redirect:/admin/popban/popup_list.do";
	    }
	    
	    //////////////////////////////////////////////////////////////////
	    
	 // 배너 조회 화면
	    @RequestMapping(value = "/banner_list.do", method = RequestMethod.GET)
	    public String bannerList(@ModelAttribute("formBanner") bannerDto dto, Model model) throws Exception {
	        List<bannerDto> banners = popbanService.bannerList(dto);
	        model.addAttribute("banners", banners);
	        model.addAttribute("bannerDto", dto);
	        
	        // 전체 배너 건수 조회
	        int bannerCount = banners.size();
	        model.addAttribute("bannerCount", bannerCount);
	        
	        return "admin/popban/bannerList";
	    }
	    
	    // 배너 상세 화면
	    @RequestMapping(value = "/banner_info.do", method = RequestMethod.POST)
	    public String bannerInfo(@ModelAttribute("formBanner") bannerDto dto, Model model) throws Exception {
	        bannerDto bannerInfo = popbanService.bannerInfo(dto);
	        model.addAttribute("bannerInfo", bannerInfo);
	        model.addAttribute("bannerDto", dto);
	        
	        // atchFileDto 생성 및 파일 조회
	        atchFileDto fileDto = new atchFileDto();

	        // 파일 목록 조회
	        List<atchFileDto> atchFileList = fileUtility.atchFileList(fileDto);
	        model.addAttribute("atchFileList", atchFileList);
	        
	        return "admin/popban/bannerInfo";
	    }
	    
	    // 배너 등록화면
		@RequestMapping(value = "/banner_regist.do", method = RequestMethod.GET)
		public String bannerRegist(@ModelAttribute("formBanner")bannerDto dto, Model model) throws Exception {
			return "admin/popban/bannerRegist";
		}
		
		// 배너 등록하기
		@RequestMapping(value = "/banner_registproc.do", method = RequestMethod.POST)
		public String bannerRegist_proc(@ModelAttribute("formBanner")bannerDto dto, Model model, RedirectAttributes attr) throws Exception {
			String msg="";
			int result = popbanService.bannerRegist(dto);
			if(result > 0) {
				msg = "저장이 완료되었습니다.";
			}else {
				msg = "저장에 실패하였습니다.";
			}
			attr.addFlashAttribute("msg", msg);
			
			return "redirect:/admin/popban/banner_list.do";
		}
	    
	    // 배너 수정
	    @RequestMapping(value = "/banner_update.do", method = RequestMethod.POST)
	    public String bannerUpdate(@ModelAttribute("formBanner") bannerDto dto, Model model, RedirectAttributes attr) throws Exception {

	        String msg = "";
	        int result = popbanService.bannerUpdate(dto);
	        if(result > 0) {
	            msg = "저장이 완료되었습니다.";
	        } else {
	            msg = "저장에 실패하였습니다.";
	        }
	        attr.addFlashAttribute("msg", msg);
	        return "redirect:/admin/popban/banner_list.do";
	    }
	    
	    // 배너 삭제
	    @RequestMapping(value = "/banner_delete.do", method = RequestMethod.POST)
	    public String bannerDelete(@RequestParam("banner_sn") String banner_sn, Model model, RedirectAttributes attr) throws Exception {
	        String msg = "";
	        
	        int result = popbanService.bannerDelete(banner_sn);
	        if(result > 0) {
	            msg = "삭제가 완료되었습니다.";
	        } else {
	            msg = "삭제에 실패하였습니다.";
	        }
	        attr.addFlashAttribute("msg", msg);
	        return "redirect:/admin/popban/banner_list.do";
	    }
}
