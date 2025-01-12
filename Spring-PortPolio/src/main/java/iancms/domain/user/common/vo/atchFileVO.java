package iancms.domain.user.common.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class atchFileVO {

	/** 첨부파일 아이디  */
	private int atchSn;

	/** 첨부파일 이름 */
	private String atchNm;

	/** 파일경로 */
	private String filePath;
	
	/** 첨부파일 확장자  */
	private String fileExtn;
	
	/** 첨부파일 크기 */
	private int fileSize;
	
	/** 다운횟수 */
	private int downCnt;
	
	/** 삭제여부  */
	private String delYn;
	
	/** 등록자 */
	private String rgtrId;
	
	/** 등록일 */
	private String regDt;
	
	/** 수정자 */
	private String mdfrId;
	
	/** 수정일 */
	private String mdfcnDt;

}
