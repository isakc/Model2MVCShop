package com.model2.mvc.service.category;

import java.util.Map;

import com.model2.mvc.service.domain.Category;

public interface CategoryService {

	public void insertCategory(Category Category) throws Exception;

	public Category findCategory(int categoryNo) throws Exception;

	public Map<String, Object> getCategoryList() throws Exception;
}