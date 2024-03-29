package com.model2.mvc.service.user;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;

public interface UserService {
	
	//insert
	public void addUser(User user) throws Exception;
	
	//selectOne
	public User loginUser(User user) throws Exception;
	
	public User getUser(String userId) throws Exception;
	
	//selectList
	public Map<String, Object> getUserList(Search search) throws Exception;
	
	//update
	public void updateUser(User user) throws Exception;
	
	//etc
	public boolean checkDuplication(String userId) throws Exception;
}