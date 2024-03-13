package com.model2.mvc.service.cart.impl;

import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.user.UserDao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.cart.CartDao;
import com.model2.mvc.service.cart.CartService;

@Service("cartServiceImpl")
public class CartServiceImpl implements CartService {
	
	@Autowired
	@Qualifier("cartDaoImpl")
	private CartDao cartDao;
	
	@Autowired
	@Qualifier("userDaoImpl")
	private UserDao userDao;
	
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;
	
	public CartServiceImpl() {
	}

	public void addCart(Cart cart) throws Exception {
		Cart dbCart = cartDao.findCart(cart);
		if(dbCart == null) {
			cartDao.insertCart(cart);
		}else {
			cart.setQuantity(cart.getQuantity()+1);
			cartDao.updateCart(cart);
		}
	}

	public List<Cart> getCartList(String userId) throws Exception {
		List<Cart> cartList = cartDao.getCartList(userId);
		
		for(int i=0; i<cartList.size(); i++) {
			cartList.get(i).setProduct(productDao.findProduct(cartList.get(i).getProduct().getProdNo()));
			cartList.get(i).setUser(userDao.findUser(userId));
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