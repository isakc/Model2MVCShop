package com.model2.mvc.service.purchase.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.common.TransactionStatus;
import com.model2.mvc.service.domain.OrderDetail;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService{

	///Field
	@Autowired
	@Qualifier("purchaseDaoImpl")
	private PurchaseDao purchaseDao;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	///Constructor
	public PurchaseServiceImpl() {
	}
	
	///Method
	public int addPurchase(Purchase purchase) throws Exception {
		return purchaseDao.addPurchase(purchase);
	}
	
	public void addOrderDetail(OrderDetail orderDetail) throws Exception {
		purchaseDao.addOrderDetail(orderDetail);
	}

	public Purchase findPurchase(int tranNo) throws Exception {
		Purchase purchase = purchaseDao.findPurchase(tranNo);
		User buyer = userService.getUser(purchase.getBuyer().getUserId());
		purchase.setBuyer(buyer);
		
		return purchaseDao.findPurchase(tranNo);
	}

	public Map<String, Object> getPurchaseList(Search search) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<Boolean> isDeliveredList = new ArrayList<Boolean>();
		ArrayList<String> statusList = new ArrayList<String>();
		List<Purchase> list =  purchaseDao.getPurchaseList(search);
		
		for(int i=0; i<list.size(); i++) {
			list.get(i).setBuyer(userService.getUser(list.get(i).getBuyer().getUserId()));
			if( !(list.get(i).getTranCode().equals(TransactionStatus.DELIVERED.getCode())) ) {
				isDeliveredList.add(true);
			}else {
				isDeliveredList.add(false);
			}
			
			statusList.add(TransactionStatus.getStatusByCode(list.get(i).getTranCode()));
		}
		
		map.put("statusList", statusList);
		map.put("isDeliveredList", isDeliveredList);
		map.put("list", list);
		map.put("totalCount", purchaseDao.getTotalCount(search));
		
		return map;
	}
	
	public List<OrderDetail> getOrderDetailList(int tranNo) throws Exception {
		
		List<OrderDetail> list = purchaseDao.getOrderDetailList(tranNo);
		
		for(int i=0; i<list.size(); i++) {
			list.get(i).setProduct(productService.findProduct(list.get(i).getProduct().getProdNo()));
			list.get(i).setTransaction(purchaseDao.findPurchase(list.get(i).getTransaction().getTranNo()));
		}
		
		return purchaseDao.getOrderDetailList(tranNo);
	}

	public Map<String, Object> getOrderDetailListByProdNo(int prodNo) throws Exception {
		
		ArrayList<String> statusList = new ArrayList<String>();
		List<OrderDetail> list = purchaseDao.getOrderDetailListByProdNo(prodNo);
		
		for(int i=0; i<list.size(); i++) {
			list.get(i).setProduct(productService.findProduct(list.get(i).getProduct().getProdNo())); 
			list.get(i).setTransaction(purchaseDao.findPurchase(list.get(i).getTransaction().getTranNo()));
		}
		
		for (int i = 0; i < list.size(); i++) {
			statusList.add(TransactionStatus.getStatusByCode(list.get(i).getTransaction().getTranCode()));
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("statusList", statusList);
		map.put("list", list);
		
		return map;
	}

	public void updatePurchase(Purchase purchase) throws Exception {
		purchaseDao.updatePurchase(purchase);
	}

	public void updateTranCode(Purchase purchase) throws Exception {
		purchaseDao.updateTranCode(purchase);
	}

	public void updateTranCodeByProd(Purchase purchase) throws Exception {
		purchaseDao.updateTranCodeByProd(purchase);
	}
}