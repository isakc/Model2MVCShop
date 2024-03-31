package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.category.CategoryService;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.ProductImage;
import com.model2.mvc.service.product.ProductDao;

@Repository("productDaoImpl")
public class ProductDaoImpl implements ProductDao {
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	@Autowired
	@Qualifier("categoryServiceImpl")
	private CategoryService categoryService;

	///Constructor
	public ProductDaoImpl() {
	}

	///Method
	@Override
	public void addProduct(Product product) throws Exception {
		sqlSession.insert("ProductMapper.addProduct", product);
	}
	
	@Override
	public void addProductImage(ProductImage productImage) throws Exception {
		sqlSession.insert("ProductImageMapper.addProductImage", productImage);
	}

	@Override
	public Product findProduct(int prodNo) throws Exception {
		return sqlSession.selectOne("ProductMapper.findProduct", prodNo);
	}

	@Override
	public Product findProductByProdName(String prodName) throws Exception {
		return sqlSession.selectOne("ProductMapper.findProductByName", prodName);
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("ProductMapper.getTotalCount", search);
	}

	@Override
	public List<Product> getProductList(Search search) throws Exception {
		return sqlSession.selectList("ProductMapper.getProductList", search);
	}

	@Override
	public List<ProductImage> getProductImageList(int prodNo) throws Exception {
		return sqlSession.selectList("ProductImageMapper.getProductImageList", prodNo);
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		sqlSession.update("ProductMapper.updateProduct" ,product);
	}

	@Override
	public void updateProductQuantity(int prodNo, int quantity) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("prodNo", prodNo);
		map.put("quantity", quantity);
		
		sqlSession.update("ProductMapper.updateProductQuantity", map);
	}

	@Override
	public void deleteProductImage(int prodNo) throws Exception {
		sqlSession.delete("ProductImageMapper.deleteProductImage", prodNo);
	}
}