package iancms.domain.user.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import iancms.domain.user.common.mapper.atchFileMapper;
import iancms.domain.user.common.vo.atchFileDto;
import iancms.domain.user.common.vo.atchFileVO;

@Service
public class atchFileServiceImpl implements atchFileService{

	@Autowired
	private atchFileMapper atchFileMapper;
	
	@Override
	public void fileUpload(atchFileDto atchFile) throws Exception {
		atchFileMapper.fileUpload(atchFile);
	}
	
	@Override
	public List<atchFileDto> atchFileList(atchFileDto atchFile) throws Exception {
		return atchFileMapper.atchFileList(atchFile);
	}
	
	@Override
	public void updateAtchFileDown(int atchSn) throws Exception {
		atchFileMapper.updateAtchFileDown(atchSn);		
	}

	@Override
	public atchFileDto fileDownload(atchFileDto atchFile) throws Exception {
		return atchFileMapper.fileDownload(atchFile);
	}
	
	@Override
	public void fileDelete(int atchId) throws Exception {
		atchFileMapper.fileDelete(atchId);
	}
}
