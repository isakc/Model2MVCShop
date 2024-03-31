package com.model2.mvc.service.product.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.category.CategoryService;
import com.model2.mvc.service.domain.Category;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.ProductImage;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService {
	
	///Field
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;
	
	@Autowired
	@Qualifier("categoryServiceImpl")
	private CategoryService categoryService;

	///Constructor
	public ProductServiceImpl() {
	}

	///Method
	@Override
	public void addProduct(Product product, List<String> fileNames) throws Exception {
		productDao.addProduct(product);
		
		for(int i=0; i<fileNames.size(); i++) {
			ProductImage image = new ProductImage();
			image.setFileName(fileNames.get(i));
			image.setProdNo(product.getProdNo());
			productDao.addProductImage(image);
		}
	}

	@Override
	public Product findProduct(int prodNo) throws Exception {
		Product product = productDao.findProduct(prodNo);
		
		Category category = categoryService.findCategory(product.getCategory().getCategoryNo());
		product.setCategory(category);
		
		List<ProductImage> images = productDao.getProductImageList(prodNo);
		List<String> fileNames = new ArrayList<String>();
				
		for(ProductImage image: images) {
			fileNames.add(image.getFileName());
		}
		
		product.setFileNames(fileNames);
		
		return product;
	}

	@Override
	public Product findProductByProdName(String prodName) throws Exception {
		Product product = productDao.findProductByProdName(prodName);
		Category category = categoryService.findCategory(product.getCategory().getCategoryNo());
		product.setCategory(category);
		
		List<ProductImage> images = productDao.getProductImageList(product.getProdNo());
		List<String> fileNames = new ArrayList<String>();
				
		for(int i=0; i<images.size(); i++) {
			fileNames.add(images.get(i).getFileName());
		}
		
		product.setFileNames(fileNames);
		
		return product;
	}

	@Override
	public Map<String, Object> getProductList(Search search) throws Exception {
		String sorter = search.getSorter();
		
		if(sorter != null && sorter.contains("DESC")) {
			sorter = sorter.trim().substring(0, sorter.indexOf("DESC"))+ " DESC";
		}else if(sorter != null && sorter.contains("ASC")) {
			sorter = sorter.trim().substring(0, sorter.indexOf("ASC")) + " ASC";
		}
		
		search.setSorter(sorter);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<Product> productList = productDao.getProductList(search);
		
		for(Product product : productList) {
			Category productCategory = categoryService.findCategory(product.getCategory().getCategoryNo());
			product.setCategory(productCategory);
			
			List<ProductImage> images = productDao.getProductImageList(product.getProdNo());
			List<String> fileNames = new ArrayList<String>();
					
			for(int i=0; i<images.size(); i++) {
				fileNames.add(images.get(i).getFileName());
			}
			
			product.setFileNames(fileNames);
		}//product category ³Ö±â
		
		map.put("list", productList);
		map.put("totalCount", productDao.getTotalCount(search));
		
		return map;
	}

	@Override
	public void updateProduct(Product product, List<String> fileNames) throws Exception {
		productDao.updateProduct(product);
		
		deleteProductImage(product.getProdNo());
		
		for(int i=0; i<fileNames.size(); i++) {
			ProductImage image = new ProductImage();
			image.setFileName(fileNames.get(i));
			image.setProdNo(product.getProdNo());
			productDao.addProductImage(image);
		}
	}

	@Override
	public void updateQuantity(int prodNo, int quantity) throws Exception {
		productDao.updateProductQuantity(prodNo, quantity);
	}
	
	@Override
	public void deleteProductImage(int prodNo) throws Exception {
		productDao.deleteProductImage(prodNo);
	}

	@Override
	public List<Product> getRecentProduct(HttpServletRequest request) throws Exception {
		Cookie[] cookies = request.getCookies();
		List<Product> recentProductList = new ArrayList<Product>();
		String history = null;
		
		if (cookies!=null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				
				if (cookie.getName().equals("history")) {
					history = cookie.getValue();
				}
			}
		}
		
		if(history != null) {
			for(String prodNo : history.split("/")) {
				recentProductList.add(findProduct(Integer.parseInt(prodNo)));
			}
		}
		
		return recentProductList;
	}
}