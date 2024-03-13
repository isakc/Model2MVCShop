package com.model2.mvc.service.domain;

public class Cart {
	private int cartNo;
	private User user;
	private Product product;
	private int quantity;
	
	public Cart() {
	}

	public int getCartNo() {
		return cartNo;
	}

	public User getUser() {
		return user;
	}

	public Product getProduct() {
		return product;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String toString() {
		return "cartNo: " +cartNo + "\nuserId: " +user.getUserId() + "\nprodNo: " +product.getProdNo()+ "\nQuantity: " + quantity;
	}
}