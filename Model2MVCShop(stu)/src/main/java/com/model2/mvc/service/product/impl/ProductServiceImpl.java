package com.model2.mvc.service.product.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.category.CategoryDao;
import com.model2.mvc.service.domain.Category;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.ProductImage;
import com.model2.mvc.service.orderDetail.OrderDetailDao;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService {
	
	///Field
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;
	
	@Autowired
	@Qualifier("categoryDaoImpl")
	private CategoryDao categoryDao;
	
	@Autowired
	@Qualifier("orderDetailDaoImpl")
	private OrderDetailDao orderDetailDao;

	public ProductServiceImpl() {
	}

	@Override
	public void insertProduct(Product product, List<String> fileNames) throws Exception {
		productDao.insertProduct(product);
		
		for(int i=0; i<fileNames.size(); i++) {
			ProductImage image = new ProductImage();
			image.setFileName(fileNames.get(i));
			image.setProdNo(product.getProdNo());
			productDao.insertProudctImage(image);
		}
	}

	@Override
	public Product findProduct(int prodNo) throws Exception {
		Product product = productDao.findProduct(prodNo);
		
		Category category = categoryDao.findCategory(product.getCategory().getCategoryNo());
		product.setCategory(category);
		
		List<ProductImage> images = productDao.findProductImage(prodNo);
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
		Category category = categoryDao.findCategory(product.getCategory().getCategoryNo());
		product.setCategory(category);
		
		List<ProductImage> images = productDao.findProductImage(product.getProdNo());
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
			Category productCategory = categoryDao.findCategory(product.getCategory().getCategoryNo());
			product.setCategory(productCategory);
			
			List<ProductImage> images = productDao.findProductImage(product.getProdNo());
			List<String> fileNames = new ArrayList<String>();
					
			for(int i=0; i<images.size(); i++) {
				fileNames.add(images.get(i).getFileName());
			}
			
			product.setFileNames(fileNames);
		}//product category �ֱ�
		
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