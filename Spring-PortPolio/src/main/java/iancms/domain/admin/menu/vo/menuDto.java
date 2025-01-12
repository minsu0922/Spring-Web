package iancms.domain.admin.menu.vo;

import iancms.domain.user.common.vo.defaultVO;
import lombok.Data;

@Data
public class menuDto extends defaultVO {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	// 메뉴 아이디
	private String menu_id;
	
	// 메뉴명
	private String menu_nm;
	
	// 상위메뉴 아이디
	private String up_menu_id;
	
	// 상위메뉴명
	private String up_menu_nm;
	
	// 메뉴타입(관리자/사용자)
	private String menu_type;
	
	//최상위 메뉴 여부
	private String top_menu_yn;
	
	// 메뉴경로
	private String menu_url;
	
	//메뉴 순서
	private String menu_order;
	
	//메뉴 깊이
	private String menu_depth;
	
	//메뉴 사용여부
	private String use_yn;
	
	// 관리자 혀용 권한
	private int admin_allow;
	
	// 운영자 혀용 권한
	private int manage_allow;
	
	// 일반회원 혀용 권한
	private int user_allow;
	
}
