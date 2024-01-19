package com.yizhi.common.domain;

import org.apache.shiro.ShiroException;
import org.apache.shiro.authc.AuthenticationException;

public class TokenValidException  extends AuthenticationException {

    public TokenValidException() {
        super();
    }

    /**
     * Constructs a new AuthenticationException.
     *
     * @param message the reason for the exception
     */
    public TokenValidException(String message) {
        super(message);
    }
}
