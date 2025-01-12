package iancms.domain.user.common.vo;

import lombok.Data;

@Data
public class loginDto {
	
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


}
