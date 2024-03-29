package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Category;
import com.model2.mvc.service.domain.Product;


public interface ProductService {
	
	//insert
	public void addProduct(Product product, List<String> fileNames, int categoryNo) throws Exception;
	
	//selectOne
	public Product findProduct(int prodNo) throws Exception;
	
	public Product findProductByProdName(String prodName) throws Exception;
	
	//selectList
	public Map<String, Object> getProductList(Search search, String sorter, Category category) throws Exception;
	
	//update
	public void updateProduct(Product product) throws Exception;
	
	public void updateQuantity(int prodNo, int quantity) throws Exception;
}