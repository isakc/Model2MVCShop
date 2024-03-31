package com.model2.mvc.web.product;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

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
	
	///Method
	@GetMapping("addProduct")
	public String addProductView(Model model) throws Exception {

		System.out.println("/product/addProductView : GET");

		model.addAttribute("categoryList", categoryService.getCategoryList().get("list"));

		return "forward:/product/addProductView.jsp";
	}

	@PostMapping("addProduct")
	public String addProduct(@ModelAttribute("product") Product product, @RequestParam("categoryNo") int categoryNo,
			List<MultipartFile> uploads, HttpServletRequest request) throws Exception {

		System.out.println("/product/addProduct : POST");

		product.setManuDate(product.getManuDate().replace("-", ""));
		Category category = new Category();
		category.setCategoryNo(categoryNo);
		product.setCategory(category);
		
		List<String> fileNames = new ArrayList<String>();
		
		 for (MultipartFile upload : uploads) {
			 String fileName = UUID.randomUUID()+"_"+upload.getOriginalFilename();
			 fileNames.add(fileName);
		     File destFile = new File(request.getServletContext().getRealPath("/images/uploadFiles")+File.separator + fileName);
		     upload.transferTo(destFile);
		 }

		productService.addProduct(product, fileNames);
		
		return "redirect:/product/getProduct/"+product.getProdNo()+"/search";
	}

	@GetMapping("getProduct/{prodNo}/{menu}")
	public String getProduct(@PathVariable("prodNo") int prodNo, @PathVariable("menu") String menu, Model model) throws Exception {

		System.out.println("/product/getProduct : GET");
		
		Product findProduct = productService.findProduct(prodNo);

		model.addAttribute("product", findProduct);

		if (menu.equals("manage")) {
			return "forward:/product/updateProduct/"+prodNo;
		} else {
			return "forward:/product/getProduct.jsp";
		}
	}

	@RequestMapping("listProduct/{menu}")
	public String getListProduct(@PathVariable("menu") String menu, @ModelAttribute Search search,
			@RequestParam(value="categoryNo", defaultValue = "-1") Integer categoryNo, Model model, HttpServletRequest request) throws Exception {

		System.out.println("/product/listProduct GET/POST");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		search.setPageSize(pageSize);
		Category category = categoryService.findCategory(categoryNo);
		search.setCategory(category);
		
		HashMap<String, Object> resultMap = (HashMap<String, Object>) productService.getProductList(search);
		Paginate resultPage = new Paginate(search.getCurrentPage(), ((Integer) resultMap.get("totalCount")).intValue(), pageUnit, pageSize);
		List<Product> history = productService.getRecentProduct(request);
		
		model.addAttribute("menu", menu);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("list", resultMap.get("list"));
		model.addAttribute("search", search);
		model.addAttribute("history", history);
		model.addAttribute("categoryList", categoryService.getCategoryList().get("list"));

		return "forward:/product/listProduct.jsp";
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
	public String updateProduct(@ModelAttribute("product") Product product, @RequestParam("categoryNo") int categoryNo, List<MultipartFile> uploads, 
			Model model, HttpServletRequest request) throws Exception {

		System.out.println("/product/updateProduct : POST");
		
		String root = request.getServletContext().getRealPath("/images/uploadFiles")+File.separator;
		List<String> fileNames = new ArrayList<String>();
		
		for (MultipartFile upload : uploads) {
			 UUID uuid = UUID.randomUUID();
		        
			 String fileName = uuid+"_"+upload.getOriginalFilename();
			 fileNames.add(fileName);
		     File destFile = new File(root + fileName);
		     upload.transferTo(destFile);
		 }
		
		product.setManuDate(product.getManuDate().replace("-", ""));
		product.setCategory(categoryService.findCategory(categoryNo));

		productService.updateProduct(product, fileNames);

		return "redirect:/product/getProduct/+" + product.getProdNo() + "/search";
	}
}