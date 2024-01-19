package com.yizhi.system.shiro;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.yizhi.common.config.ApplicationContextRegister;
import com.yizhi.common.config.Constant;
import com.yizhi.common.utils.ShiroUtils;
import com.yizhi.system.dao.UserDao;
import com.yizhi.system.domain.UserDO;
import com.yizhi.system.service.MenuService;

public class UserRealm extends AuthorizingRealm {
/*	@Autowired
	UserDao userMapper;
	@Autowired
	MenuService menuService;*/

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection arg0) {
		Long userId = ShiroUtils.getUserId();
		MenuService menuService = ApplicationContextRegister.getBean(MenuService.class);
		Set<String> perms = menuService.listPerms(userId);
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		info.setStringPermissions(perms);
		return info;
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		CustomizedToken uToken=(CustomizedToken)token;
		Map<String, Object> map = new HashMap<>(16);
		UserDao userMapper = ApplicationContextRegister.getBean(UserDao.class);
		
		
		if (uToken.getLoginType().equals(Constant.LOGIN_TYPE_WECHAT)) {
			map.put("gzhOpenid", (String) token.getPrincipal());
			List<UserDO>  users= userMapper.list(map);
			if (users .size()<=0) {
				throw new UnknownAccountException("账号不存在");
			}
			UserDO user = users.get(0);
			if (user.getStatus() == 0) {
				throw new LockedAccountException("账号已被锁定,请联系管理员");
			}
			SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user, "", getName());
			return info;
		}
		
		String username = (String) token.getPrincipal();
		map.clear();
		map.put("username", username);
		String password = new String((char[]) token.getCredentials());
		
		// 查询用户信息
		List<UserDO>  users= userMapper.list(map);

		// 账号不存在
		if (users .size()<=0) {
			throw new UnknownAccountException("账号不存在");
		}
		UserDO user = users.get(0);
		
		// 密码错误
		if (!password.equals(user.getPassword())) {
			throw new IncorrectCredentialsException("密码不正确");
		}

		// 账号锁定
		if (user.getStatus() == 0) {
			throw new LockedAccountException("账号已被锁定,请联系管理员");
		}
		SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user, password, getName());
		return info;
	}

}
