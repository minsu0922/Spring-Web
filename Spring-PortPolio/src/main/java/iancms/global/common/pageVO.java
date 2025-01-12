package iancms.global.common;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class pageVO {

	private int currentPage; // 현재 페이지 번호
	private int pagePerPageCnt; // 한 페이지 목록 당 페이지 수
	private int recordPerPageCnt; // 한 페이지 당 레코드 수
	private int recordTotCnt; // 전체 레코드 수
	private int pageTotCnt; // 전체 페이지 수
	private int firstPage; // 페이지 목록의 첫번째 페이지
	private int lastPage; // 페이지 목록의 마지막 페이지
	
	// page 설계
	public int getFirstPage() {
		firstPage = ((getCurrentPage() - 1) / getPagePerPageCnt()) * getPagePerPageCnt() + 1;
		return firstPage;
	}
	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}
	
	public int getLastPage() {
		lastPage = getFirstPage() + getPagePerPageCnt() - 1;
		if (lastPage > getPageTotCnt()) {
			lastPage = getPageTotCnt();
		}
		return lastPage;
	}
	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
}
