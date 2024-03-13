package com.model2.mvc.service.purchase.test;

import java.util.ArrayList;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
		"classpath:config/context-aspect.xml",
		"classpath:config/context-mybatis.xml",
		"classpath:config/context-transaction.xml" })
public class PurchaseServiceTest {

	// ==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	//@Test
	public void testAddPurchase() throws Exception {

		Purchase purchase = new Purchase();
		User user = new User();

		user.setUserId("user07");
		purchase.setBuyer(user);

		Product product = new Product();
		product.setProdNo(10001);
	}

	@Test
	public void testGetPurchase() throws Exception {

		Purchase purchase = new Purchase();

		purchase = purchaseService.findPurchase(10000);

		System.out.println(purchase);
		// ==> API 확인
		Assert.assertEquals("user07", purchase.getBuyer().getUserId());
		Assert.assertEquals("SCOTT", purchase.getBuyer().getUserName());
		Assert.assertEquals("1", purchase.getPaymentOption());
		Assert.assertEquals("SCOTT", purchase.getReceiverName());
	}
	
	//@Test
	public void testGetPurchaseList() throws Exception {

		Search search = new Search();
		search.setSearchKeyword("user07");
		search.setCurrentPage(1);
		search.setPageSize(3);
		Map<String, Object> map = purchaseService.getPurchaseList(search);
		
		ArrayList<Purchase> list =  (ArrayList<Purchase>) map.get("list");
		int totalCount = (Integer) map.get("totalCount");

		System.out.println(list);
		// ==> API 확인
		Assert.assertEquals(1, list.size());
		Assert.assertEquals(1, totalCount);
	}

	// @Test
	public void testUpdatePurchase() throws Exception {

		Purchase purchase = purchaseService.findPurchase(10000);

		Assert.assertEquals("1", purchase.getPaymentOption());
		Assert.assertEquals("SCOTT", purchase.getReceiverName());

		purchase.setPaymentOption("2");

		purchaseService.updatePurchase(purchase);

		purchase = purchaseService.findPurchase(10000);
		Assert.assertNotNull(purchase);

		// ==> console 확인
		System.out.println(purchase);

		// ==> API 확인
		Assert.assertEquals("2", purchase.getPaymentOption());
	}

	// @Test
	public void testUpdateTranCode() throws Exception {

		Purchase purchase = purchaseService.findPurchase(10000);

		Assert.assertEquals("SCOTT", purchase.getReceiverName());

		purchase.setTranCode("2");

		purchaseService.updateTranCode(purchase);

		purchase = purchaseService.findPurchase(10000);
		Assert.assertNotNull(purchase);

		// ==> console 확인
		System.out.println("purchase!!::" + purchase);

		// ==> API 확인
		Assert.assertEquals("2", purchase.getTranCode());
	}

	//@Test
	public void testupdateTranCodeByProd() throws Exception {

		Purchase purchase = purchaseService.findPurchase(10000);

		Assert.assertEquals("SCOTT", purchase.getReceiverName());

		purchase.setTranCode("2");

		purchaseService.updateTranCodeByProd(purchase);

		purchase = purchaseService.findPurchase(10000);
		Assert.assertNotNull(purchase);

		// ==> console 확인
		System.out.println("purchase!!::" + purchase);

		// ==> API 확인
		Assert.assertEquals("2", purchase.getTranCode());
	}
}