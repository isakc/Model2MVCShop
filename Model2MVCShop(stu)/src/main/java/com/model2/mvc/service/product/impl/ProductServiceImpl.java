package com.model2.mvc.service.product.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.common.TransactionStatus;
import com.model2.mvc.service.domain.Category;
import com.model2.mvc.service.domain.OrderDetail;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.orderDetail.OrderDetailDao;
import com.model2.mvc.service.orderDetail.OrderDetailService;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService {
	
	///Field
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;
	
	@Autowired
	@Qualifier("orderDetailDaoImpl")
	private OrderDetailDao orderDetailDao;

	public ProductServiceImpl() {
	}

	@Override
	public void insertProduct(Product product) throws Exception {
		productDao.insertProduct(product);
	}

	@Override
	public Product findProduct(int prodNo) throws Exception {
		return productDao.findProduct(prodNo);
	}

	@Override
	public Product findProductByProdName(String prodName) throws Exception {
		return productDao.findProductByProdName(prodName);
	}

	@Override
	public Map<String, Object> getProductList(Optional<Search> search) throws Exception {
		if(search.isPresent() && search.get().getSorter().contains("DESC")) {
			sorter = sorter.substring(0, sorter.indexOf("DESC"))+ " DESC";
		}else if(sorter.contains("ASC")) {
			sorter = sorter.substring(0, sorter.indexOf("ASC")) + " ASC";
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<Product> productList = productDao.getProductList(search, sorter, category);
		
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