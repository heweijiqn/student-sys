package com.yizhi.student.service;

import com.yizhi.student.domain.CollegeDO;

import java.util.List;
import java.util.Map;

/**
 * 学院（部或系）表
 * 
 * @author dunhf
 * @email 499345515@qq.com
 * @date 2019-07-26 14:33:37
 */
public interface CollegeService {
	
	CollegeDO get(Integer id);
	
	List<CollegeDO> list(Map<String, Object> map);
	
	int count(Map<String, Object> map);
	
	int save(CollegeDO college);
	
	int update(CollegeDO college);
	
	int remove(Integer id);
	
	int batchRemove(Integer[] ids);
}
