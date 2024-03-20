package com.model2.mvc.web.purchase;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

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
	public ModelAndView addPurchaseView(@RequestParam("prodNo") List<Integer> prodNoList,
			@RequestParam("quantity") List<Integer> quantityList, @RequestParam("cartNo") List<Integer> cartNoList) throws Exception {

		System.out.println("/purchase/json/addPurchaseView : POST");
		
		List<Product> productList = new ArrayList<Product>();
		
		for(int i=0; i<prodNoList.size(); i++) {
			productList.add(productService.findProduct(prodNoList.get(i)));
			productList.get(i).setQuantity(quantityList.get(i));
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("productList", productList);
		modelAndView.addObject("cartNoList", cartNoList);
		modelAndView.setViewName("forward:/purchase/addPurchaseView.jsp");

		return modelAndView;
	}
	
	@PostMapping("json/addPurchase")
	public ModelAndView addPurchase(@ModelAttribute("purchase") Purchase purchase,
			@RequestParam("prodNo") List<Integer> prodNoList, @RequestParam("quantity") List<Integer> quantityList,
			@RequestParam("buyerId") String userId, @RequestParam(value="cartNo", required = false) List<Integer> cartNoList) throws Exception {

		System.out.println("/purchase/json/addPurchase POST");
		
		User user = new User();
		user.setUserId(userId);
		
		purchase.setBuyer(user);

		purchaseService.addPurchase(purchase);

		for (int i=0; i<prodNoList.size(); i++) {
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setTransaction(purchase);
			orderDetail.setProduct( new Product(prodNoList.get(i)) );
			orderDetail.setQuantity(quantityList.get(i));
			
			orderDetailService.insertOrderDetail(orderDetail);
			productService.updateQuantity(prodNoList.get(i), quantityList.get(i));
		}
		
		if(cartNoList != null) {
			for(Integer cartNo : cartNoList) {
				cartService.deleteCart(cartNo);
			}
		}

		purchase = purchaseService.findPurchase(purchase.getTranNo());

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("purchase", purchase);
		modelAndView.setViewName("forward:/purchase/addPurchaseResult.jsp");

		return modelAndView;
	}

	@RequestMapping("json/listPurchase")
	public ModelAndView getListPurchase(@ModelAttribute(value = "search") Search search, HttpSession session)
			throws Exception {

		System.out.println("/purchase/json/listPurchase : GET");

		User user = (User) session.getAttribute("user");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		if (search.getSearchCondition() == null) {
			search.setSearchCondition("");
		}

		search.setSearchKeyword(user.getUserId());
		search.setPageSize(pageSize);

		Map<String, Object> map = purchaseService.getPurchaseList(search);
		int total = ((Integer) map.get("totalCount")).intValue();
		Paginate resultPage = new Paginate(search.getCurrentPage(), total, pageUnit, pageSize);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("isDeliveredList", map.get("isDeliveredList"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("statusList", map.get("statusList"));
		modelAndView.addObject("search", search);

		modelAndView.setViewName("forward:/purchase/listPurchase.jsp");

		return modelAndView;
	}

	@GetMapping("json/getPurchase/{tranNo}")
	public ModelAndView getPurchase(@PathVariable("tranNo") int tranNo) throws Exception {

		System.out.println("/purchase/json/getPurchase/{tranNo} : GET");

		Purchase purchase = purchaseService.findPurchase(tranNo);
		List<OrderDetail> list = orderDetailService.getOrderDetailList(tranNo);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("purchase", purchase);
		modelAndView.addObject("list", list);
		modelAndView.setViewName("forward:/purchase/getPurchase.jsp");

		return modelAndView;
	}

	@RequestMapping("json/updatePurchase/{tranNo}")
	public ModelAndView updatePurchase(@PathVariable("tranNo") int tranNo) throws Exception {

		System.out.println("/purchase/json/updatePurchase/{tranNo} : GET");

		Purchase purchase = purchaseService.findPurchase(tranNo);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("purchase", purchase);
		modelAndView.setViewName("forward:/purchase/updatePurchase.jsp");

		return modelAndView;
	}

	@PostMapping("json/updatePurchase")
	public ModelAndView updatePurchase(@ModelAttribute("purchase") Purchase purchase, @RequestParam("userId") String userId) throws Exception {

		System.out.println("/purchase/json/updatePurchase");
		
		User user = new User();
		user.setUserId(userId);
		purchase.setBuyer(user);
		
		purchaseService.updatePurchase(purchase);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/purchase/getPurchase/" + purchase.getTranNo());

		return modelAndView;
	}

	@GetMapping("json/updateTranCode/{tranNo}/{tranCode}")
	public ModelAndView updateTranCode(@PathVariable("tranNo") int tranNo, @PathVariable("tranCode") String tranCode) throws Exception {

		System.out.println("/purchase/json/updateTranCode : GET");
		
		Purchase purchase = new Purchase();
		purchase.setTranNo(tranNo);
		purchase.setTranCode(tranCode);

		purchaseService.updateTranCode(purchase);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/listPurchase");

		return modelAndView;
	}

	@PostMapping("json/purchase/updateTranCodeByProd")
	public ModelAndView updateTranCodeByProd(@ModelAttribute("purchase") Purchase purchase,
			@RequestParam("prodNo") int prodNo) throws Exception {

		System.out.println("/purchase/json/updateTranCodeByProd");

		purchaseService.updateTranCodeByProd(purchase);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/product/listProduct/manage");

		return modelAndView;
	}
}