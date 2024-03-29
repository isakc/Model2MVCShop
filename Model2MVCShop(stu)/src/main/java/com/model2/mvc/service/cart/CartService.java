package com.model2.mvc.service.cart;

import java.util.List;

import com.model2.mvc.service.domain.Cart;

public interface CartService {
	
	//insert
	public void addCart(Cart cart) throws Exception;

	//selectOne
	public Cart findCart(Cart cart) throws Exception;
	
	//selectList
	public List<Cart> getCartList(String userId) throws Exception;
	
	//update
	public void updateCart(Cart cart) throws Exception;
	
	//delete
	public void deleteCart(int cartNo) throws Exception;
}