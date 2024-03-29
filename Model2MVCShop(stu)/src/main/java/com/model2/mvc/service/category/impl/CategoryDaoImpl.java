package com.model2.mvc.service.category.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.service.category.CategoryDao;
import com.model2.mvc.service.domain.Category;

@Repository("categoryDaoImpl")
public class CategoryDaoImpl implements CategoryDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public CategoryDaoImpl() {
	}

	public void insertCategory(Category category) throws Exception {
		sqlSession.insert("CategoryMapper.insertCategory" ,category);
	}

	public Category findCategory(int categoryNo) throws Exception {
		return sqlSession.selectOne("CategoryMapper.findCategory", categoryNo);
	}

	public Map<String, Object> getCategoryList() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", sqlSession.selectList("CategoryMapper.getCategoryList"));
		return map;
	}
}
