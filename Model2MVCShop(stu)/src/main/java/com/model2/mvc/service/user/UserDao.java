package com.model2.mvc.service.user;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;

public interface UserDao {
	
	public void insertUser(User user) throws Exception ;

	// SELECT ONE
	public User findUser(String userId) throws Exception ;

	// SELECT LIST
	public List<User> getUserList(Search search) throws Exception ;

	// UPDATE
	public int updateUser(User user) throws Exception ;
	
	//ÃÑ °¹¼ö
	public int getTotalCount(Search search) throws Exception ;

	public List<User> getAllUserList() throws Exception ;
}
