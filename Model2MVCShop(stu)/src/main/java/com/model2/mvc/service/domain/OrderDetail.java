package com.model2.mvc.service.domain;

import java.sql.Date;

public class OrderDetail {
	private int orderNo;
	private Purchase transaction;
	private Product product;
	private int quantity;
	private Date regDate;
	
	public OrderDetail() {
	}

	public int getOrderNo() {
		return orderNo;
	}

	public Purchase getTransaction() {
		return transaction;
	}

	public Product getProduct() {
		return product;
	}

	public int getQuantity() {
		return quantity;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public void setTransaction(Purchase transaction) {
		this.transaction = transaction;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
}
