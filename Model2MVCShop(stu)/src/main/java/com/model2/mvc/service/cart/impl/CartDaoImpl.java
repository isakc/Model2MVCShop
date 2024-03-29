package com.model2.mvc.service.cart.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.service.cart.CartDao;
import com.model2.mvc.service.domain.Cart;

@Repository("cartDaoImpl")
public class CartDaoImpl implements CartDao {

	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	///Constructor
	public CartDaoImpl() {
	}

	///Method
	public void addCart(Cart cart) throws Exception {
		sqlSession.insert("CartMapper.addCart", cart);
	}

	public Cart findCart(Cart cart) throws Exception {
		return sqlSession.selectOne("CartMapper.findCart", cart);
	}

	public List<Cart> getCartList(String userId) throws Exception {
		return sqlSession.selectList("CartMapper.getCartList", userId);
	}

	public void updateCart(Cart cart) throws Exception {
		sqlSession.update("CartMapper.updateCart", cart);
	}
	
	public void deleteCart(int cartNo) throws Exception{
		sqlSession.delete("CartMapper.deleteCart", cartNo);
	}
}