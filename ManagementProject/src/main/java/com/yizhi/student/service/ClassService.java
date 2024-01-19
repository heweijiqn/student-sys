package com.yizhi.student.service;

import com.yizhi.student.domain.ClassDO;

import java.util.List;
import java.util.Map;

/**
 * 班级表
 * 
 * @author dunhf
 * @email 499345515@qq.com
 * @date 2019-07-29 14:20:37
 */
public interface ClassService {
	
	ClassDO get(Integer id);
	
	List<ClassDO> list(Map<String, Object> map);
	
	int count(Map<String, Object> map);
	
	int save(ClassDO classt);
	
	int update(ClassDO classt);
	
	int remove(Integer id);
	
	int batchRemove(Integer[] ids);
}
