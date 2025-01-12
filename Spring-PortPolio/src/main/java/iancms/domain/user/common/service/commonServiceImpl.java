package iancms.domain.user.common.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import iancms.domain.user.common.mapper.commonMapper;
import iancms.domain.user.common.vo.commonDto;
import iancms.domain.user.common.vo.commonVO;
import iancms.domain.user.common.vo.customUser;
import iancms.domain.user.common.vo.loginDto;
import iancms.domain.user.sample.mapper.SampleMapper;
import iancms.domain.user.sample.vo.SampleVO;

@Service
public class commonServiceImpl implements commonService{
	
	@Autowired
    private PasswordEncoder passwordEncoder;  // 비밀번호를 인코딩/검증하기 위한 PasswordEncoder
	
	@Autowired
	private commonMapper commonMapper;
	
	@Override
	public List<?> selectSample(commonDto dto) throws Exception {
		return commonMapper.selectSample(dto);
		
	}

	@Override
	public loginDto loginUser(loginDto dto) throws Exception {
		return commonMapper.loginUser(dto);
	}
	
	@Override
	public customUser loginCheck(String user_id) throws Exception {
		return commonMapper.loginCheck(user_id);
	}
	
	@Override
	public int chkUserId(String user_id) throws Exception {
		return commonMapper.chkUserId(user_id);
	}

	@Override
	public int sign_up_User(loginDto dto) throws Exception {
		String user_password = passwordEncoder.encode(dto.getUser_password()); //비밀번호 인코딩
		dto.setUser_password(user_password);
		
		int result = commonMapper.sign_up_User(dto);
		
		return result;
	}
	
	@Override
	public int insert_Log(Map<String, Object> map) throws Exception {
		int result = commonMapper.insert_Log(map);
		return result;
	}

}
