package com.yizhi.oa.dao;

import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Component;

import com.yizhi.common.domain.OpenUser;

@Mapper
@Component
public interface OpenUserDao{
    @Select("select * from dd_openuser where (openid=#{openid} and type=#{opentype.value}) or (uuid=#{uuid} and type=#{opentype.value}) limit 1")
    public OpenUser findUser(OpenUser openUser) ;
    @Update("update dd_openuser set headimg=#{avatarUrl},username=#{nickName} where userid=#{userid}")
    public void updateUser(OpenUser openUser);
    @Insert("insert into dd_openuser(openid,type,oauth_token,oauth_token_secret,userid,addtime,uuid,headimg) values(#{openid},#{opentype.value},#{oauthToken},#{oauthTokenSecret},#{userid},now(),#{uuid},#{avatarUrl})")
    public void save(OpenUser openUser);
}
