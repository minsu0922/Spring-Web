package iancms.domain.admin.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import iancms.domain.admin.member.vo.memberDto;
import iancms.domain.admin.member.mapper.memberMapper;

@Service
public class memberServiceImpl implements memberService{

	@Autowired
    private PasswordEncoder passwordEncoder;
	
	@Autowired
	private memberMapper memberMapper;
	
	@Override
	public List<memberDto> memberList(memberDto member) throws Exception {
		return memberMapper.memberList(member);
	}
	
	@Override
	public memberDto memberInfo(memberDto member) throws Exception {
		return memberMapper.memberInfo(member);
	}
	
	@Override
	public int memberPwreset(String user_id) throws Exception {
		String user_password = passwordEncoder.encode(user_id); //비밀번호 인코딩
		return memberMapper.memberPwreset(user_id, user_password);
	}
	
	@Override
	public int memberUpdate(memberDto member) throws Exception {
		return memberMapper.memberUpdate(member);
	}
	
	@Override
	public int memberDelete(String user_id) throws Exception {
		return memberMapper.memberDelete(user_id);
	}
}
