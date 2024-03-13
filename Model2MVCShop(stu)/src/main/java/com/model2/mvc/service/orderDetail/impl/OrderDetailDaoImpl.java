package com.model2.mvc.service.orderDetail.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.category.CategoryDao;
import com.model2.mvc.service.domain.Category;
import com.model2.mvc.service.domain.OrderDetail;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.orderDetail.OrderDetailDao;
import com.model2.mvc.service.product.ProductDao;

@Repository("orderDetailDaoImpl")
public class OrderDetailDaoImpl implements OrderDetailDao {
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public OrderDetailDaoImpl() {
	}

	@Override
	public void insertOrderDetail(OrderDetail orderDetail) throws Exception {
		sqlSession.insert("OrderDetailMapper.insertOrderDetail", orderDetail);
	}

	@Override
	public List<OrderDetail> getOrderDetailList(int tranNo) throws Exception {
		List<OrderDetail> list = sqlSession.selectList("OrderDetailMapper.findProductList", tranNo);
		
		for(int i=0; i<list.size(); i++) {
			list.get(i).setProduct(sqlSession.selectOne("ProductMapper.findProduct", list.get(i).getProduct().getProdNo()));
			list.get(i).setTransaction(sqlSession.selectOne("PurchaseMapper.findPurchase", list.get(i).getTransaction().getTranNo()));
		}
		
		return list;
	}

	public List<OrderDetail> getOrderDetailListByProdNo(int prodNo) throws Exception {
		List<OrderDetail> list = sqlSession.selectList("OrderDetailMapper.findProductListByProdNo", prodNo);
		
		for(int i=0; i<list.size(); i++) {
			list.get(i).setProduct(sqlSession.selectOne("ProductMapper.findProduct", list.get(i).getProduct().getProdNo()));
			list.get(i).setTransaction(sqlSession.selectOne("PurchaseMapper.findPurchase", list.get(i).getTransaction().getTranNo()));
		}
		
		return list;
	}
}