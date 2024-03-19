package com.model2.mvc.web.cart;

import java.util.List;

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
	public String addCart(@PathVariable("prodNo") int prodNo, @PathVariable("quantity") int quantity, HttpSession session) throws Exception {

		System.out.println("/cart/json/addCart/{prodNo}/{quantity} : GET");
		
		User user = (User) session.getAttribute("user");
		
		Cart cart = new Cart();
		cart.setUser(user);
		cart.setProduct(new Product(prodNo));
		cart.setQuantity(quantity);
		
		cartService.addCart(cart);

		return "redirect:/cart/listCart";
	}

	@RequestMapping("json/listCart")
	public String listCart(HttpSession session , Model model) throws Exception {

		System.out.println("/cart/json/listCart");
		User user = (User)session.getAttribute("user");
		List<Cart> listCart = cartService.getCartList(user.getUserId());
		
		model.addAttribute("listCart", listCart);
		return "forward:/cart/listCart.jsp";
	}
	
	@RequestMapping("json/updateCart/{prodNo}/{cartNo}/{quantity}")
	public String updateCart(@PathVariable("prodNo") int prodNo, @PathVariable("cartNo") int cartNo, @PathVariable("quantity") int quantity, HttpSession session) throws Exception {

		System.out.println("/update/json/updateCart");
		
		User user = (User)session.getAttribute("user");
		
		Cart cart = new Cart();
		cart.setUser(user);
		cart.setProduct(new Product(prodNo));
		cart.setQuantity(quantity);
		
		cartService.updateCart(cart);
		
		return "redirect:/cart/listCart";
	}
	
	@GetMapping("json/deleteCart/{cartNo}")
	public String deleteCart(@PathVariable("cartNo") int cartNo) throws Exception{
		System.out.println("/cart/json/deleteCart/{cartNo}");
		
		cartService.deleteCart(cartNo);
		
		return "redirect:/cart/listCart";
	}
}
