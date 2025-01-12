package iancms.domain.admin.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import iancms.domain.admin.system.mapper.systemMapper;
import iancms.domain.admin.system.vo.systemDto;

@Service
public class systemServiceImpl implements systemService {
	
	@Autowired
	private systemMapper systemMapper;
	
	@Override
	public List<systemDto> comCdList(systemDto dto) throws Exception {
		return systemMapper.comCdList(dto);
		
	}
	
	@Override
	public List<systemDto> comCdDtlList(String com_cd_sn) throws Exception {
		return systemMapper.comCdDtlList(com_cd_sn);
		
	}
	
	@Override
	public int comCdInsert(systemDto dto) throws Exception {
		int result = systemMapper.comCdInsert(dto);
		return result;
	}
	
	@Override
	public int comCdUpdate(systemDto dto) throws Exception {
		int result = systemMapper.comCdUpdate(dto);
		return result;
	}
	
	@Override
	public int comCdDelete(String com_cd_sn) throws Exception {
		int result = systemMapper.comCdDelete(com_cd_sn);
		return result;
	}
	
	@Override
	public int comCdDtlInsert(systemDto dto) throws Exception {
		int result = systemMapper.comCdDtlInsert(dto);
		return result;
	}
	
	@Override
	public int comCdDtlUpdate(systemDto dto) throws Exception {
		int result = systemMapper.comCdDtlUpdate(dto);
		return result;
	}
	
	@Override
	public int comCdDtlDelete(String com_cd_dtl_sn) throws Exception {
		int result = systemMapper.comCdDtlDelete(com_cd_dtl_sn);
		return result;
	}

}
