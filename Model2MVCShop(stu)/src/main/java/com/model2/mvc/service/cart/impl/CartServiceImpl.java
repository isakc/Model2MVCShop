package com.model2.mvc.service.cart.impl;

import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.cart.CartDao;
import com.model2.mvc.service.cart.CartService;

@Service("cartServiceImpl")
public class CartServiceImpl implements CartService {
	
	///Field
	@Autowired
	@Qualifier("cartDaoImpl")
	private CartDao cartDao;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	///Constructor
	public CartServiceImpl() {
	}

	///Method
	public void addCart(Cart cart) throws Exception {
		Cart dbCart = cartDao.findCart(cart);
		
		if(dbCart == null) {
			cartDao.addCart(cart);
		}else {
			cart.setQuantity(cart.getQuantity()+1);
			cartDao.updateCart(cart);
		}
	}

	@Override
	public Cart findCart(Cart cart) throws Exception {
		return cartDao.findCart(cart);
	}

	public List<Cart> getCartList(String userId) throws Exception {
		List<Cart> cartList = cartDao.getCartList(userId);
		
		for(int i=0; i<cartList.size(); i++) {
			cartList.get(i).setProduct(productService.findProduct(cartList.get(i).getProduct().getProdNo()));
			cartList.get(i).setUser(userService.getUser(userId));
		}
		
		return cartList;
	}

	public void updateCart(Cart cart) throws Exception {
		cartDao.updateCart(cart);
	}
	
	public void deleteCart(int cartNo) throws Exception{
		cartDao.deleteCart(cartNo);
	}
}