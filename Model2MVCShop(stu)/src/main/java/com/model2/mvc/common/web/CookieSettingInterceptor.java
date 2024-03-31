package com.model2.mvc.common.web;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class CookieSettingInterceptor extends HandlerInterceptorAdapter {
	
	///Constructor
	public CookieSettingInterceptor(){
		System.out.println("\nCommon :: "+this.getClass()+"\n");		
	}
	
	///Method
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		System.out.println("\n[ CookieSettingInterceptor start........]");
		
		String uri = request.getRequestURI();
		String prodNo = uri.split("/")[3];

		Cookie[] cookies = request.getCookies();
		String value = null;

		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("history")) {
					value = cookie.getValue();
				}
			}
		}

		if (value == null || value.isEmpty()) {
			value = String.valueOf(prodNo);
		} else {
			if (!value.contains(String.valueOf(prodNo))) {
				value += "/" + String.valueOf(prodNo);
			}
		}

		Cookie cookie = new Cookie("history", value);
		cookie.setMaxAge(60 * 60 * 24);
		cookie.setPath("/");
		cookie.setHttpOnly(true);
		cookie.setSecure(true);
		response.addCookie(cookie);

		return true;
	}
}//end of class