package com.model2.mvc.service.domain;

public class ProductImage {
	private int imgNo;
	private String fileName;
	private int prodNo;
	
	public ProductImage() {
	}
	
	public int getImgNo() {
		return imgNo;
	}

	public String getFileName() {
		return fileName;
	}

	public int getProdNo() {
		return prodNo;
	}

	public void setImgNo(int imgNo) {
		this.imgNo = imgNo;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}

	public String toString() {
		return "imgNo: " + imgNo + "\nfileName: " +fileName + "\nprodNo: " +prodNo;
	}
}