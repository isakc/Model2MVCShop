package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.Servlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Paginate;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.category.CategoryService;
import com.model2.mvc.service.domain.Category;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.orderDetail.OrderDetailService;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	/// Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	@Autowired
	@Qualifier("categoryServiceImpl")
	private CategoryService categoryService;
	
	@Autowired
	@Qualifier("orderDetailServiceImpl")
	private OrderDetailService orderDetailService;

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@Value("#{commonProperties['copy']}")
	String copy;
	
	/// Constructor
	public ProductController() {
		System.out.println("==> ProductController default Constructor call");
	}
	
	@GetMapping("addProduct")
	public String addProductView(Model model) throws Exception {

		System.out.println("/product/addProductView : GET");

		model.addAttribute("categoryList", categoryService.getCategoryList().get("list"));

		return "forward:/product/addProductView.jsp";
	}

	@PostMapping("addProduct")
	public String addProduct(@ModelAttribute("product") Product product, @RequestParam("categoryNo") int categoryNo, MultipartFile upload, Model model, HttpServletRequest request) throws Exception {

		System.out.println("/product/addProduct : POST");
		
		String root = request.getServletContext().getRealPath("/images/uploadFiles")+File.separator;
		UUID uuid = UUID.randomUUID();
		String fileName = uuid+"_"+upload.getOriginalFilename();
		File destFile = new File(root + fileName);
		upload.transferTo(destFile);
		
		product.setFileName(fileName);
		
		product.setManuDate(product.getManuDate().replace("-", ""));
		
		Category category = new Category();
		category.setCategoryNo(categoryNo);
		
		product.setCategory(category);

		productService.insertProduct(product);
		
		Product resultProduct = productService.findProduct(product.getProdNo());
		
		model.addAttribute("result", resultProduct);

		return "forward:/product/addProductView.jsp";
	}

	@GetMapping("getProduct/{prodNo}/{menu}")
	public String getProduct(@PathVariable("prodNo") int prodNo, @PathVariable("menu") String menu, Model model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("/product/getProduct : GET");
		
		Product findProduct = productService.findProduct(prodNo);

		model.addAttribute("product", findProduct);

		// 최근 본 상품 Cookie start
		Cookie[] cookies = request.getCookies();
		String value = null;

		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("history")) {
					value = cookies[i].getValue();
				}
			}
		}

		if (value == null || value.isEmpty()) {
			value = String.valueOf(prodNo);
		} else {
			if (!value.contains(String.valueOf(prodNo))) {
				value += "/" + String.valueOf(prodNo);
			}
		}

		Cookie cookie = new Cookie("history", value);
		cookie.setMaxAge(60 * 60);
		response.addCookie(cookie);

		if (menu.equals("manage")) {
			return "forward:/product/updateProduct/"+prodNo;
		} else {
			return "forward:/product/getProduct.jsp";
		}
	}

	@RequestMapping("listProduct/{menu}")
	public String getListProduct(@ModelAttribute(value = "search") Search search, Model model,
			@PathVariable("menu") String menu,
			@RequestParam(value = "searchKeyword2", defaultValue = "") String searchKeyword2,
			@RequestParam(value = "sorter", defaultValue = "") String sorter,
			@RequestParam(value = "preSearchCondition", defaultValue = "") String preSearchCondition,
			@RequestParam(value = "preSearchKeyword", defaultValue = "") String preSearchKeyword,
			@RequestParam(value = "categoryNo", defaultValue = "-1") int categoryNo) throws Exception {

		System.out.println("/product/listProduct GET/POST");

		if (search.getSearchCondition() != null && search.getSearchCondition().equals("2")) {
			search.setSearchKeyword(search.getSearchKeyword() + "-" + searchKeyword2);
		}

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		if (search.getSearchCondition() == null) {
			search.setSearchCondition("");
		}

		if (search.getSearchKeyword() == null) {
			search.setSearchKeyword("");
		}

		search.setPageSize(pageSize);

		Category category = categoryService.findCategory(categoryNo);
		HashMap<String, Object> resultMap = (HashMap) productService.getProductList(search, sorter, category);
		int total = ((Integer) resultMap.get("totalCount")).intValue();
		Paginate resultPage = new Paginate(search.getCurrentPage(), total, pageUnit, pageSize);
		
		model.addAttribute("menu", menu);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("list", resultMap.get("list"));
		model.addAttribute("search", search);
		model.addAttribute("sorter", sorter);
		model.addAttribute("categoryList", categoryService.getCategoryList().get("list"));
		model.addAttribute("selectedCategoryNo", categoryNo);
		
		if (search.getSearchCondition() != null && search.getSearchCondition().equals("2")) {
			model.addAttribute("searchPrice",
					search.getSearchKeyword().substring(0, search.getSearchKeyword().indexOf("-")));
			model.addAttribute("searchPrice2", searchKeyword2);
		}

		return "forward:/product/listProduct.jsp?menu=" + menu;
	}

	@GetMapping("updateProduct/{prodNo}")
	public String updateProduct(@PathVariable("prodNo") int prodNo, Model model) throws Exception {

		System.out.println("/product/updateProduct : GET");

		Product findProduct = productService.findProduct(prodNo);

		model.addAttribute("product", findProduct);
		model.addAttribute("categoryList", categoryService.getCategoryList().get("list"));

		return "forward:/product/updateProduct.jsp";
	}

	@PostMapping("updateProduct")
	public String updateProduct(@ModelAttribute("product") Product product, @RequestParam("categoryNo") int categoryNo, MultipartFile upload, 
			Model model, HttpServletRequest request) throws Exception {

		System.out.println("/product/updateProduct : POST");
		
		String root = request.getServletContext().getRealPath("/images/uploadFiles")+File.separator;
		UUID uuid = UUID.randomUUID();
		String fileName = uuid+"_"+upload.getOriginalFilename();
		File destFile = new File(root + fileName);
		upload.transferTo(destFile);
		product.setFileName(fileName);

		product.setManuDate(product.getManuDate().replace("-", ""));
		product.setCategory(categoryService.findCategory(categoryNo));

		productService.updateProduct(product);

		return "redirect:/product/getProduct/+" + product.getProdNo() + "/search";
	}
	
	@GetMapping("getOrderDetail/{prodNo}")
	public String getOrderDetail(@PathVariable("prodNo") int prodNo, Model model) throws Exception {

		System.out.println("/product/getOrderDetail");
		
		Map<String, Object> map = orderDetailService.getOrderDetailListByProdNo(prodNo);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("statusList", map.get("statusList"));
		
		return "forward:/product/orderDetail.jsp";
	}
}
