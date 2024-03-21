package com.model2.mvc.web.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("/cart/*")
public class CartRestController {

	/// Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	/// Constructor
	public CartRestController() {
		System.out.println("==> Category default Constructor call");
	}

	@GetMapping("json/addCart/{prodNo}/{quantity}")
	public Map<String, Object> addCart(@PathVariable("prodNo") int prodNo, @PathVariable("quantity") int quantity, HttpSession session) throws Exception {

		System.out.println("/cart/json/addCart/{prodNo}/{quantity} : GET");
		Map<String, Object> map = new HashMap<String, Object>();
		
		User user = (User) session.getAttribute("user");
		
		Cart cart = new Cart();
		cart.setUser(user);
		cart.setProduct(new Product(prodNo));
		cart.setQuantity(quantity);
		
		try {
			cartService.addCart(cart);
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}

		return map;
	}

	@RequestMapping("json/listCart")
	public Map<String, Object> listCart(HttpSession session) throws Exception {

		System.out.println("/cart/json/listCart");
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User)session.getAttribute("user");
		List<Cart> listCart = cartService.getCartList(user.getUserId());
		
		try {
			map.put("listCart", listCart);
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}
		return map;
	}
	
	@RequestMapping("json/updateCart/{prodNo}/{cartNo}/{quantity}")
	public Map<String, Object> updateCart(@PathVariable("prodNo") int prodNo, @PathVariable("cartNo") int cartNo, @PathVariable("quantity") int quantity, HttpSession session) throws Exception {

		System.out.println("/update/json/updateCart");
		Map<String, Object> map = new HashMap<String, Object>();
		
		User user = (User)session.getAttribute("user");
		
		Cart cart = new Cart();
		cart.setUser(user);
		cart.setProduct(new Product(prodNo));
		cart.setQuantity(quantity);
		
		try {
			cartService.updateCart(cart);
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}
		
		return map;
	}
	
	@GetMapping("json/deleteCart/{cartNo}")
	public Map<String, Object> deleteCart(@PathVariable("cartNo") int cartNo) throws Exception{
		System.out.println("/cart/json/deleteCart/{cartNo}");
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			cartService.deleteCart(cartNo);
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}
		
		return map;
	}
}