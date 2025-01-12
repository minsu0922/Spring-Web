package iancms.global.auth;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import iancms.domain.user.common.service.commonService;
import iancms.domain.user.common.vo.customUser;

@Component
public class loginSuccessHandler extends SimpleUrlAuthenticationSuccessHandler{
	
	 @Autowired 
	 private commonService commonService;
	
	 private static final Logger logger = LoggerFactory.getLogger(loginFailureHandler.class);
	 
	@Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {

		customUser user = (customUser) authentication.getPrincipal();
		String sAuth = user.getUser_role();
		String targetUrl = "/";
		
		// 1. 권한에 따라 접속 메뉴 구분
		if (sAuth.equals("ROLE_USER")) {
			targetUrl = "/common/main.do";
			
		} else if (sAuth.equals("ROLE_ADMIN")) {
			targetUrl = "/admin/main.do";
		} 
		
		// 2. 로그인 로그 남기기
        String user_id = user.getUser_id();
        String user_name = user.getUser_name();
        String role = user.getUser_role();
        String url = request.getRequestURI();
        String clientIp = request.getRemoteAddr();
        String userAgent = request.getHeader("User-Agent");
        // 상태 코드 확인 (200이면 성공으로 간주)
        int statusCode = response.getStatus();
		Map<String, Object> map = new HashMap<String, Object>(); 
				map.put("user_id", user_id); 
				map.put("user_name", user_name); 
				map.put("url", url);
			    map.put("lgn_ip_addr", clientIp); 
			    map.put("user_role", role);
			    map.put("success_yn", 'Y');
			    map.put("message", "로그인 성공");
				
				try {
					// 로그인 로그 넘기기
					commonService.insert_Log(map);
				} catch (Exception e) {
					logger.info("[로그 삽입 실패] : ID={}, MSG={}", user_id, e);
					e.printStackTrace();
				}
		
		
		/*
		 * if (!targetUrl.equals("/")) { try { signInLog(request, user, targetUrl);
		 * 
		 * } catch (Exception e) { logger.error("[ERROR] 로그인 로그를 저장하지 못하였습니다.");
		 * e.printStackTrace(); } }
		 */
		
		// 3. 메뉴 정보 세션에 저장
		HttpSession session = request.getSession();
		/*
		 * try { List<EgovMap> menuList = menuService.selectMenuList(); Gson gson = new
		 * Gson();
		 * 
		 * for (EgovMap menu : menuList) { // 하위 메뉴 목록 JSON 객체 파싱 String subMenuListJson
		 * = (String) menu.get("subMenuList"); List<EgovMap> subMenuList = new
		 * ArrayList<EgovMap>();
		 * 
		 * if (subMenuListJson != null && !subMenuListJson.isEmpty()) { subMenuList =
		 * gson.fromJson(subMenuListJson, new TypeToken<List<EgovMap>>() {}.getType());
		 * } menu.put("subMenuList", subMenuList); } session.setAttribute("menuList",
		 * menuList);
		 * 
		 * } catch (Exception e) { logger.error("[ERROR] 메뉴 정보를 세션에 저장하지 못하였습니다.");
		 * e.printStackTrace(); }
		 */
		
		// 4. 페이지 이동
		response.sendRedirect(targetUrl);
    }
	
}
