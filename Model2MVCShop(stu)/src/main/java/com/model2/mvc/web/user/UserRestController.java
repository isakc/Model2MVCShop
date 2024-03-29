package com.model2.mvc.web.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Paginate;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;

@RestController
@RequestMapping("/user/*")
public class UserRestController {

	/// Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	/// Constructor
	public UserRestController() {
		System.out.println(this.getClass());
	}

	@RequestMapping(value="json/addUser", method = RequestMethod.POST)
	public Map<String, Object> addUser(@RequestBody User user) throws Exception {

		System.out.println("/user/json/addUser: POST");
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			userService.addUser(user);
			map.put("user", user);
			map.put("message", "ok");
		}catch(Exception e) {
			map.put("message", "fail");
		}
		
		return map;
	}

	@RequestMapping(value="json/getUser/{userId}", method = RequestMethod.GET)
	public Map<String, Object> getUser(@PathVariable("userId") String userId) throws Exception {

		System.out.println("/user/json/getUser: GET");

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			User findUser = userService.getUser(userId);
			
			map.put("user", findUser);
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}
		
		return map;
	}
	
	@RequestMapping(value="json/updateUser/{userId}" , method = RequestMethod.GET)
	public Map<String, Object> updateUser(@PathVariable("userId") String userId) throws Exception {
		
		System.out.println("/user/json/updateUser : GET");

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			User findUser = userService.getUser(userId);

			map.put("user", findUser);
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}
		
		return map;
	}
	
	@RequestMapping(value="json/updateUser", method = RequestMethod.POST)
	public Map<String, Object> updateUser(@RequestBody User user, HttpSession session) throws Exception {

		System.out.println("/user/json/updateUser : POST");

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			userService.updateUser(user);
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", user);
		}
		
		return map;
	}
	
	@RequestMapping(value= "json/login", method = RequestMethod.POST)
	public Map<String, Object> login(@RequestBody User user, HttpSession session) throws Exception {

		System.out.println("/user/json/login: POST");

		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			User dbUser = userService.loginUser(user);
			session.setAttribute("user", dbUser);
			
			map.put("user", dbUser);
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}
		
		return map;
	}
	
	@RequestMapping(value="json/logout", method = RequestMethod.GET)
	public Map<String, Object> logout(HttpSession session) {
		System.out.println("/user/json/logout");

		Map<String, Object> map = new HashMap<String, Object>();
		try {
			session.removeAttribute("user");
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}
		
		return map;
	}
	
	@RequestMapping(value= "json/checkDuplication", method = RequestMethod.POST)
	public Map<String, Object> checkDuplication(@RequestBody String userId) throws Exception{

		System.out.println("/user/json/checkDuplication : POST");

		Map<String, Object> map = new HashMap<String, Object>();
		try {
			boolean result=userService.checkDuplication(userId);

			map.put("message", "ok");
			map.put("result", new Boolean(result));
			map.put("userId", userId);
		}catch (Exception e) {
			map.put("message", "fail");
		}
		
		return map;
	}
	
	@RequestMapping(value="json/listUser")
	public Map<String, Object> listUser(@RequestBody Search search) throws Exception {

		System.out.println("/user/json/listUser : GET / POST");

		Map<String, Object> map = new HashMap<String, Object>();
		
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		if(search.getPageSize() == 0) {
			search.setPageSize(pageSize);
		}
		
		try {

			Map<String, Object> mapList = userService.getUserList(search);

			Paginate resultPage = new Paginate(search.getCurrentPage(), ((Integer) mapList.get("totalCount")).intValue(), pageUnit, pageSize);

			map.put("message", "ok");
			map.put("list", mapList.get("list"));
			map.put("resultPage", resultPage);
			map.put("search", search);
		}catch (Exception e) {
			map.put("message", "fail");
		}
		
		return map;
	}
}