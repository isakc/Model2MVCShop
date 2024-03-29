package com.model2.mvc.service.purchase;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.OrderDetail;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao {
	
	//insert
	public int addPurchase(Purchase purchase) throws Exception;
	
	public void addOrderDetail(OrderDetail orderDetail) throws Exception;
	
	//selectOne
	public Purchase findPurchase(int tranNo) throws Exception;
	
	public int getTotalCount(Search search) throws Exception;
	
	//selectList
	public List<Purchase> getPurchaseList(Search search) throws Exception;
	
	public List<OrderDetail> getOrderDetailList(int tranNo) throws Exception;

	public List<OrderDetail> getOrderDetailListByProdNo(int prodNo) throws Exception;
	
	//update
	public void updatePurchase(Purchase purchase) throws Exception;
	
	public void updateTranCode(Purchase purchase) throws Exception;

	public void updateTranCodeByProd(Purchase purchase) throws Exception;
}
