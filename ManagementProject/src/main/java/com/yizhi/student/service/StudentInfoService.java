package com.yizhi.student.service;

import com.yizhi.student.domain.StudentInfoDO;

import java.util.List;
import java.util.Map;

/**
 * 生基础信息表
 * 
 * @author dunhf
 * @email 499345515@qq.com
 * @date 2019-08-01 09:45:46
 */
public interface StudentInfoService {
	
	StudentInfoDO get(Integer id);
	
	List<StudentInfoDO> list(Map<String, Object> map);
	
	int count(Map<String, Object> map);
	
	int save(StudentInfoDO studentInfo);
	
	int update(StudentInfoDO studentInfo);
	
	int remove(Integer id);
	
	int batchRemove(Integer[] ids);
}
