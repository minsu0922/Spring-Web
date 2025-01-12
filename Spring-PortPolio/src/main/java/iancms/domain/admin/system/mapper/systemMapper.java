package iancms.domain.admin.system.mapper;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import iancms.domain.admin.system.vo.systemDto;

@Mapper
public interface systemMapper {
	
	public List<systemDto> comCdList(systemDto dto) throws Exception;
	public List<systemDto> comCdDtlList(String com_cd_sn) throws Exception;
	public int comCdInsert(systemDto dto) throws Exception;
	public int comCdUpdate(systemDto dto) throws Exception;
	public int comCdDelete(String com_cd_sn) throws Exception;
	public int comCdDtlInsert(systemDto dto) throws Exception;
	public int comCdDtlUpdate(systemDto dto) throws Exception;
	public int comCdDtlDelete(String com_cd_dtl_sn) throws Exception;

}
