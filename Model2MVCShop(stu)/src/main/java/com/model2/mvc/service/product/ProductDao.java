package com.model2.mvc.service.product;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Category;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.ProductImage;

public interface ProductDao {
	
	public void insertProduct(Product product) throws Exception ;
	
	public void insertProudctImage(ProductImage productImage) throws Exception;
	
	// SELECT ONE
	public Product findProduct(int prodNo) throws Exception ;

	public Product findProductByProdName(String prodName) throws Exception ;
	
	public List<ProductImage> findProductImage(int prodNo) throws Exception ;

	// SELECT LIST
	public List<Product> getProductList(Search search, String sorter, Category category) throws Exception ;

	// UPDATE
	public void updateProduct(Product product) throws Exception ;

	public void updateProductQuantity(int prodNo, int quantity) throws Exception ;
	
	//ÃÑ °¹¼ö
	public int getTotalCount(Search search, String sorter, Category category) throws Exception ;
}
