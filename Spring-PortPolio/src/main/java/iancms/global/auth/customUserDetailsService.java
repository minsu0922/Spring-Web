package iancms.global.auth;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import iancms.domain.user.common.service.commonService;
import iancms.domain.user.common.vo.customUser;
import iancms.domain.user.common.vo.loginDto;

@Service
public class customUserDetailsService implements UserDetailsService {

    @Autowired
    private commonService commonService;  // 데이터베이스에서 사용자 정보를 가져올 service

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    	List<UserDetails> userList = new ArrayList<UserDetails>();
		try {
			// 데이터베이스에서 사용자 정보를 조회
			customUser user = commonService.loginCheck(username);
	    	// 사용자정보 셋팅
			String user_id = user.getUser_id();
			String password = user.getUser_password();
			String user_name = user.getUser_name();
			String user_birth = user.getUser_birth();
			String user_cel = user.getUser_cel();
			String zip_code = user.getZip_code();
			String user_addr = user.getUser_addr();
			String user_detail_addr = user.getUser_detail_addr();
			String user_extra_addr = user.getUser_extra_addr();
			String user_email = user.getUser_email();
			String user_role = user.getUser_role();
			return user;
			
		} catch (Exception e) {
			throw new UsernameNotFoundException("User not found");
		}
		
		

    }
}
