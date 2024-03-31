package com.model2.mvc.web.product;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
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
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {

	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	@Autowired
	@Qualifier("categoryServiceImpl")
	private CategoryService categoryService;

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	///Constructor
	public ProductRestController() {
		System.out.println("==> ProductController default Constructor call");
	}
	
	///Method
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
	public Map<String, Object> addProduct(@RequestPart List<MultipartFile> uploads, @RequestPart Product product,
			@RequestParam int categoryNo, HttpServletRequest request) throws Exception {

		System.out.println("/product/json/addProduct : POST");

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			List<String> fileNames = new ArrayList<String>();
			
			 for (MultipartFile upload : uploads) {
				 String fileName = UUID.randomUUID()+"_"+upload.getOriginalFilename();
				 fileNames.add(fileName);
			     File destFile = new File(request.getServletContext().getRealPath("/images/uploadFiles")+File.separator + fileName);
			     upload.transferTo(destFile);
			 }

			productService.addProduct(product, fileNames);
			
			map.put("message", "ok");
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
	public Map<String, Object> getListProduct(@RequestBody Search search, @PathVariable("menu") String menu) throws Exception {

		System.out.println("/product/json/listProduct GET/POST");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		search.setPageSize(pageSize);
		Category category = categoryService.findCategory(search.getCategory().getCategoryNo());
		search.setCategory(category);

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			HashMap<String, Object> resultMap = (HashMap<String, Object>) productService.getProductList(search);
			int total = ((Integer) resultMap.get("totalCount")).intValue();
			Paginate resultPage = new Paginate(search.getCurrentPage(), total, pageUnit, pageSize);
			
			map.put("message", "ok");
			map.put("menu", menu);
			map.put("resultPage", resultPage);
			map.put("list", resultMap.get("list"));
			map.put("search", search);
			map.put("categoryList", categoryService.getCategoryList().get("list"));
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
	public Map<String, Object> updateProduct(@RequestPart List<MultipartFile> uploads, @RequestPart Product product,
											@RequestParam int categoryNo, HttpServletRequest request) throws Exception {

		System.out.println("/product/json/updateProduct : POST");
		
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			List<String> fileNames = new ArrayList<String>();
			
			 for (MultipartFile upload : uploads) {
				 String fileName = UUID.randomUUID()+"_"+upload.getOriginalFilename();
				 fileNames.add(fileName);
			     File destFile = new File(request.getServletContext().getRealPath("/images/uploadFiles")+File.separator + fileName);
			     upload.transferTo(destFile);
			 }
			
			if(product.getManuDate() != null) {
				product.setManuDate(product.getManuDate().replace("-", ""));
			}
			product.setCategory(categoryService.findCategory(categoryNo));
			
			productService.updateProduct(product, fileNames);
			
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}
		
		return map;
	}
}