package com.yizhi.system.filter;

import com.alibaba.fastjson.JSON;
import com.yizhi.common.domain.Response;
import com.yizhi.common.domain.TokenValidException;
import com.yizhi.miniapp.config.JWTToken;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.web.filter.authc.BasicHttpAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.util.Objects;

public class ApiFilter extends BasicHttpAuthenticationFilter {

    private Logger logger = LoggerFactory.getLogger(this.getClass());


    @Override
    protected boolean isLoginAttempt(ServletRequest request, ServletResponse response) {
        HttpServletRequest req = (HttpServletRequest) request;
        String authorization = req.getHeader("token");
        return authorization != null;
    }

    @Override
    protected boolean executeLogin(ServletRequest request, ServletResponse response) {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        String authorization = httpServletRequest.getHeader("token");
        JWTToken jwtToken = new JWTToken(authorization);

        // 提交给自定义realm进行登入，如果错误他会抛出异常并被捕获
        try {

        getSubject(request, response).login(jwtToken);
        } catch (AuthenticationException ex) {
            Response re=new Response();
            try{
                getSubject(request, response).logout();
                if(ex instanceof TokenValidException){
                    re.setCode("-100");
                    int myCode=1001;
                    HttpServletResponse myresponse=(HttpServletResponse)response;
                    myresponse.setStatus(myCode);
                }else{
                    re.setCode("-100");
                    int myCode=1001;
                    HttpServletResponse myresponse=(HttpServletResponse)response;
                    myresponse.setStatus(myCode);
                }
                re.setMsg("token过期或无效");
                response.reset();
                response.setCharacterEncoding("UTF-8");
                //PrintWriter out = response.getWriter();
                //out.print(JSON.toJSONString(re));
                //out.flush();
                //out.close();
                response.getWriter().print(JSON.toJSONString(re));
            }catch(Exception e){

            }
            return this.onLoginFailure(jwtToken, ex, request, response);
        }

        // 如果没有抛出异常则代表登入成功，返回true
        return  true;
    }

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
//        boolean status=false;
//        if (isLoginAttempt(request, response)) {
//            try {
//                status=executeLogin(request, response);
//            } catch (Exception e) {
//                logger.info(e.getMessage());
//            }
//        }
    	
        return super.isAccessAllowed(request, response, mappedValue) || !this.isLoginRequest(request, response) && this.isPermissive(mappedValue);
        //return status;
    }

    @Override
    protected boolean preHandle(ServletRequest request, ServletResponse response) throws Exception {
        HttpServletRequest servletRequest = (HttpServletRequest) request;
        HttpServletResponse servletResponse = (HttpServletResponse) response;
        servletResponse.setHeader("Access-control-Allow-Origin", servletRequest.getHeader("Origin"));
        servletResponse.setHeader("Access-Control-Allow-Methods", "GET,POST,OPTIONS,PUT,DELETE");
        servletResponse.setHeader("Access-Control-Allow-Headers", servletRequest.getHeader
                ("Access-Control-Request-Headers"));
        if (Objects.equals(servletRequest.getMethod(), RequestMethod.OPTIONS.name())) {
            servletResponse.setStatus(HttpStatus.OK.value());
            return false;
        }else{
        	return super.preHandle(request, response);
        }
    }
    @Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
		boolean loggedIn = false; //false by default or we wouldn't be in this method
        if (isLoginAttempt(request, response)) {
            loggedIn = executeLogin(request, response);
        }
        if (!loggedIn) {
        	 HttpServletResponse res = WebUtils.toHttp(response);  
             res.sendError(HttpServletResponse.SC_UNAUTHORIZED);  
            //sendChallenge(request, response);
        }
		return loggedIn;
	}
     public boolean isAjax(HttpServletRequest request) {
    	 String header = request.getHeader("X-Requested-With");  
    	    boolean isAjax = "XMLHttpRequest".equals(header) ? true:false;  
    	    return isAjax;
     } 	 
}
