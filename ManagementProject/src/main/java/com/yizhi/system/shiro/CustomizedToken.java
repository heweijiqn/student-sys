package com.yizhi.system.shiro;

import org.apache.shiro.authc.UsernamePasswordToken;

import com.yizhi.common.config.Constant;

public class CustomizedToken extends UsernamePasswordToken {

    //登录类型，判断是普通用户登录，教师登录还是管理员登录
    private String loginType;

    public CustomizedToken(final String username, final String password,String loginType) {
        super(username,password);
        this.loginType = loginType;
    }
    
    public CustomizedToken(final String username, final String password) {
        super(username,password);
        this.loginType = Constant.LOGIN_TYPE_PC;
    }
    
    public CustomizedToken(final String openid){
    	super(openid,"",false,null);
    	this.loginType=Constant.LOGIN_TYPE_WECHAT;
    }

    public String getLoginType() {
        return loginType;
    }

    public void setLoginType(String loginType) {
        this.loginType = loginType;
    }
}
