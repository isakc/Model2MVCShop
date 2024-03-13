package com.model2.mvc.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/cart/*")
public class CartController {

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
	public CartController() {
		System.out.println("==> Category default Constructor call");
	}

	@GetMapping("addCart/{prodNo}/{quantity}")
	public String addCart(@PathVariable("prodNo") int prodNo, @PathVariable("quantity") int quantity, HttpSession session) throws Exception {

		System.out.println("/cart/addCart/{prodNo}/{quantity} : GET");
		
		User user = (User) session.getAttribute("user");
		
		Cart cart = new Cart();
		cart.setUser(user);
		cart.setProduct(new Product(prodNo));
		cart.setQuantity(quantity);
		
		cartService.addCart(cart);

		return "redirect:/cart/listCart";
	}

	@RequestMapping("listCart")
	public String listCart(HttpSession session , Model model) throws Exception {

		System.out.println("/cart/listCart");
		User user = (User)session.getAttribute("user");
		List<Cart> listCart = cartService.getCartList(user.getUserId());
		
		model.addAttribute("listCart", listCart);
		return "forward:/cart/listCart.jsp";
	}
	
	@RequestMapping("updateCart/{prodNo}/{cartNo}/{quantity}")
	public String updateCart(@PathVariable("prodNo") int prodNo, @PathVariable("cartNo") int cartNo, @PathVariable("quantity") int quantity, HttpSession session) throws Exception {

		System.out.println("/update/updateCart");
		
		User user = (User)session.getAttribute("user");
		
		Cart cart = new Cart();
		cart.setUser(user);
		cart.setProduct(new Product(prodNo));
		cart.setQuantity(quantity);
		
		cartService.updateCart(cart);
		
		return "redirect:/cart/listCart";
	}
	
	@GetMapping("deleteCart/{cartNo}")
	public String deleteCart(@PathVariable("cartNo") int cartNo) throws Exception{
		System.out.println("/cart/deleteCart/{cartNo}");
		
		cartService.deleteCart(cartNo);
		
		return "redirect:/cart/listCart";
	}
}
