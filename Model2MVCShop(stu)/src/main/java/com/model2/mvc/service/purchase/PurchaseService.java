package com.model2.mvc.service.purchase;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.OrderDetail;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseService {
	
	//insert
	public int addPurchase(Purchase purchase) throws Exception;
	
	public void addOrderDetail(OrderDetail orderDetail) throws Exception;
	
	//selectOne
	public Purchase findPurchase(int tranNo) throws Exception;
	
	//selectList
	public Map<String, Object> getPurchaseList(Search search) throws Exception;
	
	public List<OrderDetail> getOrderDetailList(int tranNo) throws Exception;
	
	public Map<String, Object> getOrderDetailListByProdNo(int prodNo) throws Exception;
	
	//update
	public void updatePurchase(Purchase purchase) throws Exception;

	public void updateTranCode(Purchase purchase) throws Exception;

	public void updateTranCodeByProd(Purchase purchase) throws Exception;
}