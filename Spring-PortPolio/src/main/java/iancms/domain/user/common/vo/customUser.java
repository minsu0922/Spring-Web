package iancms.domain.user.common.vo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// Spring Security에서 가져오는 custom 정보들

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class customUser implements UserDetails {
	
	private static final long serialVersionUID = 1L;

	/** 아이디 */
	private String user_id;

	/** 비밀번호 */
	private String user_password;

	/** 이름 */
	private String user_name;
	
	/** 생년월일 */
	private String user_birth;
	
	/** 휴대번호 */
	private String user_cel;
	
	/** 우편번호 */
	private String zip_code;
	
	/** 주소 */
	private String user_addr;
	
	/** 상세 주소 */
	private String user_detail_addr;
	
	/** 참고 주소 */
	private String user_extra_addr;
	
	/** 이메일 */
	private String user_email;
	
	/** 권한 */
	/** ROLE_ADMIN, ROLE_USER */
	private String user_role;

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		authorities.add(new SimpleGrantedAuthority(user_role));
        return authorities;
	}
	
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return user_password;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return user_id;
	}
	
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return false;
	}

	
	
	
}
