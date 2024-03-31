package com.model2.mvc.service.product;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.ProductImage;

public interface ProductDao {
	
	//insert
	public void addProduct(Product product) throws Exception ;
	
	public void addProductImage(ProductImage productImage) throws Exception;
	
	//selectOne
	public Product findProduct(int prodNo) throws Exception ;

	public Product findProductByProdName(String prodName) throws Exception ;
	
	public int getTotalCount(Search search) throws Exception ;

	//selectList
	public List<Product> getProductList(Search search) throws Exception ;
	
	public List<ProductImage> getProductImageList(int prodNo) throws Exception ;

	//update
	public void updateProduct(Product product) throws Exception ;

	public void updateProductQuantity(int prodNo, int quantity) throws Exception ;
	
	//delete
	public void deleteProductImage(int prodNo) throws Exception ;
}