package iancms.domain.admin.main.service;

import java.util.List;

import iancms.domain.admin.member.vo.memberDto;

public interface mainService {
	List<memberDto> memberList(memberDto member) throws Exception;
	memberDto memberInfo(memberDto member) throws Exception;
	int memberPwreset(String user_id) throws Exception;
	int memberUpdate(memberDto member) throws Exception;
	int memberDelete(String user_id) throws Exception;
	
}
