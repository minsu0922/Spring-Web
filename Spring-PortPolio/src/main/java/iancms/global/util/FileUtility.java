package iancms.global.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import iancms.domain.user.common.vo.atchFileDto;
import iancms.domain.user.common.vo.atchFileVO;
import iancms.domain.user.common.service.atchFileService;

@Component
public class FileUtility {
	
	@Autowired
    private atchFileService atchFileService;

	public void fileUpload(MultipartHttpServletRequest multiRequest) throws Exception {

		 MultipartFile mFile;
		    String filePath = "C:\\Users\\Public\\Documents\\IANCMS";

		    List<MultipartFile> list = multiRequest.getFiles("file");
		    int atchSn = 1;
		    // 파일 리스트를 순회하면서 각각 처리
		    for (int i = 0; i < list.size(); i++) {
		        // 현재 파일을 가져온다.
		        mFile = list.get(i);

		        // 파일명
		        String atchNm = mFile.getOriginalFilename();
		        
		        // 확장자를 제외한 파일명
		        String fileCutName = atchNm.substring(0, atchNm.lastIndexOf("."));
		        
		        // 확장자
		        String fileExtn = atchNm.substring(atchNm.lastIndexOf(".") + 1);
		        
		        // 파일크기
		        int fileSize = (int) mFile.getSize();

		        // 파일 저장 경로 (파일명 제거)
		        String saveDirPath = filePath; // 파일명 제거
		        String saveFilePath = saveDirPath + File.separator + atchNm; // 최종 파일 경로 생성

		        // filePath에 해당되는 파일의 File 객체를 생성한다.
		        File fileFolder = new File(saveDirPath);

		        // 폴더가 존재하지 않으면 생성
		        if (!fileFolder.exists()) {
		            if (fileFolder.mkdirs()) {
		                System.out.println("[file.mkdirs] : Success");
		            } else {
		                System.out.println("[file.mkdirs] : Fail");
		            }
		        }

		        File saveFile = new File(saveFilePath);
		        String finalFileName = fileCutName; // 중복 파일명 처리 후 최종 파일 이름

		        // 파일명이 중복될 경우 처리
		        if (saveFile.isFile()) {
		            boolean _exist = true;
		            int index = 0;

		            // 동일한 파일명이 존재하지 않을 때까지 반복
		            while (_exist) {
		                index++;
		                // 중복된 파일명 생성, 확장자는 유지
		                finalFileName = fileCutName + "(" + index + ")"; // 중복 처리된 파일명
		                saveFilePath = saveDirPath + File.separator + finalFileName + "." + fileExtn; // 최종 저장 경로 업데이트

		                _exist = new File(saveFilePath).isFile();
		            }

		            // 중복된 파일명을 처리한 후 저장
		            mFile.transferTo(new File(saveFilePath));
		        } else {
		            // 중복되지 않으면 바로 저장
		            mFile.transferTo(saveFile);
		        }

		        //AtchFileVO에 정보 저장
		        atchFileDto atchFile = new atchFileDto();
		        atchFile.setAtch_nm(finalFileName);          // 중복 파일 처리된 파일 이름
		        atchFile.setFile_path(filePath);          // 파일 경로 (파일명 제외)
		        atchFile.setFile_extn(fileExtn);              // 파일 확장자
		        atchFile.setFile_size(fileSize);              // 파일 크기
		        atchFile.setAtch_sn(atchSn);
		        atchSn++;
		        System.out.println("AtchNm : "+finalFileName+"\nFilePath : "+saveDirPath+"\nFileExtn : "+fileExtn+"\nFileSize : "+fileSize);
		        atchFileService.fileUpload(atchFile);
		    }
	}
	
	public List<atchFileDto> atchFileList(atchFileDto atchFile) throws Exception{
		return atchFileService.atchFileList(atchFile);
	}
	
	public String fileDownload(HttpServletRequest request, HttpServletResponse response, atchFileDto dto) throws Exception{
		String result2 ="";
		atchFileDto result = atchFileService.fileDownload(dto);
		
        String fileName = result.getAtch_nm();
        String filePath = result.getFile_path() + "\\" + fileName + "." + result.getFile_extn();

        File downloadFile = new File(filePath);
        response.setContentType("application/octet-stream");
        response.setContentLengthLong(downloadFile.length());
        
        // 파일 이름 인코딩
        String encodedFileName = URLEncoder.encode(downloadFile.getName(), "UTF-8").replaceAll("\\+", "%20");
        response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + encodedFileName);

        // 파일 전송
        try (FileInputStream fis = new FileInputStream(downloadFile);
             BufferedInputStream bis = new BufferedInputStream(fis);
             OutputStream os = response.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = bis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
            atchFileService.updateAtchFileDown(dto.getAtch_id());
            result2 = "ok";
            System.out.println("파일 다운로드 성공: " + fileName);
        } catch (FileNotFoundException e) {
        	result2 = "no";
        } catch (IOException e) {
        	result2 = "no";
            e.printStackTrace();
        }
        return result2;
    }
	
	public void fileDelete(String atch_id) throws Exception{
		
		String[] atch_ids = atch_id.split(",");
		for(int i = 0; i<atch_ids.length; i++) {
			atchFileService.fileDelete(Integer.parseInt(atch_ids[i]));
		}
		
	}
}
