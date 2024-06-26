package com.model2.mvc.web.user;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Paginate;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {

	/// Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	/// Constructor
	public UserController() {
		System.out.println("==> UserController default Constructor call");
	}
	
	@RequestMapping(value="addUser", method = RequestMethod.GET)
	public String addUser() throws Exception {

		System.out.println("/user/addUser: GET");
		
		return "redirect:/user/addUserView.jsp";
	}

	@RequestMapping(value="addUser", method = RequestMethod.POST)
	public String addUser(@ModelAttribute("user") User user) throws Exception {

		System.out.println("/user/addUser: POST");
		
		userService.addUser(user);

		return "redirect:/user/loginView.jsp";
	}

	@RequestMapping(value="getUser/{userId}", method = RequestMethod.GET)
	public String getUser(@PathVariable("userId") String userId, Model model) throws Exception {

		System.out.println("/user/getUser: GET");
		
		User findUser = userService.getUser(userId);
		
		model.addAttribute("user", findUser);

		return "/user/getUser.jsp";
	}
	
	@RequestMapping(value="updateUser/{userId}" , method = RequestMethod.GET)
	public String updateUser(@PathVariable("userId") String userId, Model model) throws Exception {
		
		System.out.println("/user/updateUser : GET");
		
		User findUser = userService.getUser(userId);
		
		model.addAttribute("user", findUser);

		return "/user/updateUser.jsp";
	}
	
	@RequestMapping(value="updateUser", method = RequestMethod.POST)
	public String updateUser(@ModelAttribute("user") User user, Model model, HttpSession session) throws Exception {

		System.out.println("/user/updateUser : POST");
		
		userService.updateUser(user);
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", userService.getUser(sessionId));
		}

		return "redirect:/user/getUser/"+user.getUserId();
	}
	
	@RequestMapping(value="login", method = RequestMethod.GET)
	public String login() throws Exception{
		
		System.out.println("/user/login");

		return "redirect:/user/loginView.jsp";
	}
	
	@RequestMapping(value= "login", method = RequestMethod.POST)
	public String login(@ModelAttribute("user") User user, HttpSession session) throws Exception {

		System.out.println("/user/login: POST");
		
		User dbUser = userService.loginUser(user);
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}

		return "redirect:/index.jsp";
	}
	
	@RequestMapping(value="logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		System.out.println("/user/logout");

		session.removeAttribute("user");

		return "redirect:/index.jsp";
	}
	
	@RequestMapping(value= "checkDuplication", method = RequestMethod.POST)
	public String checkDuplication( @RequestParam("userId") String userId , Model model ) throws Exception{

		System.out.println("/user/checkDuplication : POST");
		
		boolean result=userService.checkDuplication(userId);
		
		model.addAttribute("result", new Boolean(result));
		model.addAttribute("userId", userId);

		return "forward:/user/checkDuplication.jsp";
	}
	
	@RequestMapping(value="listUser")
	public String listUser(@ModelAttribute("serach") Search search, Model model) throws Exception {

		System.out.println("/user/listUser : GET / POST");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		search.setPageSize(pageSize);
		
		Map<String, Object> map = userService.getUserList(search);

		Paginate resultPage = new Paginate(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "forward:/user/listUser.jsp";
	}
}