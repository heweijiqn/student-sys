package com.yizhi.common.domain;

import java.io.Serializable;
import java.util.Date;

public class FrontUser implements Serializable{
    private static final long serialVersionUID = 1L;
    private String  userid;//用户id
    private String  username;//用户昵称
    private String  headimg;// '头像',
    private String  sex;// '性别',
    private String  lastip;// '最后登录ip',
    private String  lasttime;// '最新登录时间',
    private String  regtime;// '注册时间',
    private String  password;// '密码',
    private String  score;// '积分',
    private String  consumeScore;// '可用消费积分',
    private String  agentTypeId;// '所属代理级别暂时不用，不要显示',
    private String  pAgetid;// '暂时不用',
    private String  bAgentid;// '暂时不用',
    private String  sid;// '所属商户id',
    private String  figureurl;//临时用来存储第三方头像地址
    public String getUserid() {
        return userid;
    }
    public OpenUser openUser;
    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getHeadimg() {
        return headimg;
    }

    public void setHeadimg(String headimg) {
        this.headimg = headimg;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getLastip() {
        return lastip;
    }

    public void setLastip(String lastip) {
        this.lastip = lastip;
    }

    public String getLasttime() {
        return lasttime;
    }

    public void setLasttime(String lasttime) {
        this.lasttime = lasttime;
    }

    public String getRegtime() {
        return regtime;
    }

    public void setRegtime(String regtime) {
        this.regtime = regtime;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getConsumeScore() {
        return consumeScore;
    }

    public void setConsumeScore(String consumeScore) {
        this.consumeScore = consumeScore;
    }

    public String getAgentTypeId() {
        return agentTypeId;
    }

    public void setAgentTypeId(String agentTypeId) {
        this.agentTypeId = agentTypeId;
    }

    public String getpAgetid() {
        return pAgetid;
    }

    public void setpAgetid(String pAgetid) {
        this.pAgetid = pAgetid;
    }

    public String getbAgentid() {
        return bAgentid;
    }

    public void setbAgentid(String bAgentid) {
        this.bAgentid = bAgentid;
    }

    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }

    public String getFigureurl() {
        return figureurl;
    }

    public void setFigureurl(String figureurl) {
        this.figureurl = figureurl;
    }

    public OpenUser getOpenUser() {
        return openUser;
    }

    public void setOpenUser(OpenUser openUser) {
        this.openUser = openUser;
    }
}
