package com.model2.mvc.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserDao;
import com.model2.mvc.service.user.UserService;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService {
	
	///Field
	@Autowired
	@Qualifier("userDaoImpl")
	UserDao userDAO;

	///Constructor
	public UserServiceImpl() {
	}

	public void addUser(User user) throws Exception {
		userDAO.insertUser(user);
	}

	public User loginUser(User user) throws Exception {
		User dbUser=userDAO.findUser(user.getUserId());

			if(! dbUser.getPassword().equals(user.getPassword()))
				throw new Exception("로그인에 실패했습니다.");
			
			return dbUser;
	}

	public User getUser(String userId) throws Exception {
		return userDAO.findUser(userId);
	}

	public Map<String,Object> getUserList(Search search) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", userDAO.getUserList(search));
		map.put("totalCount", userDAO.getTotalCount(search));
	
		return map;
	}

	public void updateUser(User user) throws Exception {
		userDAO.updateUser(user);
	}

	public boolean checkDuplication(String userId) throws Exception {
		boolean result=true;
		User userVO=userDAO.findUser(userId);
		if(userVO != null) {
			result=false;
		}
		return result;
	}

	@Override
	public String[] getAllUserList(int searchCondition) throws Exception {
		List<User> list = userDAO.getAllUserList();
		String[] array = new String[list.size()];
		
		for(int i=0; i<list.size(); i++) {
			if(searchCondition == 0) {
				array[i] = list.get(i).getUserId();
			}else {
				array[i] = list.get(i).getUserName();
			}
		}
		
		return array;
	}
}
