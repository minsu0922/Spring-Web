package iancms.domain.user.common.service;

import java.util.List;

import iancms.domain.user.common.vo.atchFileDto;
import iancms.domain.user.common.vo.atchFileVO;

public interface atchFileService {
	void fileUpload(atchFileDto atchFile) throws Exception;
	List<atchFileDto> atchFileList(atchFileDto atchFile) throws Exception;
	void updateAtchFileDown(int atchSn) throws Exception;
	atchFileDto fileDownload(atchFileDto atchFile) throws Exception;
	void fileDelete(int atchSn) throws Exception;
}
