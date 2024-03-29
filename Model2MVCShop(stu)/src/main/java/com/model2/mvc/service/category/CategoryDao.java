package com.model2.mvc.service.category;

import java.util.Map;

import com.model2.mvc.service.domain.Category;

public interface CategoryDao {

	//insert
	public void addCategory(Category category) throws Exception;
	
	//selectOne
	public Category findCategory(int categoryNo) throws Exception;
	
	//selectList
	public Map<String, Object> getCategoryList() throws Exception;
}