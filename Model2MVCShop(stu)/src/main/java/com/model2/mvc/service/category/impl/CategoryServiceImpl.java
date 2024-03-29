package com.model2.mvc.service.category.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.domain.Category;
import com.model2.mvc.service.category.CategoryDao;
import com.model2.mvc.service.category.CategoryService;

@Service("categoryServiceImpl")
public class CategoryServiceImpl implements CategoryService {
	
	///Field
	@Autowired
	@Qualifier("categoryDaoImpl")
	private CategoryDao categoryDao;

	///Constructor
	public CategoryServiceImpl() {
	}

	///Method
	@Override
	public void addCategory(Category category) throws Exception {
		categoryDao.addCategory(category);
	}

	@Override
	public Map<String, Object> getCategoryList() throws Exception {
		return categoryDao.getCategoryList();
	}

	@Override
	public Category findCategory(int categoryNo) throws Exception {
		return categoryDao.findCategory(categoryNo);
	}
}