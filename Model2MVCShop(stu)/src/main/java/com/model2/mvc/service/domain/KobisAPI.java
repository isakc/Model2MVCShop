package com.model2.mvc.service.domain;

public class KobisAPI {
	///Field
	private String key;
	private String targetDt;
	private String itemPerPage;
	private String multiMovieYn;
	private String repNationCd;
	private String wideAreaCd;
	
	///Constructor
	public KobisAPI() {
	}

	///Method
	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getTargetDt() {
		return targetDt;
	}

	public void setTargetDt(String targetDt) {
		this.targetDt = targetDt;
	}

	public String getItemPerPage() {
		return itemPerPage;
	}

	public void setItemPerPage(String itemPerPage) {
		this.itemPerPage = itemPerPage;
	}

	public String getMultiMovieYn() {
		return multiMovieYn;
	}

	public void setMultiMovieYn(String multiMovieYn) {
		this.multiMovieYn = multiMovieYn;
	}

	public String getRepNationCd() {
		return repNationCd;
	}

	public void setRepNationCd(String repNationCd) {
		this.repNationCd = repNationCd;
	}

	public String getWideAreaCd() {
		return wideAreaCd;
	}

	public void setWideAreaCd(String wideAreaCd) {
		this.wideAreaCd = wideAreaCd;
	}
}