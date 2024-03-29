package com.model2.mvc.web.category;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.category.CategoryService;
import com.model2.mvc.service.domain.Category;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("/category/*")
public class CategoryRestController {

	/// Field
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

	/// Constructor
	public CategoryRestController() {
		System.out.println("==> Category default Constructor call");
	}
	
	@GetMapping("json/addCategory")
	public Map<String, Object> addCategory() throws Exception {

		System.out.println("category/json/addCategory");
		Map<String, Object> map = new HashMap<String, Object>();

		try {
			List<Category> list = (List<Category>) categoryService.getCategoryList().get("list");
			map.put("categoryList", list);
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}

		return map;
	}

	@PostMapping("json/addCategory")
	public Map<String, Object> addCategory(@RequestBody Category category) throws Exception {

		System.out.println("/category/json/addCategory");
		Map<String, Object> map = new HashMap<String, Object>();

		try {
			categoryService.addCategory(category);
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}

		return map;
	}
}