package iancms.domain.admin.main.mapper;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import iancms.domain.admin.member.vo.memberDto;

@Mapper
public interface mainMapper {
	List<memberDto> memberList(memberDto member) throws Exception;
	memberDto memberInfo(memberDto member) throws Exception;
	int memberPwreset(@Param("user_id") String user_id, @Param("user_password") String user_password) throws Exception;
	int memberUpdate(memberDto member) throws Exception;
	int memberDelete(String user_id) throws Exception;

}
