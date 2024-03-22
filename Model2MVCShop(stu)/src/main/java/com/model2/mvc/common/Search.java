package com.model2.mvc.common;


public class Search {
	
	///Field
	private int curruntPage;
	private String searchCondition;
	private String searchKeyword;
	private int pageSize;
	/////////////////////Ãß°¡////////////////
	private String searchKeyword2;
	private String sorter;
	private String preSearchCondition;
	private String preSearchKeyword;
	private int categoryNo;
	
	///Constructor
	public Search() {
	}
	
	///Method
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int paseSize) {
		this.pageSize = paseSize;
	}
	
	public int getCurrentPage() {
		return curruntPage;
	}
	public void setCurrentPage(int curruntPage) {
		this.curruntPage = curruntPage;
	}

	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public int getCurruntPage() {
		return curruntPage;
	}

	public String getSearchKeyword2() {
		return searchKeyword2;
	}

	public String getSorter() {
		return sorter;
	}

	public String getPreSearchCondition() {
		return preSearchCondition;
	}

	public String getPreSearchKeyword() {
		return preSearchKeyword;
	}

	public int getCategoryNo() {
		return categoryNo;
	}

	public void setCurruntPage(int curruntPage) {
		this.curruntPage = curruntPage;
	}

	public void setSearchKeyword2(String searchKeyword2) {
		this.searchKeyword2 = searchKeyword2;
	}

	public void setSorter(String sorter) {
		this.sorter = sorter;
	}

	public void setPreSearchCondition(String preSearchCondition) {
		this.preSearchCondition = preSearchCondition;
	}

	public void setPreSearchKeyword(String preSearchKeyword) {
		this.preSearchKeyword = preSearchKeyword;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}

	@Override
	public String toString() {
		return "Search [curruntPage=" + curruntPage + ", searchCondition="
				+ searchCondition + ", searchKeyword=" + searchKeyword
				+ ", pageSize=" + pageSize + "]";
	}
}