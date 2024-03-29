package com.model2.mvc.service.user;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;

public interface UserDao {
	
	//insert
	public void addUser(User user) throws Exception ;

	//selectOne
	public User findUser(String userId) throws Exception ;
	
	public int getTotalCount(Search search) throws Exception ;

	//selectList
	public List<User> getUserList(Search search) throws Exception ;

	//update
	public int updateUser(User user) throws Exception ;
}