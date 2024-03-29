package com.model2.mvc.service.cart.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.service.cart.CartService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
		"classpath:config/context-aspect.xml",
		"classpath:config/context-mybatis.xml",
		"classpath:config/context-transaction.xml" })
public class CartServiceTest {

	//==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;

	//@Test
	public void testInsertCart() throws Exception {
//		Category category = new Category();
//		category.setCategoryName("카테고리테스트");
//		category.setParentCategoryNo(0);
//		categoryService.insertCategory(category);
//		
//		//==> console 확인
//		//System.out.println(user);
//		
//		//==> API 확인
//		Assert.assertEquals("카테고리테스트", category.getCategoryName());
	}
	
	//@Test
	public void testFindCart() throws Exception {
//		Category category = new Category();
//		
//		category = categoryService.findCategory(3003);
//		System.out.println(category);
//
//		Assert.assertEquals("노트북", category.getCategoryName());
	}
	
	 @Test
	 public void testGetCartList() throws Exception{
//		 Map<String, Object> map = categoryService.getCategoryList();
//		 List<Category> list = (List<Category>) map.get("list");
//		 
//		 System.out.println(list);
//		 Assert.assertEquals(10, list.size());
	 }
}