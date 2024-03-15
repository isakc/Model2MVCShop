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
		System.out.println("받은 데이터: " + user);
		
		userService.addUser(user);
		
		Map map = new HashMap();
		map.put("user", user);
		map.put("message", "ok");
		
		return map;
	}

	@RequestMapping(value="json/getUser/{userId}", method = RequestMethod.GET)
	public Map getUser(@PathVariable("userId") String userId) throws Exception {

		System.out.println("/user/json/getUser: GET");
		
		User findUser = userService.getUser(userId);
		
		Map map = new HashMap();
		map.put("user", findUser);
		map.put("message", "ok");
		
		return map;
	}
	
	@RequestMapping(value="json/updateUser/{userId}" , method = RequestMethod.GET)
	public Map updateUser(@PathVariable("userId") String userId) throws Exception {
		
		System.out.println("/user/json/updateUser : GET");
		
		User findUser = userService.getUser(userId);

		Map map = new HashMap();
		map.put("user", findUser);
		map.put("message", "ok");
		
		return map;
	}
	
	@RequestMapping(value="json/updateUser", method = RequestMethod.POST)
	public String updateUser(@ModelAttribute("user") User user, Model model, HttpSession session) throws Exception {

		System.out.println("/user/json/updateUser : POST");
		
		userService.updateUser(user);
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", user);
		}

		return "redirect:/user/getUser/"+user.getUserId();
	}
	
	@RequestMapping(value="json/login", method = RequestMethod.GET)
	public String login() throws Exception{
		
		System.out.println("/user/json/login");

		return "redirect:/user/loginView.jsp";
	}
	
	@RequestMapping(value= "json/login", method = RequestMethod.POST)
	public String login(@ModelAttribute("user") User user, HttpSession session) throws Exception {

		System.out.println("/user/json/login: POST");
		
		User dbUser = userService.loginUser(user);
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}

		return "redirect:/index.jsp";
	}
	
	@RequestMapping(value="json/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		System.out.println("/user/json/logout");

		session.removeAttribute("user");

		return "redirect:/index.jsp";
	}
	
	@RequestMapping(value= "json/checkDuplication", method = RequestMethod.POST)
	public String checkDuplication( @RequestParam("userId") String userId , Model model ) throws Exception{

		System.out.println("/user/json/checkDuplication : POST");
		
		boolean result=userService.checkDuplication(userId);
		
		model.addAttribute("result", new Boolean(result));
		model.addAttribute("userId", userId);

		return "forward:/user/checkDuplication.jsp";
	}
	
	@RequestMapping(value="json/listUser")
	public String listUser(@ModelAttribute("serach") Search search, Model model) throws Exception {

		System.out.println("/user/json/listUser : GET / POST");
		
		int currentPage = 1;
		if (search.getCurrentPage() != 0 && search.getSearchKeyword().equals("")) {
			currentPage = search.getCurrentPage();
		}

		search.setCurrentPage(currentPage);
		search.setSearchCondition(search.getSearchCondition());
		search.setSearchKeyword(search.getSearchKeyword());

		search.setPageSize(pageSize);
		
		Map<String, Object> map = userService.getUserList(search);

		Paginate resultPage = new Paginate(currentPage, ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "forward:/user/listUser.jsp";
	}
}
