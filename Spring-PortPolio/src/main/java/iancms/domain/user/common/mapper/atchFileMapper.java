package iancms.domain.user.common.mapper;

import iancms.domain.user.common.vo.atchFileDto;
import iancms.domain.user.common.vo.atchFileVO;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface atchFileMapper {
	void fileUpload(atchFileDto atchFile) throws Exception;
	List<atchFileDto> atchFileList(atchFileDto atchFile) throws Exception;
	void updateAtchFileDown(int atchSn) throws Exception;
	atchFileDto fileDownload(atchFileDto atchFile) throws Exception;
	void fileDelete(int atchSn) throws Exception;
}
