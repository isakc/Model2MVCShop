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
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService{

	///Field
	@Autowired
	@Qualifier("purchaseDaoImpl")
	private PurchaseDao purchaseDao;
	
	///Method
	public int addPurchase(Purchase purchase) throws Exception {
		return purchaseDao.insertPurchase(purchase);
	}

	public Purchase findPurchase(int tranNo) throws Exception {
		return purchaseDao.findPurchase(tranNo);
	}

	public Map<String, Object> getPurchaseList(Search search) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<Boolean> isDeliveredList = new ArrayList<Boolean>();
		ArrayList<String> statusList = new ArrayList<String>();
		List<Purchase> list =  purchaseDao.getPurchaseList(search);
		
		for(int i=0; i<list.size(); i++) {
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