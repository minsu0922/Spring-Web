package iancms.global.auth;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;
import iancms.domain.user.common.service.commonService;

@Component
public class loginFailureHandler extends SimpleUrlAuthenticationFailureHandler{
	
	@Autowired
	private commonService commonService;
	
	private static final Logger logger = LoggerFactory.getLogger(loginFailureHandler.class);
	
	@Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
		
		// 1. 로그인 로그 남기기
        String user_id = (String) request.getParameter("user_id");
        String user_password = (String) request.getParameter("user_password");
        String url = request.getRequestURI();
        String clientIp = request.getRemoteAddr();
        String userAgent = request.getHeader("User-Agent");
        // 상태 코드 확인 (200이면 성공으로 간주)
        int statusCode = response.getStatus();
        
        String errorMessage;
        if (exception instanceof BadCredentialsException) {
            errorMessage = "아이디 또는 비밀번호가 맞지 않습니다." + "<br>" + "다시 확인해 주세요.";
        } else if (exception instanceof InternalAuthenticationServiceException) {
            errorMessage = "내부적으로 발생한 시스템 문제로 인해 요청을 처리할 수 없습니다." + "<br>" + "관리자에게 문의하세요.";
        } else if (exception instanceof UsernameNotFoundException) {
            errorMessage = "계정이 존재하지 않습니다." + "<br>" + "회원가입 진행 후 로그인 해주세요.";
        } else if (exception instanceof AuthenticationCredentialsNotFoundException) {
            errorMessage = "인증 요청이 거부되었습니다." + "<br>" + "관리자에게 문의하세요.";
        } else {
            errorMessage = "알 수 없는 이유로 로그인에 실패하였습니다." + "<br>" + "관리자에게 문의하세요.";
        }
        
        Map<String, Object> map = new HashMap<String, Object>(); 
			map.put("user_id", user_id); 
			map.put("url", url);
		    map.put("lgn_ip_addr", clientIp); 
		    map.put("success_yn", 'N'); 
		    map.put("message", errorMessage);
			
		try {
			// 로그인 로그 넘기기
			commonService.insert_Log(map);
		} catch (Exception e) {
			logger.info("[로그 삽입 실패] : ID={}, MSG={}", user_id, e);
			e.printStackTrace();
		}
        
        logger.info("[FAIL] 로그인 실패 : ID={}, MSG={}", user_id, exception.getMessage());
        // 컨트롤러로 에러메세지 넘기기
        request.getSession().setAttribute("errorMessage", errorMessage);
        
        setDefaultFailureUrl("/common/login.do");

        super.onAuthenticationFailure(request, response, exception);
    }		
	
}
