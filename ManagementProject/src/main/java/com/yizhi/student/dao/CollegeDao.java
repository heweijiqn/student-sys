package com.yizhi.student.dao;

import com.yizhi.student.domain.CollegeDO;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

/**
 * 学院（部或系）表
 * @author dunhf
 * @email 499345515@qq.com
 * @date 2019-07-26 14:33:37
 */
@Mapper
public interface CollegeDao {

	CollegeDO get(Integer id);
	
	List<CollegeDO> list(Map<String,Object> map);
	
	int count(Map<String,Object> map);
	
	int save(CollegeDO college);
	
	int update(CollegeDO college);
	
	int remove(Integer id);
	
	int batchRemove(Integer[] ids);
}
