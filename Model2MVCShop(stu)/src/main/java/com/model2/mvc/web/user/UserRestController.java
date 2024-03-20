package com.model2.mvc.web.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	public Map addUser(@RequestBody User user) throws Exception {

		System.out.println("/user/json/addUser: POST");
		Map map = new HashMap();
		
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
	public Map getUser(@PathVariable("userId") String userId) throws Exception {

		System.out.println("/user/json/getUser: GET");

		Map map = new HashMap();
		
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
	public Map updateUser(@PathVariable("userId") String userId) throws Exception {
		
		System.out.println("/user/json/updateUser : GET");

		Map map = new HashMap();
		
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
	public Map updateUser(@RequestBody User user, HttpSession session) throws Exception {

		System.out.println("/user/json/updateUser : POST");

		Map map = new HashMap();
		
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
	public Map login(@RequestBody User user) throws Exception {

		System.out.println("/user/json/login: POST");

		Map map = new HashMap();
		
		try {
			User dbUser = userService.loginUser(user);
			
			map.put("message", "ok");
		}catch (Exception e) {
			map.put("message", "fail");
		}
		
		return map;
	}
	
	@RequestMapping(value="json/logout", method = RequestMethod.GET)
	public Map logout(HttpSession session) {
		System.out.println("/user/json/logout");

		session.removeAttribute("user");
		
		Map map = new HashMap();
		map.put("message", "ok");
		
		return map;
	}
	
	@RequestMapping(value= "json/checkDuplication", method = RequestMethod.POST)
	public Map checkDuplication(@RequestBody String userId) throws Exception{

		System.out.println("/user/json/checkDuplication : POST");
		
		boolean result=userService.checkDuplication(userId);

		Map map = new HashMap();
		map.put("message", "ok");
		map.put("result", new Boolean(result));
		map.put("userId", userId);
		
		return map;
	}
	
	@RequestMapping(value="json/listUser")
	public Map listUser(@ModelAttribute("serach") Search search) throws Exception {

		System.out.println("/user/json/listUser : GET / POST");
		
		int currentPage = 1;
		if (search.getCurrentPage() != 0 && search.getSearchKeyword().equals("")) {
			currentPage = search.getCurrentPage();
		}

		search.setCurrentPage(currentPage);
		search.setSearchCondition(search.getSearchCondition());
		search.setSearchKeyword(search.getSearchKeyword());

		search.setPageSize(pageSize);
		
		Map<String, Object> mapList = userService.getUserList(search);

		Paginate resultPage = new Paginate(currentPage, ((Integer) mapList.get("totalCount")).intValue(), pageUnit, pageSize);

		Map map = new HashMap();
		map.put("message", "ok");
		map.put("list", mapList.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
}