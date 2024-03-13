package com.model2.mvc.service.orderDetail;

import java.util.List;
import java.util.Map;

import com.model2.mvc.service.domain.Category;
import com.model2.mvc.service.domain.OrderDetail;

public interface OrderDetailDao {

	public void insertOrderDetail(OrderDetail orderDetail) throws Exception;
	
	public List<OrderDetail> getOrderDetailList(int tranNo) throws Exception;

	public List<OrderDetail> getOrderDetailListByProdNo(int prodNo) throws Exception;
}