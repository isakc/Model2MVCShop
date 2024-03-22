package com.model2.mvc.service.product;

import java.util.Map;
import java.util.Optional;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Category;
import com.model2.mvc.service.domain.Product;


public interface ProductService {
	
	public void insertProduct(Product product) throws Exception;
	
	public Product findProduct(int prodNo) throws Exception;
	
	public Product findProductByProdName(String prodName) throws Exception;
	
	public Map<String, Object> getProductList(Optional<Search> search) throws Exception;
	
	public void updateProduct(Product product) throws Exception;
	
	public void updateQuantity(int prodNo, int quantity) throws Exception;
}