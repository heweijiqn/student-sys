package com.yizhi.common.config;

public class Constant {
	//本系统名称(必该，涉及到缓存名前缀)
    public static final  String SYSTEM_NAME = "yizhi";
	
    //演示系统账户
    public static String DEMO_ACCOUNT = "test";
    //自动去除表前缀
    public static String AUTO_REOMVE_PRE = "true";
    //停止计划任务
    public static String STATUS_RUNNING_STOP = "stop";
    //开启计划任务
    public static String STATUS_RUNNING_START = "start";
    //通知公告阅读状态-未读
    public static String OA_NOTIFY_READ_NO = "0";
    //通知公告阅读状态-已读
    public static int OA_NOTIFY_READ_YES = 1;
    //部门根节点id
    public static Long DEPT_ROOT_ID = 0l;
    //缓存方式
    public static String CACHE_TYPE_REDIS ="redis";

    public static String LOG_ERROR = "error";
    
    public static String LOGIN_TYPE_WECHAT="WECHAT";
    
    public static String LOGIN_TYPE_PC="PC";

    
}
