package com.yizhi.common.utils;
/**
 * @author houwenhua
 * @version 1.0
 */
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;


public class CookieUtil {
	/**
	 * �õ�cookie
	 * @param cookies
	 * @param name
	 * @return
	 */
	public static String getCookieValue(Cookie[] cookies,String name){
		if(cookies!=null)
		for(Cookie c:cookies){
			if(c.getName().equals(name))
				return c.getValue();
		}
		return null;
	}
	/**
	 * �õ�cookie
	 * @param cookies
	 * @param name
	 * @return
	 */
	public static Cookie getCookie(Cookie[] cookies,String name){
		if(cookies!=null){
			for(Cookie c:cookies){
				if(c.getName().equals(name))
					return c;
			}
		}
		return null;
	}
}
