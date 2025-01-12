package iancms.domain.admin.popban.vo;

import lombok.Data;

@Data
public class bannerDto {
	private int popban_sn;
	
	private String menu_id;
	
	private int atch_sn;
	
	private int site_sn;
	
	private String popban_type;
	
	private String popban_nm;
	
	private String popban_desc;
	
	private String use_yn;
	
	private String rgtr_id;
	
	private String reg_dt;
	
	private String mdfr_id;
	
	private String mdfcn_dt;
	
	private String del_yn;
	
	private String popban_start_dt;
	
	private String popban_end_dt;
	
	private int popban_order;
	
	private String popban_url;
	
	private String search_word;
	
	private String search_del_yn;
	
	private String search_datestart;
	
	private String search_dateend;
	
}
