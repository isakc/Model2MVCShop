package com.model2.mvc.web.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.User;

@RestController
@RequestMapping("/cart/*")
public class CartRestController {

	/// Field
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	
	/// Constructor
	public CartRestController() {
		System.out.println("==> Category default Constructor call");
	}

	@PostMapping("json/addCart")
	public Map<String, Object> addCart(@RequestBody Cart cart, @SessionAttribute("user") User user) throws Exception {

		System.out.println("/cart/json/addCart/{prodNo}/{quantity} : POST");
		Map<String, Object> map = new HashMap<String, Object>();

		cart.setUser(user);
		
		try {
			cartService.addCart(cart);
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}

		return map;
	}

	@RequestMapping("json/listCart")
	public Map<String, Object> listCart(@SessionAttribute("user") User user) throws Exception {

		System.out.println("/cart/json/listCart");
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<Cart> listCart = cartService.getCartList(user.getUserId());
		
		try {
			map.put("listCart", listCart);
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}
		return map;
	}
	
	@PostMapping("json/updateCart")
	public Map<String, Object> updateCart(@RequestBody Cart cart, @SessionAttribute User user) throws Exception {

		System.out.println("/update/json/updateCart");
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			Cart dbCart = cartService.findCart(cart);
			dbCart.setUser(user);
			
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