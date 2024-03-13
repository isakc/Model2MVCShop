package com.model2.mvc.service.cart;

import java.util.List;

import com.model2.mvc.service.domain.Cart;

public interface CartDao {
	public void insertCart(Cart cart) throws Exception;
	
	public List<Cart> getCartList(String userId) throws Exception;
	
	public void updateCart(Cart cart) throws Exception;
	
	public Cart findCart(Cart cart) throws Exception;
	
	public void deleteCart(int cartNo) throws Exception;
}
