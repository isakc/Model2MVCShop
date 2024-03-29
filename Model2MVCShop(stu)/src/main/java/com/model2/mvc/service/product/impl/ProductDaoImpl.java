package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.category.CategoryDao;
import com.model2.mvc.service.domain.Category;
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
	@Qualifier("categoryDaoImpl")
	private CategoryDao categoryDao;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public void setCategoryDao(CategoryDao categoryDao) {
		this.categoryDao = categoryDao;
	}

	public ProductDaoImpl() {
	}

	@Override
	public void insertProduct(Product product) throws Exception {
		sqlSession.insert("ProductMapper.insertProduct", product);
	}
	
	@Override
	public void insertProudctImage(ProductImage productImage) throws Exception {
		sqlSession.insert("ProductImageMapper.insertProductImage", productImage);
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
	public List<ProductImage> findProductImage(int prodNo) throws Exception {
		return sqlSession.selectList("ProductImageMapper.findProductImage", prodNo);
	}

	@Override
	public List<Product> getProductList(Search search, String sorter, Category category) throws Exception {
		List<Product> list = sqlSession.selectList("ProductMapper.getProductList", new HashMap<String, Object>(){{
			put("search", search);
			put("sorter", sorter);
			put("category", category);
		}});
		
		return list;
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		sqlSession.update("ProductMapper.updateProduct" ,product);
	}

	@Override
	public int getTotalCount(Search search, String sorter, Category category) throws Exception {
		return sqlSession.selectOne("ProductMapper.getTotalCount", new HashMap<String, Object>(){{
			put("search", search);
			put("sorter", sorter);
			put("category", category);
		}});
	}

	@Override
	public void updateProductQuantity(int prodNo, int quantity) throws Exception {
		sqlSession.update("ProductMapper.updateProductQuantity", new HashMap<String, Object>(){{
			put("prodNo", prodNo);
			put("quantity", quantity);
		}});
	}
}