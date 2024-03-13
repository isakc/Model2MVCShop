package com.model2.mvc.service.domain;

import java.sql.Date;

public class Category {
	private int categoryNo;
	private int parentCategoryNo;
	private String categoryName;
	private Date regDate;
	
	public Category() {
	}
	
	public int getCategoryNo() {
		return categoryNo;
	}

	public int getParentCategoryNo() {
		return parentCategoryNo;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}

	public void setParentCategoryNo(int parentCategoryNo) {
		this.parentCategoryNo = parentCategoryNo;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "CategoryVO : [categoryNo]" + categoryNo
				+ "[parentCategoryNo]" + parentCategoryNo+ "[categoryName]" + categoryName + "[regDate]" + regDate;
	}
}
