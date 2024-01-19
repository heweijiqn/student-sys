package com.yizhi.common.task;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.yizhi.common.config.yizhiConfig;
import com.yizhi.common.dao.LogDao;
import com.yizhi.common.utils.FileUtil;
import com.yizhi.system.dao.UserDao;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class clearLogJob implements Job{
	
	@Autowired
	LogDao logDao;
	
	
	@Autowired
	UserDao userDao;
	
	@Autowired
	private yizhiConfig yizhiConfig;

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		// TODO Auto-generated method stub
		log.error("清除冗余数据任务开始......");
		
		
		log.error("本次清除结束");
		
	}

}
