package com.model2.mvc.web.cart;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.User;

@Controller
@RequestMapping("/cart/*")
public class CartController {

	///Field
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	
	/// Constructor
	public CartController() {
		System.out.println("==> Category default Constructor call");
	}

	@RequestMapping("listCart")
	public String listCart(HttpSession session , Model model) throws Exception {

		System.out.println("/cart/listCart");
		
		User user = (User)session.getAttribute("user");
		List<Cart> listCart = cartService.getCartList(user.getUserId());
		
		model.addAttribute("listCart", listCart);
		
		return "forward:/cart/listCart.jsp";
	}
}