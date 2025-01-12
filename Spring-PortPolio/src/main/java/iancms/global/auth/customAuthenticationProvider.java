package iancms.global.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class customAuthenticationProvider implements AuthenticationProvider {

    @Autowired
    private customUserDetailsService userDetailsService;  // UserDetailsService를 주입받아 사용

    @Autowired
    private PasswordEncoder passwordEncoder;  // 비밀번호를 인코딩/검증하기 위한 PasswordEncoder

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        // 사용자가 입력한 사용자명과 비밀번호를 가져옴
        String username = authentication.getName();
        String password = authentication.getCredentials().toString();
        // UserDetailsService를 통해 사용자 정보를 조회
        UserDetails user = userDetailsService.loadUserByUsername(username);
		 // 비밀번호가 일치하는지 확인 
		  if (!passwordEncoder.matches(password, user.getPassword())){ 
			  throw new BadCredentialsException("Invalid username or password"); 
			  }
		 
		//authentication 객체로 리턴
		UsernamePasswordAuthenticationToken authenticatedUser = null;
		authenticatedUser = new UsernamePasswordAuthenticationToken(user, password, user.getAuthorities()); 
        // 인증 성공 시, 인증된 Authentication 객체 반환
        return authenticatedUser;
    }

    @Override
    public boolean supports(Class<?> authentication) {
        // UsernamePasswordAuthenticationToken 타입의 인증을 지원
        return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
    }
}
