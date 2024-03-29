package com.model2.mvc.web.category;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.model2.mvc.service.category.CategoryService;
import com.model2.mvc.service.domain.Category;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/category/*")
public class CategoryController {

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
	public CategoryController() {
		System.out.println("==> Category default Constructor call");
	}
	
	@GetMapping("addCategory")
	public String addCategory(Model model) throws Exception {

		System.out.println("category/addCategory");

		model.addAttribute("categoryList", categoryService.getCategoryList().get("list"));

		return "forward:/category/addCategoryView.jsp";
	}

	@PostMapping("addCategory")
	public String addCategory(@ModelAttribute("category") Category category) throws Exception {

		System.out.println("/category/addCategory");

		categoryService.addCategory(category);

		return "redirect:/category/addCategory";
	}
}