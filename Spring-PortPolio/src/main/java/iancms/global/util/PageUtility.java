package iancms.global.util;

import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import iancms.domain.user.common.vo.commonDto;
import iancms.domain.user.common.vo.defaultVO;
import iancms.global.common.pageVO;

/**
 * @ 페이징 관련 util
 */

public class PageUtility {

	public static void paging(defaultVO defaultVO, int totCnt, Model model) {
		
		int currentPage = defaultVO.getCurrentPage(); // 현재 페이지 번호
		int pagePerPageCnt = defaultVO.getRecordPerPageCnt(); // 한 페이지 목록 당 페이지 수
		int recordPerPageCnt = defaultVO.getPagePerPageCnt(); // 한 페이지 당 레코드 수
		int recordTotCnt = totCnt; // 전체 레코드 수
		int pageTotCnt = (int) Math.ceil(recordTotCnt / recordPerPageCnt); // 전체 페이지 수
		int firstPage = defaultVO.getFirstPage(); // 페이지 목록의 첫번째 페이지
		int lastPage = defaultVO.getLastPage(); // 페이지 목록의 마지막 페이지
			
		if (recordTotCnt == 0 || (recordTotCnt % recordPerPageCnt) != 0) {
				pageTotCnt++;
			}
			if (currentPage == 0) {
				currentPage = 1;
			}
			if (currentPage > pageTotCnt) {
				currentPage = pageTotCnt;
			}
		
		pageVO paging = new pageVO();
		paging.setCurrentPage(currentPage);
		paging.setPagePerPageCnt(pagePerPageCnt);
		paging.setRecordPerPageCnt(recordPerPageCnt);
		paging.setRecordTotCnt(recordTotCnt);
		paging.setPageTotCnt(pageTotCnt);
		paging.setFirstPage(firstPage);
		paging.setLastPage(lastPage);
			
		// mav 설정
		model.addAttribute("paging", paging);
		
		// defaultVO 설정 (페이징 sql문에서 사용)
		defaultVO.setCurrentPage(currentPage);
		defaultVO.setRecordPerPageCnt(recordPerPageCnt);

	}

	public static Map<String, Object> paging(Map<String, Object> requestMap, ModelAndView mav) {
		// 페이징 초기 설정
		int currentPage = 1; // 현재 페이지 번호
		int recordPerPageCnt = 10; // 한 페이지 당 레코드 수
		int pagePerPageCnt = 10; // 한 페이지 목록 당 페이지 수
		// 변수
		int recordTotCnt = 0; // 전체 레코드 수
		int pageTotCnt = 1; // 전체 페이지 수

		// 사용자 선택에 따른 페이징 설정
		if (requestMap.get("currentPage") != null) {
			currentPage = Integer.parseInt(String.valueOf(requestMap.get("currentPage")));
		}
		if (requestMap.get("recordPerPageCnt") != null) {
			recordPerPageCnt = Integer.parseInt(String.valueOf(requestMap.get("recordPerPageCnt")));
		}
		if (requestMap.get("pagePerPageCnt") != null) {
			pagePerPageCnt = Integer.parseInt(String.valueOf(requestMap.get("pagePerPageCnt")));
		}
		if (requestMap.get("recordTotCnt") != null) {
			recordTotCnt = Integer.parseInt(String.valueOf(requestMap.get("recordTotCnt")));
			pageTotCnt = (int) Math.ceil(recordTotCnt / recordPerPageCnt);
		}
		if (recordTotCnt == 0 || (recordTotCnt % recordPerPageCnt) != 0) {
			pageTotCnt++;
		}
		if (currentPage == 0) {
			currentPage = 1;
		}
		if (currentPage > pageTotCnt) {
			currentPage = pageTotCnt;
		}

		// 페이징 리턴
		pageVO paging = new pageVO();
		paging.setCurrentPage(currentPage);
		paging.setPagePerPageCnt(pagePerPageCnt);
		paging.setRecordPerPageCnt(recordPerPageCnt);
		paging.setRecordTotCnt(recordTotCnt);
		paging.setPageTotCnt(pageTotCnt);
		paging.setFirstPage(paging.getFirstPage());
		paging.setLastPage(paging.getLastPage());

		// mav 설정
		mav.addObject("paging", paging);

		// requestMap 설정 (페이징 sql문에서 사용)
		requestMap.put("currentPage", currentPage);
		requestMap.put("recordPerPageCnt", recordPerPageCnt);

		return requestMap;
	}
}
