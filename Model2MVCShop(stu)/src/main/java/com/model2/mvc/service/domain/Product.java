package com.model2.mvc.service.domain;

import java.sql.Date;
import java.util.List;


public class Product {
	
	private List<String> fileNames;
	private String manuDate;
	private int price;
	private String prodDetail;
	private String prodName;
	private int prodNo;
	private Date regDate;
	////////------------�߰�------------///////
	private String transStatusCode;
	private Category category;
	private int quantity;

	public Product(){
	}

	public Product(int prodNo) {
		this.prodNo = prodNo;
	}

	public String getManuDate() {
		return manuDate;
	}
	public void setManuDate(String manuDate) {
		this.manuDate = manuDate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getProdDetail() {
		return prodDetail;
	}
	public void setProdDetail(String prodDetail) {
		this.prodDetail = prodDetail;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public int getProdNo() {
		return prodNo;
	}
	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	
	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	public String getTransStatusCode() {
		return transStatusCode;
	}

	public void setTransStatusCode(String transStatusCode) {
		this.transStatusCode = transStatusCode;
	}
	
	public List<String> getFileNames() {
		return fileNames;
	}

	public void setFileNames(List<String> fileNames) {
		this.fileNames = fileNames;
	}

	// Override
	public String toString() {
		return "ProductVO :"
				+ "[manuDate]" + manuDate+ "[price]" + price + "[prodDetail]" + prodDetail
				+ "[prodName]" + prodName + "[prodNo]" + prodNo + "[quantity]" + quantity;
	}	
}