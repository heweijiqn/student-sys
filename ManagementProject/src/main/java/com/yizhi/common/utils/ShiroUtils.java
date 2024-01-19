package com.yizhi.common.utils;

import java.util.ArrayList;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;

import com.yizhi.common.domain.WeixinUserPrincipal;
import com.yizhi.system.domain.UserDO;

public class ShiroUtils {
	public static Subject getSubjct() {
		return SecurityUtils.getSubject();
	}
	public static UserDO getUser() {
		if(getSubjct().getPrincipal() instanceof WeixinUserPrincipal) {
			UserDO user=new UserDO();
			 WeixinUserPrincipal member = (WeixinUserPrincipal) getSubjct().getPrincipal();
			 user.setUserId(Long.parseLong(member.getUserid()));
			 user.setUsername(member.getUsername());
			 user.setName(member.getUsername());
			 List<Long> roleIds=new ArrayList<>();
			 roleIds.add(member.getRoleid());
			 user.setroleIds(roleIds);
			return user;
		}else {
			return (UserDO)getSubjct().getPrincipal();
		}
		
	}
	public static Long getUserId() {
		return getUser().getUserId();
	}
	public static void logout() {
		getSubjct().logout();
	}
}
