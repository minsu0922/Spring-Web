package iancms.domain.user.common.vo;

import lombok.Data;

@Data
public class commonDto extends defaultVO {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/** 아이디 */
	private String id;

	/** 이름 */
	private String name;

	/** 내용 */
	private String description;

	/** 사용여부 */
	private String useYn;

	/** 등록자 */
	private String regUser;
	
	private String c_code;
	
	private String c_name;
	
	private String com_cd_sn;
	
	private String cd;
	
	private String cd_nm;
	
	private String cd_description;
	
	private String use_yn;
	
	private String rgtr_id;
	
	private String reg_dt;
	
	private String mdfr_id;
	
	private String mdfcn_de;
	
	private String del_yn;
	
	private String com_cd_dtl_sn;
	
	private String dtl_cd;
	
	private String dtl_cd_nm;
	
	
	
}
