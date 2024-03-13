package com.model2.mvc.service.orderDetail.impl;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.common.TransactionStatus;
import com.model2.mvc.service.domain.Category;
import com.model2.mvc.service.domain.OrderDetail;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.orderDetail.OrderDetailDao;
import com.model2.mvc.service.orderDetail.OrderDetailService;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseDao;

@Service("orderDetailServiceImpl")
public class OrderDetailServiceImpl implements OrderDetailService {

	/// Field
	@Autowired
	@Qualifier("orderDetailDaoImpl")
	private OrderDetailDao orderDetailDao;

	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;

	@Autowired
	@Qualifier("purchaseDaoImpl")
	private PurchaseDao purchaseDao;

	public OrderDetailServiceImpl() {
	}

	@Override
	public void insertOrderDetail(OrderDetail orderDetail) throws Exception {
		orderDetailDao.insertOrderDetail(orderDetail);
	}

	@Override
	public List<OrderDetail> getOrderDetailList(int tranNo) throws Exception {
		return orderDetailDao.getOrderDetailList(tranNo);
	}

	@Override
	public Map<String, Object> getOrderDetailListByProdNo(int prodNo) throws Exception {

		ArrayList<String> statusList = new ArrayList<String>();
		List<OrderDetail> list = orderDetailDao.getOrderDetailListByProdNo(prodNo);
		
		for (int i = 0; i < list.size(); i++) {
			statusList.add(TransactionStatus.getStatusByCode(list.get(i).getTransaction().getTranCode()));
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("statusList", statusList);
		map.put("list", list);
		return map;
	}
}