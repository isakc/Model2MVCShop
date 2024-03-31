package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

public interface ProductService {
	
	//insert
	public void addProduct(Product product, List<String> fileNames) throws Exception;
	
	//selectOne
	public Product findProduct(int prodNo) throws Exception;
	
	public Product findProductByProdName(String prodName) throws Exception;
	
	//selectList
	public Map<String, Object> getProductList(Search search) throws Exception;
	
	//update
	public void updateProduct(Product product, List<String> fileNames) throws Exception;
	
	public void updateQuantity(int prodNo, int quantity) throws Exception;
	
	//delete
	public void deleteProductImage(int prodNo) throws Exception;
	
	//etc
	public List<Product> getRecentProduct(HttpServletRequest request) throws Exception;
}