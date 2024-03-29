package com.model2.mvc.service.product.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public void addProduct(Product product, List<String> fileNames, int categoryNo) throws Exception {
		product.setManuDate(product.getManuDate().replace("-", ""));
		
		Category category = new Category();
		category.setCategoryNo(categoryNo);
		product.setCategory(category);
		
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
				
		for(int i=0; i<images.size(); i++) {
			fileNames.add(images.get(i).getFileName());
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
	public Map<String, Object> getProductList(Search search, String sorter, Category category) throws Exception {
		if(sorter.contains("DESC")) {
			sorter = sorter.substring(0, sorter.indexOf("DESC"))+ " DESC";
		}else if(sorter.contains("ASC")) {
			sorter = sorter.substring(0, sorter.indexOf("ASC")) + " ASC";
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<Product> productList = productDao.getProductList(search, sorter, category);
		
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
		map.put("totalCount", productDao.getTotalCount(search, sorter, category));
		
		return map;
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		productDao.updateProduct(product);
	}

	@Override
	public void updateQuantity(int prodNo, int quantity) throws Exception {
		productDao.updateProductQuantity(prodNo, quantity);
	}
}