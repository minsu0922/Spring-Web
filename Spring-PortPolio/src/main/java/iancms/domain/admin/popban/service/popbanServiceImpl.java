package iancms.domain.admin.popban.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import iancms.domain.admin.popban.vo.bannerDto;
import iancms.domain.admin.popban.vo.mainSlideDto;
import iancms.domain.admin.popban.vo.popupDto;
import iancms.domain.admin.popban.mapper.popbanMapper;

@Service
public class popbanServiceImpl implements popbanService {
	
	@Autowired
	private popbanMapper popbanMapper;
	
	
	// 메인 슬라이드 관리
	@Override
	public List<mainSlideDto> mainSlideList(mainSlideDto mainSlide) throws Exception {
		return popbanMapper.mainSlideList(mainSlide);
	}
	
	@Override
	public mainSlideDto mainSlideInfo(mainSlideDto mainSlide) throws Exception {
		return popbanMapper.mainSlideInfo(mainSlide);
	}
	
	@Override
	public int mainSlideRegist(mainSlideDto mainSlide) throws Exception {
		return popbanMapper.mainSlideRegist(mainSlide);
	}
	
	
	@Override
	public int mainSlideUpdate(mainSlideDto mainSlide) throws Exception {
		return popbanMapper.mainSlideUpdate(mainSlide);
	}
	
	@Override
	public int mainSlideDelete(String popban_sn) throws Exception {
		return popbanMapper.mainSlideDelete(popban_sn);
	}
	
	// 팝업창 관리
	@Override
    public List<popupDto> popupList(popupDto popup) throws Exception {
        return popbanMapper.popupList(popup);
    }
    
    @Override
    public popupDto popupInfo(popupDto popup) throws Exception {
        return popbanMapper.popupInfo(popup);
    }
    
    @Override
    public int popupRegist(popupDto popup) throws Exception {
        return popbanMapper.popupRegist(popup);
    }
    
    @Override
    public int popupUpdate(popupDto popup) throws Exception {
        return popbanMapper.popupUpdate(popup);
    }
    
    @Override
    public int popupDelete(String popup_sn) throws Exception {
        return popbanMapper.popupDelete(popup_sn);
    }
	
	// 배너 관리
	@Override
    public List<bannerDto> bannerList(bannerDto banner) throws Exception {
        return popbanMapper.bannerList(banner);
    }
    
    @Override
    public bannerDto bannerInfo(bannerDto banner) throws Exception {
        return popbanMapper.bannerInfo(banner);
    }
    
    @Override
    public int bannerRegist(bannerDto banner) throws Exception {
        return popbanMapper.bannerRegist(banner);
    }
    
    @Override
    public int bannerUpdate(bannerDto banner) throws Exception {
        return popbanMapper.bannerUpdate(banner);
    }
    
    @Override
    public int bannerDelete(String banner_sn) throws Exception {
        return popbanMapper.bannerDelete(banner_sn);
    }
}
