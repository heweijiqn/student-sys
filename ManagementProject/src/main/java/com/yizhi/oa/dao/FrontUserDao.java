package com.yizhi.oa.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

import com.yizhi.common.domain.FrontUser;

/**
 * 前端用户管理MAPPER接口
 * @author 侯文华
 * @version 2018-04-26
 */
@Mapper
@Component
public interface FrontUserDao  {
    public void updateBindUser(FrontUser user);
    public void addBind(FrontUser user);
}
