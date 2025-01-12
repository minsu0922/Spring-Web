package iancms.domain.user.common.mapper;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.springframework.security.core.userdetails.UserDetails;

import iancms.domain.user.common.vo.commonDto;
import iancms.domain.user.common.vo.commonVO;
import iancms.domain.user.common.vo.customUser;
import iancms.domain.user.common.vo.loginDto;

@Mapper
public interface commonMapper {
	
	/**
	 * 글을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SampleVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	public List<?> selectSample(commonDto dto) throws Exception;
	
	/**
	 * 로그인 아이디 비번 조회.
	 * @param vo - 조회할 정보가 담긴 vo
	 * @return 조회된 아이디 비번
	 * @exception Exception
	 */
	public loginDto loginUser(loginDto dto) throws Exception;
	
	/**
	 * 로그인 아이디 비번 조회.
	 * @param vo - 조회할 정보가 담긴 vo
	 * @return 조회된 아이디 비번
	 * @exception Exception
	 */
	public customUser loginCheck(String user_id) throws Exception;
	
	public List<commonDto> comCdList(commonDto dto) throws Exception;
	public List<commonDto> comCdDtlList(String com_cd_sn) throws Exception;
	public int comCdInsert(commonDto dto) throws Exception;
	public int comCdUpdate(commonDto dto) throws Exception;
	public int comCdDelete(String com_cd_sn) throws Exception;
	public int comCdDtlInsert(commonDto dto) throws Exception;
	public int comCdDtlDelete(String com_cd_dtl_sn) throws Exception;
	/**
	 * 로그인 아이디 조회.
	 * @param 아이디 
	 * @return 조회된 아이디
	 * @exception Exception
	 */
	public int chkUserId(String user_id) throws Exception;
	
	/**
	 * 회원가입
	 * @param vo - 정보가 담긴 dto
	 * @return 성공/실패
	 * @exception Exception
	 */
	public int sign_up_User(loginDto dto) throws Exception;
	
	/**
	 * 회원접속로그 
	 * @param map - 정보가 담긴 map
	 * @exception Exception
	 */
	public int insert_Log(Map<String, Object> map) throws Exception;
	
}
