package com.model2.mvc.web.product;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Paginate;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.category.CategoryService;
import com.model2.mvc.service.domain.Category;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.orderDetail.OrderDetailService;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {

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
	
	/// Constructor
	public ProductRestController() {
		System.out.println("==> ProductController default Constructor call");
	}
	
	@GetMapping("json/addProduct")
	public Map<String, Object> addProductView() throws Exception {

		System.out.println("/product/json/addProduct : GET");

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			ArrayList<Category> list = (ArrayList<Category>) categoryService.getCategoryList().get("list");
			map.put("message", "ok");
			map.put("list", list);
		}catch (Exception e) {
			map.put("message", "fail");
		}
		
		return map;
	}

	@PostMapping("json/addProduct")
	public Map<String, Object> addProduct(@RequestPart MultipartFile upload, @RequestPart Product product,
			@RequestParam int categoryNo, HttpServletRequest request) throws Exception {

		System.out.println("/product/json/addProduct : POST");

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			String root = request.getServletContext().getRealPath("/images/uploadFiles")+File.separator;
			UUID uuid = UUID.randomUUID();
			String fileName = uuid+"_"+upload.getOriginalFilename();
			File destFile = new File(root + fileName);
			upload.transferTo(destFile);
			//product.setFileName(fileName);
			
			if(product.getManuDate() != null) {
				product.setManuDate(product.getManuDate().replace("-", ""));
			}
			
			Category category = new Category();
			category.setCategoryNo(categoryNo);
			
			product.setCategory(category);

			//productService.insertProduct(product);
			
			Product resultProduct = productService.findProduct(product.getProdNo());
			
			map.put("message", "ok");
			map.put("result", resultProduct);
		}catch (Exception e) {
			map.put("message", "fail");
		}
		
		return map;
	}

	@GetMapping("json/getProduct/{prodNo}/{menu}")
	public Map<String, Object> getProduct(@PathVariable("prodNo") int prodNo, @PathVariable("menu") String menu,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("/product/json/getProduct : GET");

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			Product findProduct = productService.findProduct(prodNo);
			map.put("message", "ok");
			map.put("product", findProduct);
			
		}catch (Exception e) {
			map.put("message", "fail");
		}

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
		
		return map;
	}

	@RequestMapping("json/listProduct/{menu}")
	public Map<String, Object> getListProduct(@RequestBody Search search,
			@PathVariable("menu") String menu,
			@RequestParam(value = "searchKeyword2", defaultValue = "") String searchKeyword2,
			@RequestParam(value = "sorter", defaultValue = "") String sorter,
			@RequestParam(value = "preSearchCondition", defaultValue = "") String preSearchCondition,
			@RequestParam(value = "preSearchKeyword", defaultValue = "") String preSearchKeyword,
			@RequestParam(value = "categoryNo", defaultValue = "-1") int categoryNo) throws Exception {

		System.out.println("/product/json/listProduct GET/POST");

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

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			Category category = categoryService.findCategory(categoryNo);
			HashMap<String, Object> resultMap = (HashMap<String, Object>) productService.getProductList(search, sorter, category);
			int total = ((Integer) resultMap.get("totalCount")).intValue();
			Paginate resultPage = new Paginate(search.getCurrentPage(), total, pageUnit, pageSize);
			
			map.put("message", "ok");
			map.put("menu", menu);
			map.put("resultPage", resultPage);
			map.put("list", resultMap.get("list"));
			map.put("search", search);
			map.put("sorter", sorter);
			map.put("categoryList", categoryService.getCategoryList().get("list"));
			map.put("selectedCategoryNo", categoryNo);
			
			if (search.getSearchCondition() != null && search.getSearchCondition().equals("2")) {
				map.put("searchPrice", search.getSearchKeyword().substring(0, search.getSearchKeyword().indexOf("-")));
				map.put("searchPrice2", searchKeyword2);
			}
			
		}catch (Exception e) {
			map.put("message", "fail");
		}

		return map;
	}

	@GetMapping("json/updateProduct/{prodNo}")
	public Map<String, Object> updateProduct(@PathVariable("prodNo") int prodNo) throws Exception {

		System.out.println("/product/json/updateProduct : GET");

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			Product findProduct = productService.findProduct(prodNo);
			
			map.put("message", "ok");
			map.put("product", findProduct);
			map.put("categoryList", categoryService.getCategoryList().get("list"));
		}catch (Exception e) {
			map.put("message", "fail");
		}

		return map;
	}

	@PostMapping("json/updateProduct")
	public Map<String, Object> updateProduct(@RequestPart MultipartFile upload, @RequestPart Product product,
											@RequestParam int categoryNo, HttpServletRequest request) throws Exception {

		System.out.println("/product/json/updateProduct : POST");
		
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String root = request.getServletContext().getRealPath("/images/uploadFiles")+File.separator;
			UUID uuid = UUID.randomUUID();
			String fileName = uuid+"_"+upload.getOriginalFilename();
			File destFile = new File(root + fileName);
			upload.transferTo(destFile);
			//product.setFileName(fileName);
			
			if(product.getManuDate() != null) {
				product.setManuDate(product.getManuDate().replace("-", ""));
			}
			product.setCategory(categoryService.findCategory(categoryNo));
			
			productService.updateProduct(product);
			
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}
		
		return map;
	}
	
	@GetMapping("json/getOrderDetail/{prodNo}")
	public Map<String, Object> getOrderDetail(@PathVariable("prodNo") int prodNo) throws Exception {

		System.out.println("/product/json/getOrderDetail");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			Map<String, Object> mapList = orderDetailService.getOrderDetailListByProdNo(prodNo);
			
			map.put("message", "ok");
			map.put("list", mapList.get("list"));
			map.put("statusList", mapList.get("statusList"));
		}catch (Exception e) {
			map.put("message", "fail");
		}
		
		return map;
	}
}