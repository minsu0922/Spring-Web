package iancms.global.config;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import iancms.domain.admin.menu.service.menuService;
import iancms.domain.user.common.service.commonService;
import iancms.domain.user.common.vo.customUser;
import iancms.domain.user.common.vo.loginDto;

public class loggingInterceptor implements HandlerInterceptor {
	
	private static final Logger logger = LoggerFactory.getLogger(loggingInterceptor.class);
	
	  @Autowired 
	  private commonService commonService;
	 
	  @Autowired 
	  private menuService menuService;
	  
	  /**
		 * 컨트롤러 호출 전 
		 *
		 */
	 @Override
	 public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	        // 요청이 들어오기 전에 로그를 남깁니다.
	        String requestURI = request.getRequestURI();
	        logger.info("User accessed: {}", requestURI);

	        // 여기에 추가적인 로직을 구현할 수 있습니다.
	        // 예: 사용자 정보 가져오기, 접속 시간 기록, DB에 로그 저장 등

	        return true; // 다음 인터셉터 또는 컨트롤러로 진행
	    }
	  
	/**
	 * 컨트롤러 호출 후 - view render 전
	 * @ 웹 로그 저장
	 */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView model) throws Exception {
    
    	if (response.getStatus() == HttpServletResponse.SC_OK) {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			String url = request.getRequestURI();
			
			if (authentication != null) {
				Object principal = authentication.getPrincipal();
				if (!principal.equals("anonymousUser")) {
					
					HttpSession session = request.getSession();
					loginDto user = (loginDto) session.getAttribute("user");
					String userIp = (String) session.getAttribute("userIp");
					
					/*
					 * if (user != null) { MenuDTO menu = menuService.getMenu(url);
					 * 
					 * if (menu != null && mav != null) { // 등록된 URL만 로그 저장 String keyword =
					 * (String) mav.getModel().get("keyword");
					 * 
					 * Map<String, Object> map = new HashMap<String, Object>(); map.put("userId",
					 * user.getUser_id()); map.put("menuNm", menu.getMenuNm()); map.put("url", url);
					 * map.put("userIp", userIp); map.put("keyword", keyword);
					 * 
					 * logService.insertLog(map); } } // 메뉴 권한 검증 통과 체크
					 */				} // 인증 여부 및 세션 만료 검증
			} // authentication 검증
	    } // 정상 응답 검증
    }
    
    /**
	 * 모든 작업이 완료된 후에 호출
	 *
	 */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
    	// authentication 검증, 로그인한 사용자만 사용자 정보 추출
    	if(SecurityContextHolder.getContext().getAuthentication().getPrincipal().getClass().equals(customUser.class)){
			customUser customUser = (customUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	        String user_id = customUser.getUser_id();
	        String user_name = customUser.getUser_name();
	        String role = customUser.getUser_role();
	        String url = request.getRequestURI();
	        String clientIp = request.getRemoteAddr();
	        String userAgent = request.getHeader("User-Agent");

	        // 상태 코드 확인 (200이면 성공으로 간주)
	        int statusCode = response.getStatus();
	        boolean isSuccess = statusCode == 200;
	        
	        if (customUser != null) {
				if (!role.equals("anonymousUser")) {
					
					HttpSession session = request.getSession();		
					Map<String, Object> map = new HashMap<String, Object>(); 
					map.put("user_id", user_id); 
					map.put("user_name", user_name); 
					map.put("url", url);
				    map.put("lgn_ip_addr", clientIp); 
				    map.put("user_role", role);
				    map.put("message", "로그인 성공");
					
					/* commonService.insert_Log(map); */
			} 
	        
	        
	        // 로그 기록
	        if (ex == null && isSuccess) {
	        	logger.info("Login successful - user_id: {}, IP: {}", user_id, clientIp);
	        } else {
	            String errorMessage = (ex != null) ? ex.getMessage() : "Unknown error";
	            logger.warn("Login failed - user_id: {}, Error: {}", user_id, errorMessage);
	        }
    	
    	}
    	
		
    }
}
}
