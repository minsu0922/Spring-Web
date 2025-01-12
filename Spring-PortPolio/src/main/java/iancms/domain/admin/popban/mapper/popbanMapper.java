package iancms.domain.admin.popban.mapper;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import iancms.domain.admin.popban.vo.bannerDto;
import iancms.domain.admin.popban.vo.mainSlideDto;
import iancms.domain.admin.popban.vo.popupDto;

@Mapper
public interface popbanMapper {
	
	// 메인 슬라이드 관리
	List<mainSlideDto> mainSlideList(mainSlideDto mainSlide) throws Exception;
	mainSlideDto mainSlideInfo(mainSlideDto mainSlide) throws Exception;
	int mainSlideRegist(mainSlideDto mainSlide) throws Exception;
	int mainSlideUpdate(mainSlideDto mainSlide) throws Exception;
	int mainSlideDelete(String popban_sn) throws Exception;
	
	// 팝업창 관리
	List<popupDto> popupList(popupDto popup) throws Exception;
    popupDto popupInfo(popupDto popup) throws Exception; 
    int popupRegist(popupDto popup) throws Exception; 
    int popupUpdate(popupDto popup) throws Exception; 
    int popupDelete(String popban_sn) throws Exception; 
	
	// 배너 관리
    List<bannerDto> bannerList(bannerDto banner) throws Exception;
    bannerDto bannerInfo(bannerDto banner) throws Exception;
    int bannerRegist(bannerDto banner) throws Exception;
    int bannerUpdate(bannerDto banner) throws Exception;
    int bannerDelete(String popban_sn) throws Exception;
}
