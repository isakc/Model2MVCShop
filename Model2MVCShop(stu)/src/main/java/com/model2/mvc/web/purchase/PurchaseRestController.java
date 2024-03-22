package com.model2.mvc.web.purchase;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.model2.mvc.common.Paginate;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.OrderDetail;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.orderDetail.OrderDetailService;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {

	/// Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	@Autowired
	@Qualifier("orderDetailServiceImpl")
	private OrderDetailService orderDetailService;

	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	/// Constructor
	public PurchaseRestController() {
		System.out.println("==> PurchaseController default Constructor call");
	}

	@PostMapping("json/addPurchaseView")
	public Map<String, Object> addPurchaseView(@RequestParam List<Integer> prodNoList,
			@RequestParam List<Integer> quantityList, @RequestParam List<Integer> cartNoList) throws Exception {

		System.out.println("/purchase/json/addPurchaseView : POST");
		Map<String, Object> map = new HashMap<String, Object>();
		List<Product> productList = new ArrayList<Product>();

		try {
			for (int i = 0; i < prodNoList.size(); i++) {
				productList.add(productService.findProduct(prodNoList.get(i)));
				productList.get(i).setQuantity(quantityList.get(i));
			}

			map.put("message", "ok");
			map.put("productList", productList);
			map.put("cartNoList", cartNoList);
		} catch (Exception e) {
			map.put("message", "fail");
		}

		return map;
	}

	@PostMapping("json/addPurchase")
	public Map<String, Object> addPurchase(@RequestBody Purchase purchase, @RequestParam List<Integer> prodNoList,
			@RequestParam List<Integer> quantityList, @RequestParam String userId,
			@RequestParam(value = "cartNo", required = false) List<Integer> cartNoList) throws Exception {

		System.out.println("/purchase/json/addPurchase POST");
		Map<String, Object> map = new HashMap<String, Object>();

		User user = new User();
		user.setUserId(userId);

		purchase.setBuyer(user);

		try {
			purchaseService.addPurchase(purchase);

			for (int i = 0; i < prodNoList.size(); i++) {
				OrderDetail orderDetail = new OrderDetail();
				orderDetail.setTransaction(purchase);
				orderDetail.setProduct(new Product(prodNoList.get(i)));
				orderDetail.setQuantity(quantityList.get(i));

				orderDetailService.insertOrderDetail(orderDetail);
				productService.updateQuantity(prodNoList.get(i), quantityList.get(i));
			}

			if (cartNoList != null) {
				for (Integer cartNo : cartNoList) {
					cartService.deleteCart(cartNo);
				}
			}

			purchase = purchaseService.findPurchase(purchase.getTranNo());

			map.put("message", "ok");
			map.put("purchase", purchase);
		} catch (Exception e) {
			map.put("message", "fail");
		}

		return map;
	}

	@RequestMapping("json/listPurchase")
	public Map<String, Object> getListPurchase(@RequestBody Search search, @SessionAttribute("user") User user)
			throws Exception {

		System.out.println("/purchase/json/listPurchase : GET");
		Map<String, Object> map = new HashMap<String, Object>();

		//User user = (User) session.getAttribute("user");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		if (search.getSearchCondition() == null) {
			search.setSearchCondition("");
		}

		search.setSearchKeyword(user.getUserId());
		search.setPageSize(pageSize);

		try {
			Map<String, Object> returnMap = purchaseService.getPurchaseList(search);
			int total = ((Integer) returnMap.get("totalCount")).intValue();
			Paginate resultPage = new Paginate(search.getCurrentPage(), total, pageUnit, pageSize);
			
			map.put("message", "ok");
			map.put("list", returnMap.get("list"));
			map.put("isDeliveredList", returnMap.get("isDeliveredList"));
			map.put("resultPage", resultPage);
			map.put("statusList", returnMap.get("statusList"));
			map.put("search", search);
		}catch (Exception e) {
			map.put("message", "fail");
		}

		return map;
	}

	@GetMapping("json/getPurchase/{tranNo}")
	public Map<String, Object> getPurchase(@PathVariable("tranNo") int tranNo) throws Exception {

		System.out.println("/purchase/json/getPurchase/{tranNo} : GET");
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			Purchase purchase = purchaseService.findPurchase(tranNo);
			List<OrderDetail> list = orderDetailService.getOrderDetailList(tranNo);
			
			map.put("message", "ok");
			map.put("purchase", purchase);
			map.put("list", list);
		}catch (Exception e) {
			map.put("message", "fail");
		}

		return map;
	}

	@GetMapping("json/updatePurchase/{tranNo}")
	public Map<String, Object> updatePurchase(@PathVariable("tranNo") int tranNo) throws Exception {

		System.out.println("/purchase/json/updatePurchase/{tranNo} : GET");
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			Purchase purchase = purchaseService.findPurchase(tranNo);
			
			map.put("message", "ok");
			map.put("purchase", purchase);
		}catch (Exception e) {
			map.put("message", "fail");
		}

		return map;
	}

	@PostMapping("json/updatePurchase")
	public Map<String, Object> updatePurchase(@RequestBody Purchase purchase,
			@RequestParam String userId) throws Exception {

		System.out.println("/purchase/json/updatePurchase");

		Map<String, Object> map = new HashMap<String, Object>();
		
		User user = new User();
		user.setUserId(userId);
		purchase.setBuyer(user);

		try {
			purchaseService.updatePurchase(purchase);
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}

		return map;
	}

	@GetMapping("json/updateTranCode/{tranNo}/{tranCode}")
	public Map<String, Object> updateTranCode(@PathVariable("tranNo") int tranNo,
			@PathVariable("tranCode") String tranCode) throws Exception {

		System.out.println("/purchase/json/updateTranCode : GET");
		Map<String, Object> map = new HashMap<String, Object>();

		Purchase purchase = new Purchase();
		purchase.setTranNo(tranNo);
		purchase.setTranCode(tranCode);
		
		try {
			purchaseService.updateTranCode(purchase);
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}

		return map;
	}

	@PostMapping("json/purchase/updateTranCodeByProd")
	public Map<String, Object> updateTranCodeByProd(@RequestBody Purchase purchase,
			@RequestParam int prodNo) throws Exception {

		System.out.println("/purchase/json/updateTranCodeByProd");
		Map<String, Object> map = new HashMap<String, Object>();

		try {
			purchaseService.updateTranCodeByProd(purchase);
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}

		return map;
	}
}