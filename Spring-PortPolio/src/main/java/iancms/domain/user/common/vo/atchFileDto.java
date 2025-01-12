package iancms.domain.user.common.vo;

import lombok.Data;

@Data
public class atchFileDto {
	
	/** 첨부파일 순번  */
	private int atch_sn;

	/** 첨부파일 이름 */
	private String atch_nm;

	/** 파일경로 */
	private String file_path;
	
	/** 첨부파일 확장자  */
	private String file_extn;
	
	/** 첨부파일 크기 */
	private int file_size;
	
	/** 다운횟수 */
	private int down_cnt;
	
	/** 삭제여부  */
	private String del_yn;
	
	/** 등록자 */
	private String rgtr_id;
	
	/** 등록일 */
	private String reg_dt;
	
	/** 수정자 */
	private String mdfr_id;
	
	/** 수정일 */
	private String mdfcn_dt;
	
	/** 첨부파일 아이디 */
	private int atch_id;
	
	private String menu_id;
}
