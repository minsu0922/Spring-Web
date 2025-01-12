package iancms.domain.user.common.vo;

import iancms.domain.user.sample.vo.SampleDefaultVO;
import lombok.AllArgsConstructor;
import lombok.Getter;


@Getter
@AllArgsConstructor
public class commonVO extends SampleDefaultVO {

	//게시글 vo	
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
	
	
}
